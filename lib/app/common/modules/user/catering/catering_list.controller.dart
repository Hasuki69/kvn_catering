import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kvn_catering/app/common/services/remote/catering.service.dart';

class CateringListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCateringList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // ==================== VARIABLES ====================
  GetStorage box = GetStorage();
  CateringService cateringService = CateringService();

  var futureCateringList = Future.value().obs;

  var selectedFilter = ''.obs;

  var selectedDate1 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  var selectedDate2 = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  // ==================== FUCTIONS ====================
  get session => box.read('session') ?? false;
  get uid => box.read('uid') ?? '';
  get role => box.read('role') ?? 0;

  Future<void> getCateringList() async {
    futureCateringList = cateringService.getCatering().obs;
  }
}
