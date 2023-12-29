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
  static Future inputBudgeting(
      {required String catUid,
      required String idMasterMenu,
      required String totalPorsi,
      required String tanggal}) async {
    var url = Uri.parse(
      '$apiPath/BD/input-budgeting',
    );
    var response = await http.post(url, body: {
      'id_catering': catUid,
      'id_master_menu': idMasterMenu,
      'total_porsi': totalPorsi,
      'tanggal_budgeting': tanggal,
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
  static Future getRealisasi(
      {required String idBudgeting, required String idMasterMenu}) async {
    var url = Uri.parse(
      '$apiPath/RL/read-tabel-realisasi?id_budgeting=$idBudgeting&id_master_menu=$idMasterMenu',
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

  static Future getRealisasiBahan(
      {required String idBudgeting, required String idBahan}) async {
    var url = Uri.parse(
      '$apiPath/RL/read-realisasi?id_budgeting=$idBudgeting&id_bahan_menu=$idBahan',
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
    required String idBudgeting,
    required String uidBahan,
    required String keterangan,
    required String jumlah,
    required String harga,
  }) async {
    var url = Uri.parse(
      '$apiPath/RL/input-realisasi',
    );
    var response = await http.post(url, body: {
      'id_budgeting': idBudgeting,
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
