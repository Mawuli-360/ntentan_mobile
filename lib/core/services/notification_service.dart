import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/settings/domain/repositories/medication_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

class NotificationService {
  final ProfileRepository _profileRepository;
  final MedicationRepository _medicationRepository;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  NotificationService({
    required ProfileRepository profileRepository,
    required MedicationRepository medicationRepository,
  })  : _profileRepository = profileRepository,
        _medicationRepository = medicationRepository;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleNotificationTap(details.payload);
      },
    );

    // --- CHECK FOR TERMINATED STATE LAUNCH ---
    final details = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _handleNotificationTap(details.notificationResponse?.payload);
    }

    _initialized = true;
  }

  void _handleNotificationTap(String? payload) {
    if (payload == null) return;
    AppLogger.i('Notification tapped with payload: $payload');
  }

  /// Requests notification permissions for iOS and newer Android versions.
  Future<void> requestPermissions() async {
    if (!_initialized) await init();
    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final androidImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  /// Re-syncs all medication reminders based on current Firestore/Local state.
  Future<void> syncReminders() async {
    if (!_initialized) await init();

    // Cancel existing
    await _flutterLocalNotificationsPlugin.cancelAll();

    final profileResult = await _profileRepository.getProfile();
    final profile = profileResult.getOrElse((_) => null);

    if (profile == null || !profile.accessibility.medicationRemindersEnabled) {
      AppLogger.i(
          'NotificationService: Medication reminders disabled. Cleared all.');
      return;
    }

    final medsResult =
        await _medicationRepository.fetchMedications(profile.uid ?? '');
    final meds = medsResult.getOrElse((_) => []);

    if (meds.isEmpty) {
      AppLogger.i('NotificationService: No medications found. Cleared all.');
      return;
    }

    AppLogger.i(
        'NotificationService: Resyncing medication reminders for ${meds.length} medications.');

    int notificationIdCounter = 1000;

    for (var med in meds) {
      for (var slot in med.timeSlots) {
        final tz.TZDateTime? scheduledTime = _getDailyTimeForSlot(slot);
        if (scheduledTime == null) continue;

        notificationIdCounter++;

        await _flutterLocalNotificationsPlugin.zonedSchedule(
          notificationIdCounter,
          'Medication Reminder',
          'It is time to take ${med.dosage} ${med.name}${med.strength.isNotEmpty ? ' (${med.strength})' : ''}',
          scheduledTime,
          _notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: med.id,
        );
      }
    }
    AppLogger.i(
        'NotificationService: Scheduled ${notificationIdCounter - 1000} daily reminders.');
  }

  NotificationDetails _notificationDetails() {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'medication_reminders',
      'Medication Reminders',
      channelDescription: 'Daily alerts for your active medications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );
  }

  /// Maps [MedTimeSlot] to a specific daily schedule.
  tz.TZDateTime? _getDailyTimeForSlot(MedTimeSlot slot) {
    final now = tz.TZDateTime.now(tz.local);

    int hour;
    int minute = 0;

    switch (slot) {
      case MedTimeSlot.morning:
        hour = 8;
        break;
      case MedTimeSlot.afternoon:
        hour = 13;
        break;
      case MedTimeSlot.evening:
        hour = 19;
        break;
      case MedTimeSlot.night:
        hour = 21;
        break;
      case MedTimeSlot.asNeeded:
        return null;
    }

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If the time has already passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
