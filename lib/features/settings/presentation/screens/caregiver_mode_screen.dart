import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/settings/presentation/widgets/caregiver_med_header.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_time_selector.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_quantity_selector.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_med_field.dart';

import 'package:ntentan/features/settings/presentation/widgets/caregiver_frequency_selector.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_section.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_dose_calculator.dart';
import 'package:ntentan/features/settings/presentation/widgets/caregiver_save_button.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:provider/provider.dart';

/// Caregiver Mode — Phase 4 Redesign
/// Specialized interface for caregivers to input medications.
class CaregiverModeScreen extends StatefulWidget {
  final Medication? initialMedication;

  const CaregiverModeScreen({super.key, this.initialMedication});

  @override
  State<CaregiverModeScreen> createState() => _CaregiverModeScreenState();
}

class _CaregiverModeScreenState extends State<CaregiverModeScreen> {
  int _frequencyPerDay = 1;
  Set<MedTimeSlot> _selectedSlots = {MedTimeSlot.morning};
  int _unitsPerDose = 1;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialMedication != null) {
      final med = widget.initialMedication!;
      _nameController.text = med.name;
      _strengthController.text = med.strength.isNotEmpty ? med.strength : med.dosage;
      _instructionController.text = med.instruction;
      _selectedSlots = med.timeSlots.toSet();
      _frequencyPerDay = med.frequency;
      _unitsPerDose = med.unitsPerDose;

      // Fallback for legacy data that might not have frequency/units
      if (_unitsPerDose == 1 && _strengthController.text.contains('unit(s)')) {
        final match = RegExp(r'^(\d+) unit\(s\)$').firstMatch(_strengthController.text);
        if (match != null) {
          _unitsPerDose = int.tryParse(match.group(1) ?? '1') ?? 1;
          _strengthController.clear();
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _instructionController.dispose();
    _strengthController.dispose();
    super.dispose();
  }

  void _applyFrequencyDefaults(int frequency) {
    setState(() {
      _frequencyPerDay = frequency;
      switch (frequency) {
        case 1:
          _selectedSlots = {MedTimeSlot.morning};
          break;
        case 2:
          _selectedSlots = {MedTimeSlot.morning, MedTimeSlot.evening};
          break;
        case 3:
          _selectedSlots = {
            MedTimeSlot.morning,
            MedTimeSlot.afternoon,
            MedTimeSlot.evening
          };
          break;
        case 4:
          _selectedSlots = {
            MedTimeSlot.morning,
            MedTimeSlot.afternoon,
            MedTimeSlot.evening,
            MedTimeSlot.night
          };
          break;
        case 0: // as needed
          _selectedSlots = {MedTimeSlot.asNeeded};
          break;
        default:
          _selectedSlots = {MedTimeSlot.morning};
      }
    });
  }

  String get _totalDailyDose {
    final strengthText = _strengthController.text.trim();
    if (strengthText.isEmpty || _frequencyPerDay == 0) return '';
    // Extract numeric part (e.g. "500mg" → 500)
    final numeric =
        double.tryParse(strengthText.replaceAll(RegExp(r'[^0-9.]'), ''));
    final unit = strengthText.replaceAll(RegExp(r'[0-9.]'), '').trim();
    if (numeric == null) return '';
    final total = numeric * _unitsPerDose * _frequencyPerDay;
    return '${total % 1 == 0 ? total.toInt() : total}$unit/day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppHeader(
        title: widget.initialMedication != null
            ? 'Edit Medication'
            : 'Add Medication',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.initialMedication == null) ...[
                const CaregiverMedHeader(),
                const SizedBox(height: AppSizes.space32),
              ],
              CaregiverMedField(
                label: 'Medication Name',
                hint: 'e.g. Metformin',
                icon: Iconsax.mask_1,
                controller: _nameController,
              ),
              const SizedBox(height: AppSizes.space24),

              // --- FREQUENCY ---
              CaregiverSection(
                label: 'Frequency',
                child: CaregiverFrequencySelector(
                  selectedFrequency: _frequencyPerDay,
                  onFrequencySelected: _applyFrequencyDefaults,
                ),
              ),
              const SizedBox(height: AppSizes.space24),

              // --- TIME OF DAY ---
              CaregiverSection(
                label: 'Time of Day',
                subtitle: 'Auto-selected based on frequency. Tap to adjust.',
                spacing: 10,
                child: CaregiverTimeSelector(
                  selectedSlots: _selectedSlots,
                  onSlotToggled: (slot) {
                    setState(() {
                      if (_selectedSlots.contains(slot)) {
                        if (_selectedSlots.length > 1) {
                          _selectedSlots.remove(slot);
                          if (!_selectedSlots.contains(MedTimeSlot.asNeeded)) {
                            _frequencyPerDay =
                                _selectedSlots.length.clamp(1, 4);
                          }
                        }
                      } else {
                        if (slot == MedTimeSlot.asNeeded) {
                          _selectedSlots.clear();
                          _selectedSlots.add(MedTimeSlot.asNeeded);
                          _frequencyPerDay = 0;
                        } else {
                          if (_selectedSlots.contains(MedTimeSlot.asNeeded)) {
                            _selectedSlots.remove(MedTimeSlot.asNeeded);
                          }
                          _selectedSlots.add(slot);
                          _frequencyPerDay = _selectedSlots.length.clamp(1, 4);
                        }
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: AppSizes.space24),

              // --- UNITS PER DOSE + STRENGTH ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: CaregiverSection(
                      label: 'Units/Dose',
                      child: CaregiverQuantitySelector(
                        quantity: _unitsPerDose,
                        onQuantityChanged: (val) =>
                            setState(() => _unitsPerDose = val),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.space16),
                  Expanded(
                    flex: 3,
                    child: CaregiverMedField(
                      label: 'Strength',
                      hint: 'e.g. 500mg',
                      icon: Iconsax.weight_1,
                      controller: _strengthController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // --- TOTAL DAILY DOSE (calculated, read-only) ---
              CaregiverDoseCalculator(totalDailyDose: _totalDailyDose),

              const SizedBox(height: AppSizes.space24),
              CaregiverMedField(
                label: 'Special Instructions',
                hint: 'e.g. Take with food',
                icon: Iconsax.note_2,
                controller: _instructionController,
                maxLines: 2,
              ),
              const SizedBox(height: AppSizes.space40),
              CaregiverSaveButton(
                onPressed: _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      context.showErrorSnackBar('Please enter a medication name');
      return;
    }

    final strength = _strengthController.text.trim();
    final dosage = strength.isEmpty ? '$_unitsPerDose unit(s)' : strength;
    final instruction = _instructionController.text.trim();
    final medicationController = context.read<MedicationController>();

    if (widget.initialMedication != null) {
      // --- Update Mode ---
      final updated = widget.initialMedication!.copyWith(
        name: name,
        dosage: dosage,
        strength: strength,
        unitsPerDose: _unitsPerDose,
        frequency: _frequencyPerDay,
        instruction: instruction,
        timeSlots: _selectedSlots.toList(),
      );
      await medicationController.updateMedication(updated);
      if (mounted) {
        context.showSuccessSnackBar('Medication updated');
        Navigator.pop(context);
      }
    } else {
      // --- Create Mode ---
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final newMed = Medication(
        id: '$timestamp',
        name: name,
        dosage: dosage,
        strength: strength,
        unitsPerDose: _unitsPerDose,
        frequency: _frequencyPerDay,
        timeSlots: _selectedSlots.toList(),
        completedSlots: {},
        instruction: instruction,
        createdAt: DateTime.now(),
      );

      await medicationController.addMedications([newMed]);
      if (mounted) {
        context.showSuccessSnackBar('Medication scheduled successfully!');
        Navigator.pop(context);
      }
    }
  }
}
