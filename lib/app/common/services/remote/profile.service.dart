import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class ProfileService {
  // User Get Profile
  Future getProfile({required String uid}) async {
    var url = Uri.parse(
      '$apiPath/user/get-profile?id_user=$uid',
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

  // User Update Profile
  Future updateProfile({
    required String uid,
    required String name,
    required String email,
    required String phone,
  }) async {
    var url = Uri.parse('$apiPath/user/edit-profile');
    var response = await http.put(url, body: {
      'id_user': uid,
      'nama_user': name,
      'telp_user': phone,
      'email_user': email,
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

  // Catering Get Profile
  Future getCateringProfile({required String uid}) async {
    var url = Uri.parse(
      '$apiPath/cat/read-profile-cat?id_user=$uid',
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

  // Catering Update Profile
  Future updateCateringProfile({
    required String cateringUid,
    required String cateringName,
    required String cateringAddress,
    required String cateringPhone,
    required String cateringEmail,
    required String cateringDesc,
    //required String cateringType,
  }) async {
    var url = Uri.parse('$apiPath/cat/edit-prof-cat');
    var response = await http.put(url, body: {
      'id_catering': cateringUid,
      'nama_catering': cateringName,
      'alamat_catering': cateringAddress,
      'telp_catering': cateringPhone,
      'email_catering': cateringEmail,
      'deskripsi_catering': cateringDesc,
      //'tipe_pemesanan': cateringType,
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
