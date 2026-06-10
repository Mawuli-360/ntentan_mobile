import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/widgets/app_header.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/controllers/med_scanner_controller.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/state/med_scanner_state.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/widgets/camera_viewfinder.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/widgets/scan_result_panel.dart';

class CameraReaderScreen extends StatefulWidget {
  final bool showHeader;
  const CameraReaderScreen({super.key, this.showHeader = false});

  @override
  State<CameraReaderScreen> createState() => _CameraReaderScreenState();
}

class _CameraReaderScreenState extends State<CameraReaderScreen> {
  late final MedScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I<MedScannerController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final onboarding = context.read<ProfileController>();
      _controller.setLanguage((onboarding.state.profile?.selectedLanguage ?? "English"));
      _initScanner();
    });
  }

  Future<void> _initScanner() async {
    await _controller.initCameraAndService();
    if (mounted && _controller.state.phase != ScanPhase.error) {
      _controller.startScanning();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar:
          widget.showHeader ? const AppHeader(title: 'Scan Medicine') : null,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return SafeArea(
              child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CameraViewfinder(
                  controller: _controller.cameraController,
                  state: _controller.state,
                ),
              ),
              Expanded(
                flex: 2,
                child: ScanResultPanel(state: _controller.state),
              ),
            ],
          ));
        },
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (!_controller.state.isCameraReady) return const SizedBox.shrink();
          return FloatingActionButton(
            backgroundColor: AppColors.vi,
            foregroundColor: Colors.white,
            onPressed: _controller.toggleFlash,
            child: Icon(
              _controller.state.isFlashOn ? Icons.flash_on : Icons.flash_off,
            ),
          );
        },
      ),
    );
  }
}
