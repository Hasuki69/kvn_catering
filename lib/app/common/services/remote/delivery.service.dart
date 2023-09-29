import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class DeliveryService {
  // Get Delivery List
  static Future getDelivery({required String uidPengantar}) async {
    var url = Uri.parse(
      '$apiPath/ORD/read-order-pengantar?id_pengantar=$uidPengantar',
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

  // Get Delivery List
  static Future updateMap({
    required String uidPengantar,
    required String lat,
    required String long,
  }) async {
    var url = Uri.parse(
      '$apiPath/PA/update-Maps-pengantar',
    );
    var response = await http.put(url, body: {
      'id_pengantar': uidPengantar,
      'langtitude': lat,
      'longtitude': long,
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
