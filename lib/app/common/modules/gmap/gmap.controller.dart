import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GmapController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    mapController!.dispose();
  }

  // ==================== VARIABLES ====================
  late final GoogleMapController? mapController;

  var currentLocation = const LatLng(0.0, 0.0).obs;
  var currentMarker = const Marker(
    markerId: MarkerId('current_marker'),
  ).obs;

  var destinationLocation = const LatLng(0.0, 0.0).obs;
  var destinationMarker = const Marker(
    markerId: MarkerId('destination_marker'),
  ).obs;

  var driverLocation = const LatLng(0.0, 0.0).obs;
  var driverMarker = const Marker(
    markerId: MarkerId('driver_marker'),
  ).obs;

  var initialCameraPosition = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  ).obs;

  // ==================== FUCTIONS ====================
  Future<void> locationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      Get.snackbar("Location Permission",
          "Location access needed to use Maps. You can enable it from app info.");
      openAppSettings();
    } else if (status.isGranted) {
      return;
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    await locationPermission();

    final position = await Geolocator.getCurrentPosition();

    currentLocation(
      LatLng(position.latitude, position.longitude),
    );

    driverMarker(
      Marker(
        markerId: const MarkerId('destination_marker'),
        position: driverLocation(),
      ),
    );

    destinationMarker(
      Marker(
        markerId: const MarkerId('destination_marker'),
        position: destinationLocation(),
      ),
    );

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: driverLocation(),
          zoom: 14.4746,
        ),
      ),
    );

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) {
      currentLocation(LatLng(event.latitude, event.longitude));
      currentMarker(
        Marker(
          markerId: const MarkerId('current_marker'),
          position: currentLocation(),
        ),
      );
    });
  }
}
