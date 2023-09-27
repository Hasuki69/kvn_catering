import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class CatLocationServices {
  // Set Catering Location
  Future setLocation(
      {required String uidCat,
      required String lat,
      required String long,
      required String radius}) async {
    var url = Uri.parse(
      '$apiPath/MP/input-Maps',
    );
    var response = await http.post(url, body: {
      'id_catering': uidCat,
      'langtitude': lat,
      'longtitude': long,
      'radius': radius,
    });
    if (response.statusCode == 200) {
      var respStatus = json.decode(response.body)['status'];
      var respMessage = json.decode(response.body)['message'];
      var respData = json.decode(response.body)['data'];
      return [respStatus, respMessage, respData];
    } else {
      return '${response.statusCode} Unable to connect to server!';
    }
  }
}
