import 'package:permission_handler/permission_handler.dart';

class Permission {
  static void requestPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.storage,
      PermissionGroup.location,
    ]);
  }

  static void checkPermission() async {
//    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  }

  static void checkServiceStatus() async {
//    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.location);
  }
}