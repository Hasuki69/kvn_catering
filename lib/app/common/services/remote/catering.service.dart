import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class CateringService {
  // Get Catering
  Future getCatering() async {
    var url = Uri.parse(
      '$apiPath/cat/read-cat',
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var respStatus = json.decode(response.body)['status'];
      var respMessage = json.decode(response.body)['message'];
      var respData = json.decode(response.body)['data'];
      return [respStatus, respMessage, respData];
    } else {
      return '${response.statusCode} Unable to connect to server!';
    }
  }

  // Get Catering Menu
  Future getCateringMenu(
      {required String cateringUid,
      required String dateFrom,
      required String dateTo}) async {
    var url = Uri.parse(
      '$apiPath/mn/read-menu?id_catering=$cateringUid&tanggal_menu=$dateFrom&tanggal_menu2=$dateTo',
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var respStatus = json.decode(response.body)['status'];
      var respMessage = json.decode(response.body)['message'];
      var respData = json.decode(response.body)['data'];
      return [respStatus, respMessage, respData];
    } else {
      return '${response.statusCode} Unable to connect to server!';
    }
  }

  Future<String> getCateringAddress(
      {required String lat, required String long}) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$gmapKey');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var respData = json.decode(response.body)['results'];
      if (respData != null && respData.isNotEmpty) {
        final addressComponents = respData[0]['address_components'];
        List<String> addressParts = [];
        for (var component in addressComponents) {
          addressParts.add(component['long_name']);
        }
        String address = addressParts.join(', ');
        return address;
      } else {
        return 'Not Found';
      }
    } else {
      return '${response.statusCode} Unable to connect to server!';
    }
  }
}
