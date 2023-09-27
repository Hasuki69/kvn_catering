import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class PengantarService {
  // Get Pengantar
  Future getPengantar({required String catUid}) async {
    var url = Uri.parse(
      '$apiPath/PA/read-pengantar?id_catering=$catUid',
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

  // Create Pengantar
  Future createPengantar({
    required String catUid,
    required String nama,
    required String telp,
    required String email,
    required String username,
    required String password,
    required String status,
  }) async {
    var url = Uri.parse(
      '$apiPath/PA/su-pengantar',
    );
    var response = await http.post(url, body: {
      'id_catering': catUid,
      'nama_user': nama,
      'telp_user': telp,
      'email_user': email,
      'username_user': username,
      'password_user': password,
      'status_user': status,
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

  // Set Pengantar
  Future setPengantar(
      {required String idDetailOrder, required String idPengantar}) async {
    var url = Uri.parse(
      '$apiPath/ORD/set-pengantar',
    );
    var response = await http.put(url, body: {
      'id_detail_order': idDetailOrder,
      'id_pengantar': idPengantar,
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
