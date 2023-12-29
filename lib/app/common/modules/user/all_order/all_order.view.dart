import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/order.service.dart';
import 'package:kvn_catering/app/core/themes/style.dart';
import 'package:permission_handler/permission_handler.dart';

class AllOrderView extends StatefulWidget {
  final String idUser;
  const AllOrderView({super.key, required this.idUser});

  @override
  State<AllOrderView> createState() => _AllOrderViewState();
}

class _AllOrderViewState extends State<AllOrderView> {
  // ==================== Variable ==================== //
  GoogleMapController? mapController;
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  );
  StreamSubscription? streamSubscription;

  Uint8List? customDriverMarker;

  bool firstZoom = true;

  LatLng userPosition = const LatLng(0.0, 0.0);

  List driverList = List.empty(growable: true);

  // ==================== Lifecycle ==================== //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodayOrder();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController?.dispose();
    stopListening();
  }

  // ==================== Function ==================== //

  Future<void> readTodayOrder() async {
    driverList.clear();
    await OrderService()
        .getOrder(
      uid: widget.idUser,
      date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    )
        .then((value) async {
      if (value[0] == 200) {
        for (var e in value[2][0]['menu_order_dipesan']) {
          await OrderService()
              .getOrderDetail(orderDetailUid: e['id_detail_order'])
              .then((value) {
            if (value[0] == 200) {
              for (var e in value[2]) {
                final data = {
                  'nama_pengantar': e['nama_pengantar'],
                  'status': e['status'],
                  'nomer_telp': e['nomer_telp'],
                  'nama_catering': e['nama_catering'],
                  'nama_menu': e['nama_menu'],
                  'jumlah': e['jumlah'],
                  'harga': e['harga'],
                  'langtitude': e['langtitude'],
                  'longtitude': e['longtitude'],
                };
                driverList.add(data);
              }
            }
          });
        }
      }
    });
  }

  void onMapCreated(
      GoogleMapController controller, BuildContext context) async {
    mapController = controller;
    await locationPermission();

    customDriverMarker = await getBytesFromAsset(
      path: 'lib/assets/icons/driver-1.png',
      width: 100,
    ).whenComplete(
      () => streamPos(controller, context),
    );
  }

  void streamPos(GoogleMapController controller, BuildContext context) {
    streamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((event) async {
      log("Listening on location changing", name: "Geolocator");

      await readTodayOrder().then((value) {
        if (mounted) {
          setState(() {
            userPosition = LatLng(event.latitude, event.longitude);
            if (firstZoom) {
              controller.getZoomLevel().then((value) {
                mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(event.latitude, event.longitude),
                      zoom: 14.4746,
                    ),
                  ),
                );
              });
              firstZoom = false;
            }
          });
        }
      });
    });
  }

  void stopListening() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }

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

  Future showDetailDialog(BuildContext context, Map data) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Driver ${data['nama_pengantar']}",
                style: AppStyle().titleMedium,
              ),
            ),
            const Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Catering",
                      style: AppStyle().titleSmall,
                    ),
                    Text(
                      "Telp Catering",
                      style: AppStyle().titleSmall,
                    ),
                    Text(
                      "Menu",
                      style: AppStyle().titleSmall,
                    ),
                    Text(
                      "Jumlah",
                      style: AppStyle().titleSmall,
                    ),
                    Text(
                      "Harga",
                      style: AppStyle().titleSmall,
                    ),
                  ],
                ).paddingOnly(right: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${data['nama_catering']}"),
                    Text(": ${data['nomer_telp']}"),
                    Text(": ${data['nama_menu']}"),
                    Text(": ${data['jumlah']}"),
                    Text(": ${data['harga']}"),
                  ],
                ),
              ],
            ),
          ],
        ).paddingAll(16),
      ),
    ).then((value) => streamSubscription?.resume());
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (controller) => onMapCreated(controller, context),
      zoomControlsEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId('user_marker'),
          position: userPosition,
          icon: BitmapDescriptor.defaultMarker,
        ),
        ...List.generate(
          driverList.length,
          (index) => Marker(
            infoWindow: InfoWindow(
              onTap: () {
                streamSubscription?.pause();
                showDetailDialog(context, driverList[index]);
              },
              title: "Read more",
            ),
            markerId: MarkerId('driver_${index}_marker'),
            position: LatLng(driverList[index]['langtitude'],
                driverList[index]['longtitude']),
            icon: BitmapDescriptor.fromBytes(customDriverMarker!),
          ),
        ),
      },
    );
  }
}
