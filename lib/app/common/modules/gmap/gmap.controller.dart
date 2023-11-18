import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/services/remote/delivery.service.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:permission_handler/permission_handler.dart';

class GmapController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    customDriverMarker = await getBytesFromAsset(
      path: 'lib/assets/icons/driver-1.png',
      width: 100,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    mapController?.dispose();
    stopListening();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();

  GoogleMapController? mapController;

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

  var isMyLocation = true;

  var firstZoom = true;

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get pengantarUid => box.read('pengantarUid') ?? '';
  get role => box.read('role') ?? 0;

  Uint8List? customDriverMarker;

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

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
    if (role == 1) {
      getDriverLocation(uidPengantar: Get.arguments['id_pengantar']!);
    } else if (role == 2) {
      // Do Nothing!
    } else {
      getPembeliLocation(uidDetailOrder: Get.arguments['id_detail_order']!);
    }

    streamPos();
  }

  void streamPos() {
    streamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) async {
      debugPrint('Listening on Location');
      currentLocation(LatLng(event.latitude, event.longitude));
      currentMarker(
        Marker(
            markerId: const MarkerId('current_marker'),
            position: currentLocation(),
            icon: role == 3
                ? BitmapDescriptor.fromBytes(customDriverMarker!)
                : BitmapDescriptor.defaultMarker),
      );
      if (firstZoom) {
        mapController?.animateCamera(CameraUpdate.zoomTo(
          14.4746,
        ));
        firstZoom = false;
      }
      if (role == 1) {
        getDriverLocation(uidPengantar: Get.arguments['id_pengantar']!);
      } else if (role == 2) {
        // Do Nothing!
      } else {
        updateLocation(
          lat: currentLocation().latitude.toString(),
          long: currentLocation().longitude.toString(),
        );
        debugPrint(
            'Updated location\nLat: ${currentLocation().latitude}\nLong: ${currentLocation().longitude}');
      }

      await mapController?.getZoomLevel().then((value) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: role == 3 ? currentLocation() : driverLocation(),
              zoom: value,
            ),
          ),
        );
      });
    });
  }

  void stopListening() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

  void setLocationOnMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await locationPermission();

    streamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) async {
      if (isMyLocation) {
        selectedLocation(LatLng(event.latitude, event.longitude));
        selectedMarker(
          Marker(
            markerId: const MarkerId('selected_marker'),
            position: selectedLocation(),
          ),
        );
        if (firstZoom) {
          mapController?.animateCamera(CameraUpdate.zoomTo(
            14.4746,
          ));
          firstZoom = false;
        }
        await mapController?.getZoomLevel().then((value) {
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: selectedLocation(),
                zoom: value,
              ),
            ),
          );
        });
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
    await mapController?.getZoomLevel().then((value) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: selectedLocation(),
            zoom: value,
          ),
        ),
      );
    });
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
        icon: BitmapDescriptor.fromBytes(customDriverMarker!),
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
    debugPrint('Update Driver Location');
    debugPrint(response.toString());
  }

  OrderService orderService = OrderService();
  Future<void> getPembeliLocation({required String uidDetailOrder}) async {
    var response =
        await orderService.getUserLocation(uidDetailOrder: uidDetailOrder);
    if (response[0] == 200) {
      setUserLocation(
        LatLng(
          double.parse(response[2][0]['langitude']),
          double.parse(response[2][0]['longitude']),
        ),
      );

      debugPrint(
          'My Location\nLat: ${currentLocation().latitude}\nLong: ${currentLocation().longitude}');
      debugPrint(
          'Customer Location\nLat: ${response[2][0]['langitude']}\nLong: ${response[2][0]['longitude']}');
    }
  }

  Future<void> getDriverLocation({required String uidPengantar}) async {
    var response =
        await orderService.getPengantarLocation(uidPengantar: uidPengantar);
    if (response[0] == 200) {
      setDriverLocation(
        LatLng(
          double.parse(response[2][0]['langtitude'].toString()),
          double.parse(response[2][0]['longtitude'].toString()),
        ),
      );
      debugPrint(
          'My Location\nLat: ${currentLocation().latitude}\nLong: ${currentLocation().longitude}');
      debugPrint(
          'Driver location:\nLat: ${response[2][0]['langtitude']}\nLong: ${response[2][0]['longtitude']}');
    }
  }
}
