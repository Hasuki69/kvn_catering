import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/services/remote/delivery.service.dart';
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
    mapController = Completer();
    streamSubscription?.cancel();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();

  Completer<GoogleMapController> mapController = Completer();

  StreamSubscription? streamSubscription;

  var currentLocation = const LatLng(0.0, 0.0).obs;
  var currentMarker = const Marker(
    markerId: MarkerId('current_marker'),
  ).obs;

  var userLocation = const LatLng(0.0, 0.0).obs;
  var userMarker = const Marker(
    markerId: MarkerId('user_marker'),
  ).obs;

  var driverLocation = const LatLng(0.0, 0.0).obs;
  var driverMarker = const Marker(
    markerId: MarkerId('driver_marker'),
  ).obs;

  var initialCameraPosition = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  ).obs;

  var selectedLocation = const LatLng(0.0, 0.0).obs;
  var selectedMarker = const Marker(
    markerId: MarkerId('selected_marker'),
  ).obs;
  var selectedRadius = 100.0.obs;

  var isMyLocation = true.obs;
  var co = 0;

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

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
    mapController.complete(controller);

    await locationPermission();

    streamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) async {
      currentLocation(LatLng(event.latitude, event.longitude));
      currentMarker(
        Marker(
          markerId: const MarkerId('current_marker'),
          position: currentLocation(),
        ),
      );
      if (pengantarUid != '') {
        updateLocation(
            lat: event.latitude.toString(), long: event.longitude.toString());
      }

      if (mapController.isCompleted) {
        (await mapController.future).animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation(),
              zoom: 14.4746,
            ),
          ),
        );
      }
    });
  }

  void setLocationOnMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);

    await locationPermission();

    final position = await Geolocator.getCurrentPosition();

    selectedLocation(
      LatLng(position.latitude, position.longitude),
    );

    (await mapController.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: selectedLocation(),
          zoom: 14.4746,
        ),
      ),
    );

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) async {
      if (isMyLocation()) {
        selectedLocation(LatLng(event.latitude, event.longitude));
        selectedMarker(
          Marker(
            markerId: const MarkerId('selected_marker'),
            position: selectedLocation(),
          ),
        );
        if (co < 1) {
          (await mapController.future).animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: selectedLocation(),
                zoom: 14.4746,
              ),
            ),
          );
          co++;
        }
      }
    });
  }

  void setSelectedLocation(LatLng latLng) async {
    selectedLocation(latLng);
    selectedMarker(
      Marker(
        markerId: const MarkerId('selected_marker'),
        position: selectedLocation(),
      ),
    );
    (await mapController.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: selectedLocation(),
          zoom: 14.4746,
        ),
      ),
    );
  }

  void setRadius({required double radius}) {
    selectedRadius(radius);
  }

  void setDriverLocation(LatLng latLng) {
    driverLocation(latLng);
    driverMarker(
      Marker(
        markerId: const MarkerId('driver_marker'),
        position: driverLocation(),
      ),
    );
  }

  void setUserLocation(LatLng latLng) {
    userLocation(latLng);
    userMarker(
      Marker(
        markerId: const MarkerId('user_marker'),
        position: userLocation(),
      ),
    );
  }

  Future<void> updateLocation({
    required String lat,
    required String long,
  }) async {
    var response = await DeliveryService.updateMap(
        uidPengantar: pengantarUid, lat: lat, long: long);
    debugPrint(response.toString());
  }
}
