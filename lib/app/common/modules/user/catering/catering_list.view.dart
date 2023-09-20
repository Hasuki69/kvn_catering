import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_catering/app/common/modules/user/catering/catering_list.controller.dart';
import 'package:kvn_catering/app/common/widgets/custom_elevation.dart';
import 'package:kvn_catering/app/common/widgets/custom_listview.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/configs/const.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class CateringListView extends GetView<CateringListController> {
  const CateringListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: cateringListBody(
          context,
          controller: controller,
        ),
      ),
    );
  }
}

Widget cateringListBody(BuildContext context,
    {required CateringListController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      cateringListAppBar(context, controller: controller),
      cateringListBottomAppBar(context, controller: controller),
      cateringListItem(context, controller: controller),
    ],
  );
}

Widget cateringListAppBar(BuildContext context,
    {required CateringListController controller}) {
  return Stack(
    children: [
      Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColor.disable,
              blurRadius: 8,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: AssetImage(Get.parameters['appbarBanner'] ?? ''),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

Widget cateringListBottomAppBar(BuildContext context,
    {required CateringListController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      ReText(
        value: Get.parameters['category'] ?? 'Catering Category',
        style: AppStyle().headingSmall.copyWith(
              color: AppColor.accent,
            ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
      ),
      ReText(
        value: 'Yuk pilih catering yang kamu inginkan!',
        style: AppStyle().bodyLarge,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
      ),
      const Divider(
        color: AppColor.disable,
        thickness: 4,
        height: 32,
      ),
    ],
  );
}

Widget cateringListItem(BuildContext context,
    {required CateringListController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Obx(
          () => FutureBuilder(
            future: controller.futureCateringList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
                if (snapData[0] != 404) {
                  return ReListView(
                    itemCount: snapData[2].length,
                    itemBuilder: (context, index) {
                      if (controller.isInRange(
                        LatLng(
                          double.parse(snapData[2][index]['langtitude']),
                          double.parse(snapData[2][index]['longtitude']),
                        ),
                        snapData[2][index]['radius'].toDouble(),
                        context,
                        setState,
                      )) {
                        return GestureDetector(
                          onTap: () {
                            controller.getCateringMenu(
                                cateringUid: snapData[2][index]['id_catering']);
                            controller.getAddress(
                              lat: snapData[2][index]['langtitude'],
                              long: snapData[2][index]['longtitude'],
                            );
                            Get.toNamed('/user/catering-list/detail',
                                    arguments: {
                                  'catering-data': snapData[2][index],
                                })!
                                .whenComplete(() {
                              controller.clearFilter();
                            });
                          },
                          child: ReElevation(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                            color: AppColor.accent
                                                .withOpacity(0.4),
                                            width: 1,
                                          ),
                                        ),
                                        color: AppColor.background,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image(
                                              fit: BoxFit.fitWidth,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              image: NetworkImage(
                                                '$apiImagePath${snapData[2][index]['foto_profil_catering']}',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReText(
                                            value: snapData[2][index]
                                                ['nama_catering'],
                                            style: AppStyle()
                                                .titleMedium
                                                .copyWith(fontSize: 18),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                          ),
                                          ReText(
                                            value: snapData[2][index]
                                                ['alamat_catering'],
                                            style: AppStyle().bodyLarge,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: List.generate(
                                                snapData[2][index]
                                                        ['tipe_pemesanan']
                                                    .length,
                                                (itemIndex) => Card(
                                                  color: AppColor.accent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: ReText(
                                                    value: snapData[2][index]
                                                            ['tipe_pemesanan']
                                                        [itemIndex],
                                                    style: AppStyle()
                                                        .titleSmall
                                                        .copyWith(
                                                          color:
                                                              AppColor.primary,
                                                        ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 2,
                                                        horizontal: 4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColor.accent,
                                                ),
                                                ReText(
                                                  value:
                                                      '${snapData[2][index]['rating']}',
                                                  style: AppStyle().titleMedium,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else {
                  return Center(
                    child: ReText(
                      value: 'No Catering Found!',
                      style: AppStyle().titleLarge,
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    ),
  );
}
