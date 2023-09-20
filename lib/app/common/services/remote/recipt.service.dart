import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class ReciptService {
  // Get Order
  Future getRecipt({required String uid}) async {
    var url = Uri.parse(
      '$apiPath/PBR/read-recipe-order?id_user=$uid',
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
  Future getReciptDetail({required String orderUid}) async {
    var url = Uri.parse(
      '$apiPath/PBR/read-detail-rescipe-order?id_order=$orderUid',
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
}
