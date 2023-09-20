import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class OrderService {
  // Get Order
  Future getOrder({required String uid, required String date}) async {
    var url = Uri.parse(
      '$apiPath/ORD/show-order-menu?id=$uid',
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

  // Get Order Detail
  Future getOrderDetail({required String orderDetailUid}) async {
    var url = Uri.parse(
      '$apiPath/ORD/order-detail-user?id_detail_order=$orderDetailUid',
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

  // Input Order
  Future inputOrder({
    required String uid,
    required String idCat,
    required String idMenu,
    required String namaMenu,
    required String jumlahMenu,
    required String hargaMenu,
    required String tanggalMenu,
    required String tanggalOrder,
    required String lat,
    required String long,
  }) async {
    var url = Uri.parse(
      '$apiPath/ORD/input-order',
    );
    var response = await http.post(url, body: {
      'id_user': uid,
      'id_catering': idCat,
      'id_menu': idMenu,
      'nama_menu': namaMenu,
      'jumlah_menu': jumlahMenu,
      'harga_menu': hargaMenu,
      'tanggal_menu': tanggalMenu,
      'tanggal_order': tanggalOrder,
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
