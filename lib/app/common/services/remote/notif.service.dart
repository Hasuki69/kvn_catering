import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class NotifService {
  // Get Notif
  Future getAllNotif({required String catUid}) async {
    var url = Uri.parse(
      '$apiPath/NTF/show-all-notif?id_catering=$catUid',
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

  // Get Notif Detail
  Future getDetailNotif({required String orderUid}) async {
    var url = Uri.parse(
      '$apiPath/NTF/read-detail-notif?id_order=$orderUid',
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

  // Confirm Pembayaran Notif
  Future confirmPembayaran({required String orderUid}) async {
    var url = Uri.parse(
      '$apiPath/PBR/confirm-pembayaran',
    );
    var response = await http.put(url, body: {
      'id_order': orderUid,
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
