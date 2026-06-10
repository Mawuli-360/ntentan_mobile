import 'package:flutter_test/flutter_test.dart';
import 'package:ntentan/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:ntentan/features/dashboard/presentation/state/dashboard_state.dart';

void main() {
  late DashboardController controller;

  setUp(() {
    controller = DashboardController();
  });

  group('setNavIndex', () {
    test('should update nav index when within bounds', () {
      controller.setNavIndex(1);
      expect(controller.state.selectedNavIndex, 1);

      controller.setNavIndex(2);
      expect(controller.state.selectedNavIndex, 2);
    });

    test('should not update nav index when out of bounds', () {
      controller.setNavIndex(-1);
      expect(controller.state.selectedNavIndex, 0); // default

      controller.setNavIndex(3);
      expect(controller.state.selectedNavIndex, 0); // default
    });
  });

  group('SessionLifecycleHandler', () {
    test('onSessionStarted should reset nav index to 0', () async {
      controller.setNavIndex(2);
      expect(controller.state.selectedNavIndex, 2);

      await controller.onSessionStarted('user_id');

      expect(controller.state.selectedNavIndex, 0);
    });

    test('onSessionEnded should reset to default state', () async {
      controller.setNavIndex(2);
      
      await controller.onSessionEnded();

      expect(controller.state, const DashboardState());
      expect(controller.state.selectedNavIndex, 0);
    });

    test('onAccountDeleted should call onSessionEnded', () async {
      controller.setNavIndex(1);

      await controller.onAccountDeleted('user_id');

      expect(controller.state, const DashboardState());
      expect(controller.state.selectedNavIndex, 0);
    });
  });
}
