import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class OrderService {
  // Get Order
  Future getOrder({required String uid, required String date}) async {
    var url = Uri.parse(
      '$apiPath/ORD/show-order-menu?id=$uid&tanggal_menu=$date',
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
    required String alamat,
    required String lat,
    required String long,
    required String imagePath,
  }) async {
    var url = Uri.parse('$apiPath/ORD/input-order');
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields['id_user'] = uid;
    request.fields['id_catering'] = idCat;
    request.fields['id_menu'] = idMenu;
    request.fields['nama_menu'] = namaMenu;
    request.fields['jumlah_menu'] = jumlahMenu;
    request.fields['harga_menu'] = hargaMenu;
    request.fields['tanggal_menu'] = tanggalMenu;
    request.fields['tanggal_order'] = tanggalOrder;
    request.fields['alamat'] = alamat;
    request.fields['langtitude'] = lat;
    request.fields['longtitude'] = long;
    request.files.add(
      await http.MultipartFile.fromPath('photo', imagePath),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      final resp = await http.Response.fromStream(response);
      var status = json.decode(resp.body)['status'];
      var message = json.decode(resp.body)['message'];
      var body = json.decode(resp.body)['data'];
      return [status, message, body];
    } else {
      return response.reasonPhrase.toString();
      // return '${response.statusCode} Unable to connect to server!';
    }
  }

  // Get History
  Future getHistory({required String uid, required String date}) async {
    var url = Uri.parse(
      '$apiPath/ORD/history-order?id_user=$uid&tanggal_menu=$date',
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

  // Post Rating
  Future postRating({
    required String uidDetailOrder,
    required String idCatering,
    required String rating,
    required String review,
  }) async {
    var url = Uri.parse(
      '$apiPath/RT/input-rating',
    );
    var response = await http.post(url, body: {
      'id_detail_order': uidDetailOrder,
      'id_catering': idCatering,
      'rating': rating,
      'review': review,
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

  // Read Map Pengantar
  Future getPengantarLocation({required String uidPengantar}) async {
    var url = Uri.parse(
      '$apiPath/PA/read-Maps-pengantar?id_pengantar=$uidPengantar',
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

  // Read Map Pembeli
  Future getUserLocation({required String uidDetailOrder}) async {
    var url = Uri.parse(
      '$apiPath/ORD/read-location-user?id_detail_order=$uidDetailOrder',
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

  // Confirm Order
  Future confirmOrder(
      {required String uid, required String idDetailOrder}) async {
    var url = Uri.parse(
      '$apiPath/ORD/confirm-order',
    );
    var response = await http.put(url, body: {
      'id': uid,
      'id_detail_order': idDetailOrder,
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
