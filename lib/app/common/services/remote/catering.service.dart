import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class CateringService {
  // Get Catering
  Future getCatering({required String uid, required String type}) async {
    var url = Uri.parse(
      '$apiPath/cat/filter-catering?id_user=$uid&tipe=$type',
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

  // Add to Fav
  Future addToFav({required String uid, required String idCat}) async {
    var url = Uri.parse(
      '$apiPath/cat/favorite-catering',
    );
    var response = await http.post(url, body: {
      'id_user': uid,
      'id_catering': idCat,
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

  // Get QR Payment
  Future getQr({required String catUid}) async {
    var url = Uri.parse(
      '$apiPath/cat/get-QR-catering?id_catering=$catUid',
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

  // Catering Add Menu
  Future catAddMenu({
    required String catUid,
    required String nama,
    required String harga,
    required String tanggal,
    required String jamAwal,
    required String jamAkhir,
    required String status,
    required String photo,
  }) async {
    var url = Uri.parse('$apiPath/mn/input-menu');
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields['id_catering'] = catUid;
    request.fields['nama_menu'] = nama;
    request.fields['harga_menu'] = harga;
    request.fields['tanggal_menu'] = tanggal;
    request.fields['jam_pengiriman_awal'] = jamAwal;
    request.fields['jam_pengiriman_akhir'] = jamAkhir;
    request.fields['status'] = status;
    request.files.add(
      await http.MultipartFile.fromPath('photo', photo),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      final resp = await http.Response.fromStream(response);
      var status = json.decode(resp.body)['status'];
      var message = json.decode(resp.body)['message'];
      var body = json.decode(resp.body)['data'];
      return [status, message, body];
    } else {
      return '${response.statusCode} Unable to connect to server!';
    }
  }

  // Add to Fav
  Future catUpdateMenu({
    required String catUid,
    required String menuUid,
    required String namaMenu,
    required String hargaMenu,
    required String jamAwal,
    required String jamAkhir,
  }) async {
    var url = Uri.parse(
      '$apiPath/mn/update-menu',
    );
    var response = await http.put(url, body: {
      'id_catering': catUid,
      'id_menu': menuUid,
      'nama_menu': namaMenu,
      'harga_menu': hargaMenu,
      'jam_pengiriman_awal': jamAwal,
      'jam_pengiriman_akhir': jamAkhir,
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

  // Add to Fav
  Future catDeleteMenu({
    required String catUid,
    required String menuUid,
  }) async {
    var url = Uri.parse(
      '$apiPath/mn/delete-menu',
    );
    var response = await http.delete(url, body: {
      'id_catering': catUid,
      'id_menu': menuUid,
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
