import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kvn_catering/app/core/configs/const.dart';

class AuthService {
  // Register
  Future regis({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String username,
    required String password,
  }) async {
    var url = Uri.parse('$apiPath/user/sign-up');
    var response = await http.post(url, body: {
      'nama_user': name,
      'telp_user': phone,
      'email_user': email,
      'status_user': role,
      'username_user': username,
      'password_user': password,
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

  // Register Caterings
  Future regisCatering({
    required String uid,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String description,
    required String typePemesanan,
  }) async {
    var url = Uri.parse('$apiPath/cat/input-catering');
    var response = await http.post(url, body: {
      'id_user': uid,
      'nama_catering': name,
      'alamat_catering': address,
      'telp_catering': phone,
      'email_catering': email,
      'deskripsi_catering': description,
      'tipe_pemesanan': typePemesanan,
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

  // Login
  Future login({required String username, required String password}) async {
    var url = Uri.parse(
      '$apiPath/user/login?username_user=$username&password_user=$password',
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
