import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/app/global/model/content_model.dart';
import 'package:sample_app/utility/shared/widget/mobile_size_widget.dart';
import 'package:get/get.dart';
import '../../../../app/theme/style.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final state = Get.find<HomeController>().state;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return MobileSizeWidget(
          padding: EdgeInsets.zero,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          color: ColorConstant.primaryColor,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 0,
                            top: 15,
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    hintText: 'Find What you need',
                                    fillColor: Colors.white,
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: const Icon(Icons.search),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0,
                                      minHeight: 0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              RawMaterialButton(
                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: Colors.lightBlueAccent,
                                padding: const EdgeInsets.all(15.0),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.list,
                                  color: Colors.white,
                                  // size: 35.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        CarouselSlider(
                          options: const CarouselOptions(
                            height: 200,
                            viewportFraction: 1,
                            enlargeCenterPage: false,
                            autoPlay: true,
                          ),
                          items: state.imageList
                              .map(
                                (item) => SizedBox(
                                  width: Get.width,
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.fill,
                                    height: 200,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 8),
                        categoryWidget(),
                        const SizedBox(height: 5),
                        contentWidget(),
                        const SizedBox(height: 5),
                        if (!state.isShowProduct)
                          InkWell(
                            onTap: () => controller.showProduct(),
                            child: Image.network(
                              'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs3/175463501/original/aee4d1f49fe65b066d4288d2b616c796c866107a/design-a-unique-game-anime-manga-logo-and-banner.jpg',
                              height: 200,
                              width: Get.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        if (state.isShowProduct) showProductWidget(),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  height: 65,
                  color: ColorConstant.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var content in state.listTab)
                        tabContentWidget(content, content.type)
                    ],
                  ),
                  // child: ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: controller.listTab.length,
                  //   itemBuilder: (context, index) {
                  //     ContentModel content = controller.listTab[index];
                  //     TabType tabType = content.type;
                  //     return Container(
                  //       child: Column(
                  //         children: [
                  //           Icon(controller.getIcon(tabType), size: 40),
                  //           Text(content.name),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget tabContentWidget(ContentModel content, TabType tabType) {
    return Column(
      children: [
        Icon(
          controller.getIcon(tabType),
          size: 30,
          color: Colors.white,
        ),
        Text(
          content.name,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget categoryWidget() {
    return Container(
      height: 60,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor,
        // border: Border.all(
        //   color: ColorConstant.primaryColor,
        // ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.listCategory.length,
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          ContentModel content = state.listCategory[index];
          return InkWell(
            onTap: () {
              state.selectedCategory = content;
              controller.update();
            },
            child: Card(
              color: state.selectedCategory?.type != content.type
                  ? Colors.lightBlue
                  : Colors.lightBlueAccent,
              margin: const EdgeInsets.only(right: 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    content.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget contentWidget() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: const EdgeInsets.all(4.0),
      childAspectRatio: (Get.context?.isPhone == true ? 4.0 : 5.0) / 9.0,
      children: state.listPopularKomik
          .map(
            (content) => GridTile(
              child: Card(
                color: Colors.blue.shade200,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Image.network(
                        content.thumbnail ?? '',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 1,
                      child: Text(
                        content.title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // Widget serviceWidget() {
  //   Get.log('is Phone : ${Get.context?.isPhone}');
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
  //     child: GridView.builder(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       primary: false,
  //       padding: const EdgeInsets.all(0),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 4, // number of items in each row
  //         mainAxisSpacing: 4.0, // spacing between rows
  //         crossAxisSpacing: 4.0, // spacing between columns
  //         childAspectRatio: Get.context?.isPhone == true ? 2 / 3 : 4 / 3,
  //       ),
  //       itemCount: controller.listService.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         ContentModel content = controller.listService[index];
  //         // ServiceType serviceType = content.type;
  //         return Column(
  //           children: [
  //             Image.asset(content.content, height: 70),
  //             // const SizedBox(height: 4),
  //             Text(
  //               content.name,
  //               style: const TextStyle(fontSize: 12),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget showProductWidget() {
    return Container();
  }
}
