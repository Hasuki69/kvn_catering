import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kvn_catering/app/common/services/remote/auth.service.dart';
import 'package:kvn_catering/app/core/utils/extensions/filepicker_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';
import 'package:kvn_catering/app/core/utils/extensions/string_separator.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(() {
      isLogin.value = tabController.index == 0;
      isCatering.value = false;
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    disposeController();
  }

  // ==================== VARIABLES ====================

  GetStorage box = GetStorage();
  AuthService authService = AuthService();

  var isVisible = true.obs;
  var isLogin = true.obs;
  var isCatering = false.obs;

  List<Tab> tabList = const [
    Tab(text: 'Login'),
    Tab(text: 'Register'),
  ];

  late TabController tabController;

  final ctrlUsername = TextEditingController();
  final ctrlPassword = TextEditingController();

  final ctrlName = TextEditingController();
  final ctrlTelp = TextEditingController();
  final ctrlEmail = TextEditingController();

  final ctrlCateringName = TextEditingController();
  final ctrlCateringAddress = TextEditingController();
  final ctrlCateringPhone = TextEditingController();
  final ctrlCateringEmail = TextEditingController();
  final ctrlCateringDescription = TextEditingController();

  var waktuPemesanan = <List<dynamic>>[
    ['Harian', false],
    ['Mingguan', false],
    ['Bulanan', false],
  ].obs;

  var isSelect = false.obs;

  var imagePath = ''.obs;
  var imageFile = ''.obs;

  // ==================== FUCTIONS ====================

  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get cateringUid => box.read('cateringUid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> pickFile() async {
    var result = await filePicker();
    if (result == null) {
      Get.snackbar("Error", "Please try again");
    } else {
      imagePath(result['path']);
      imageFile(result['name']);
    }
  }

  void setSession({
    bool session = true,
    required String uid,
    required int role,
    required String cateringUid,
  }) {
    box.write('session', session);
    box.write('uid', uid);
    box.write('role', role);

    box.write('cateringUid', cateringUid);
  }

  Future<void> auth() async {
    isLogin() ? await login() : await register();
  }

  Future<void> login() async {
    getLoading();
    var response = await authService
        .login(
          username: ctrlUsername.text,
          password: ctrlPassword.text,
        )
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      setSession(
        uid: response[2]['id_user'],
        role: response[2]['status_user'],
        cateringUid: response[2]['id_catering'],
      );
      if (role == 1) {
        Get.offAllNamed('/user');
      } else if (role == 2) {
        Get.offAllNamed('/catering');
      } else if (role == 3) {
        Get.offAllNamed('/delivery');
      }
    } else if (response[0] == 404) {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> register() async {
    String tempRole = '0';
    isCatering() ? tempRole = '2' : tempRole = '1';
    if (imagePath.value == '' && tempRole == '2') {
      Get.snackbar('QR IMAGE', 'Foto QR tidak boleh kosong');
    } else {
      getLoading();

      var response = await authService
          .regis(
            name: ctrlName.text,
            email: ctrlEmail.text,
            phone: ctrlTelp.text,
            role: tempRole,
            username: ctrlUsername.text,
            password: ctrlPassword.text,
          )
          .whenComplete(() => closeLoading());

      if (response[0] == 200) {
        setSession(
          uid: response[2]['id_user'],
          role: response[2]['status_user'],
          cateringUid: response[2]['id_catering'],
        );
        role == 1 ? Get.offAllNamed('/user') : regisCatering();
      } else if (response[0] == 404) {
        Get.snackbar(
          'Status ${response[0]}',
          response[1],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Status ${response[0]}',
          response[1],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> regisCatering() async {
    getLoading();
    String typePemesanan = addSeparator(waktuPemesanan, '|');
    var response = await authService
        .regisCatering(
          uid: uid,
          name: ctrlCateringName.text,
          email: ctrlCateringEmail.text,
          phone: ctrlCateringPhone.text,
          address: ctrlCateringAddress.text,
          description: ctrlCateringDescription.text,
          typePemesanan: typePemesanan,
          qr: imagePath(),
        )
        .whenComplete(() => closeLoading());

    if (response[0] == 200) {
      Get.offAllNamed('/catering');
    } else if (response[0] == 404) {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Status ${response[0]}',
        response[1],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void passwordVisibility() {
    isVisible.value = !isVisible.value;
  }

  void disposeController() {
    tabController.dispose();

    ctrlUsername.dispose();
    ctrlPassword.dispose();

    ctrlName.dispose();
    ctrlTelp.dispose();
    ctrlEmail.dispose();

    ctrlCateringName.dispose();
    ctrlCateringAddress.dispose();
    ctrlCateringPhone.dispose();
    ctrlCateringEmail.dispose();
    ctrlCateringDescription.dispose();
  }

  void clearTextControllers() {
    ctrlUsername.clear();
    ctrlPassword.clear();

    ctrlName.clear();
    ctrlTelp.clear();
    ctrlEmail.clear();

    ctrlCateringName.clear();
    ctrlCateringAddress.clear();
    ctrlCateringPhone.clear();
    ctrlCateringEmail.clear();
    ctrlCateringDescription.clear();
  }
}
