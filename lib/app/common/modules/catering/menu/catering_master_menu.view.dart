import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_catering/app/common/modules/catering/menu/catering_menu.controller.dart';
import 'package:kvn_catering/app/common/services/remote/catering.service.dart';
import 'package:kvn_catering/app/common/widgets/custom_button.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/style.dart';
import 'package:kvn_catering/app/core/utils/extensions/loading_func.dart';

class MasterMenuView extends GetView<CateringMenuController> {
  const MasterMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: ReText(
          value: "Master Menu",
          style: AppStyle().titleLarge,
        ),
      ),
      body: Obx(
        () => FutureBuilder(
          future: controller.futureMasterMenu(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data! as List;
              if (data[0] == 200) {
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  itemCount: data[2].length,
                  itemBuilder: (context, index) {
                    final masterMenu = data[2][index];
                    return Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        title: ReText(
                          value: masterMenu['nama_menu'],
                          style: AppStyle().titleSmall,
                        ),
                        children: [
                          const Divider().paddingSymmetric(horizontal: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ReText(
                                value: "Deskripsi: ",
                                style: AppStyle().bodyMedium,
                              ),
                              ReText(
                                value: masterMenu['deskripsi_menu'],
                                style: AppStyle().captionMedium,
                                maxLines: 10,
                              ),
                            ],
                          ).paddingAll(8),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      "Nama Bahan",
                                      style: AppStyle().titleSmall,
                                    ).paddingAll(8),
                                  ),
                                  TableCell(
                                    child: Text(
                                      "Jumlah",
                                      style: AppStyle().titleSmall,
                                    ).paddingAll(8),
                                  ),
                                  TableCell(
                                    child: Text(
                                      "Budget",
                                      style: AppStyle().titleSmall,
                                    ).paddingAll(8),
                                  ),
                                ],
                              ),
                              ...List.generate(
                                  masterMenu['detail_bahan_master_menu'].length,
                                  (indexItem) {
                                final bahanMasterMenu =
                                    masterMenu['detail_bahan_master_menu']
                                        [indexItem];
                                return TableRow(
                                  children: [
                                    TableCell(
                                      child: Text(bahanMasterMenu['nama_bahan'])
                                          .paddingAll(8),
                                    ),
                                    TableCell(
                                      child: Text(
                                              "${bahanMasterMenu['jumlah_bahan']} ${bahanMasterMenu['satuan_bahan']}")
                                          .paddingAll(8),
                                    ),
                                    TableCell(
                                      child: Text(
                                              "Rp. ${bahanMasterMenu['harga_bahan']}")
                                          .paddingAll(8),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ).paddingAll(8),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                );
              } else {
                return Center(
                  child: ReText(
                    value: "No Data Found",
                    style: AppStyle().titleMedium,
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            MasterMenuInput(
              controller: controller,
              idCatering: controller.cateringUid,
            ),
            isDismissible: false,
            isScrollControlled: true,
          ).then((value) => controller.getMasterMenu());
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MasterMenuInput extends StatefulWidget {
  final String idCatering;
  final CateringMenuController controller;
  const MasterMenuInput({
    super.key,
    required this.idCatering,
    required this.controller,
  });

  @override
  State<MasterMenuInput> createState() => _MasterMenuInputState();
}

class _MasterMenuInputState extends State<MasterMenuInput> {
  final ctrlNama = TextEditingController();
  final ctrlDesc = TextEditingController();

  final ctrlNamaBahan = TextEditingController();
  final ctrlBudgetBahan = TextEditingController();
  final ctrlJumlahBahan = TextEditingController();
  final ctrlSatuanBahan = TextEditingController();

  List listOfBahan = List.empty(growable: true);

  final cateringService = CateringService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeCtrl();
  }

  void disposeCtrl() {
    ctrlNama.dispose();
    ctrlDesc.dispose();
    ctrlNamaBahan.dispose();
    ctrlBudgetBahan.dispose();
    ctrlJumlahBahan.dispose();
    ctrlSatuanBahan.dispose();
  }

  void clearCtrlBahan() {
    ctrlNamaBahan.clear();
    ctrlBudgetBahan.clear();
    ctrlJumlahBahan.clear();
    ctrlSatuanBahan.clear();
  }

  Future postMasterMenu() async {
    getLoading();
    await cateringService
        .postMasterMenu(
      idCatering: widget.idCatering,
      namaMenu: ctrlNama.text,
      descMenu: ctrlDesc.text,
      bahan: listOfBahan,
    )
        .then((value) {
      closeLoading();
      if (value[0] == 200) {
        Get.back();
        Get.snackbar(
          'Status ${value[0]}',
          value[1],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (value[0] == 404) {
        Get.snackbar(
          'Status ${value[0]}',
          value[1],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Status ${value[0]}',
          value[1],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 0,
      onClosing: () {
        //
      },
      builder: (context) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ReText(
                value: "Input Master Menu",
                style: AppStyle().titleLarge,
              ),
            ).paddingOnly(top: 25),
            const Divider(
              height: 32,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReText(
                    value: "Nama Makanan",
                    style: AppStyle().titleSmall,
                  ),
                  ReTextField(
                    hintText: "Masukkan nama makanan",
                    controller: ctrlNama,
                  ).paddingOnly(bottom: 8),
                  ReText(
                    value: "Deskripsi Makanan",
                    style: AppStyle().titleSmall,
                  ),
                  ReTextField(
                    maxLines: 5,
                    hintText: "Masukkan deskripsi makanan",
                    controller: ctrlDesc,
                  ).paddingOnly(bottom: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReText(
                        value: "List Bahan: ",
                        style: AppStyle().titleSmall,
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ReText(
                                    value: "Nama Bahan",
                                    style: AppStyle().titleSmall,
                                  ),
                                  ReTextField(
                                    hintText: "Nasi goreng",
                                    controller: ctrlNamaBahan,
                                  ).paddingOnly(bottom: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ReText(
                                              value: "Jumlah Bahan",
                                              style: AppStyle().titleSmall,
                                            ),
                                            ReTextField(
                                              hintText: "100",
                                              controller: ctrlJumlahBahan,
                                            ).paddingOnly(bottom: 8),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ReText(
                                              value: "Satuan Bahan",
                                              style: AppStyle().titleSmall,
                                            ),
                                            ReTextField(
                                              hintText: "kg/g/ml",
                                              controller: ctrlSatuanBahan,
                                            ).paddingOnly(bottom: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ReText(
                                    value: "Budget Bahan",
                                    style: AppStyle().titleSmall,
                                  ),
                                  ReTextField(
                                    hintText: "25000",
                                    controller: ctrlBudgetBahan,
                                  ).paddingOnly(bottom: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          clearCtrlBahan();
                                          Get.back();
                                        },
                                        child: ReText(
                                          value: "Cancel",
                                          style: AppStyle().titleSmall,
                                        ),
                                      ).paddingOnly(right: 16),
                                      ReElevatedButton(
                                        onPressed: () {
                                          listOfBahan.add([
                                            ctrlNamaBahan.text,
                                            ctrlJumlahBahan.text,
                                            ctrlSatuanBahan.text,
                                            ctrlBudgetBahan.text
                                          ]);
                                          clearCtrlBahan();
                                          Get.back();
                                        },
                                        child: ReText(
                                          value: "Submit",
                                          style: AppStyle().titleSmall.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).paddingAll(24),
                            ),
                            barrierDismissible: false,
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listOfBahan.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: ReText(value: listOfBahan[index][0]),
                                ),
                                ReText(
                                    value:
                                        "${listOfBahan[index][1]} ${listOfBahan[index][2]}"),
                                const ReText(value: "x").paddingOnly(left: 24),
                              ],
                            ),
                            trailing:
                                ReText(value: "Rp. ${listOfBahan[index][3]}"),
                          ),
                        ).paddingOnly(bottom: 8);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: ReText(
                    value: "Cancel",
                    style: AppStyle().titleSmall,
                  ),
                ).paddingOnly(right: 16),
                ReElevatedButton(
                  onPressed: () {
                    postMasterMenu();
                  },
                  child: ReText(
                    value: "Submit",
                    style: AppStyle().titleSmall.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(16);
      },
    );
  }
}
