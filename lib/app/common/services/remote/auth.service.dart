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
    required String qr,
  }) async {
    var url = Uri.parse('$apiPath/cat/input-catering');
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields['id_user'] = uid;
    request.fields['nama_catering'] = name;
    request.fields['alamat_catering'] = address;
    request.fields['telp_catering'] = phone;
    request.fields['email_catering'] = email;
    request.fields['deskripsi_catering'] = description;
    request.fields['tipe_pemesanan'] = typePemesanan;
    request.files.add(
      await http.MultipartFile.fromPath('photo', qr),
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
