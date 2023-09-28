import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class BudgetingService {
  // Get Budget
  static Future getBudgeting({required String catUid}) async {
    var url = Uri.parse(
      '$apiPath/BD/read-awal-budgeting?id_catering=$catUid',
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

  // Get Budget Detail
  static Future getDetailBudgeting({required String budgetUid}) async {
    var url = Uri.parse(
      '$apiPath/BD/read-budgeting?id_budgeting=$budgetUid',
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

  // Input Budget
  static Future inputBudgeting({
    required String catUid,
    required String namaMenu,
    required String totalPorsi,
    required String tanggal,
    required String namaBahan,
    required String jumlahBahan,
    required String satuanBahan,
    required String hargaBahan,
  }) async {
    var url = Uri.parse(
      '$apiPath/BD/input-budgeting',
    );
    var response = await http.post(url, body: {
      'id_catering': catUid,
      'nama_menu': namaMenu,
      'total_porsi': totalPorsi,
      'tanggal_budgeting': tanggal,
      'nama_bahan': namaBahan,
      'jumlah_bahan': jumlahBahan,
      'satuan_bahan': satuanBahan,
      'harga_bahan': hargaBahan,
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

  // Get Budget
  static Future getRealisasi({required String uidBahan}) async {
    var url = Uri.parse(
      '$apiPath/RL/read-realisasi?id_bahan_menu=$uidBahan',
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

  // Input Budget
  static Future inputRealisasi({
    required String uidBahan,
    required String keterangan,
    required String jumlah,
    required String harga,
  }) async {
    var url = Uri.parse(
      '$apiPath/RL/input-realisasi',
    );
    var response = await http.post(url, body: {
      'id_bahan_menu': uidBahan,
      'keterangan': keterangan,
      'jumlah': jumlah,
      'harga': harga,
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
