import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/provide/home_prov.dart';
import 'package:quick_home/screen/dashboard/qwik_picks.dart';
import 'package:quick_home/screen/dashboard/search_screen.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/screen/wigets/quick_pick.dart';
import 'package:quick_home/screen/wigets/spacial_offers.dart';
import '../../color/colors.dart';
import '../../util/comman_app_bar.dart';
import '../../util/size.dart';
import '../wigets/bannar_slider.dart';
import 'mid_screens/sub_categories_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<bool> isSelectedList = [];

  @override
  void initState() {
    super.initState();
    HomeServices().bannarApi(ref);
    HomeServices().categoryApi(ref);
    HomeServices().offerApi(ref);
    HomeServices().profileApi(ref);
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider);

    // Initialize selection list once categories are loaded
    if (isSelectedList.length != category.length) {
      isSelectedList = List.generate(category.length, (index) => false);
    }

    return Material(
      color: HexColor('#E4F9FF'),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kwhite,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CommanAppBar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: HexColor('#E4F9FF'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔍 Search bar
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: kgrey, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/search.png",
                                    color: Colors.black,
                                    height: 20,
                                  ),
                                  w10,
                                  const Text(
                                    "Search here...!",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// 📸 Banner Slider
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BannerSlider(),
                      ),

                      h20,
                    ],
                  ),
                ),
                h10,

                /// 🏷 Categories
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'All Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(
                  height: 136,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      final categorys = category[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to SubCategoriesScreen on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SubCategoriesscreenDetails(
                                    catId: categorys.id,
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 19),
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  isSelectedList[index]
                                      ? const Color(0xFF004271)
                                      : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 86,
                                height: 82,
                                margin: const EdgeInsets.only(top: 2, left: 1),
                                child:
                                    categorys.imageUrl != null &&
                                            categorys.imageUrl!.isNotEmpty
                                        ? Image.network(
                                          categorys.imageUrl!,
                                          fit: BoxFit.contain,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Image.asset(
                                              "assets/images/logo.png",
                                              fit: BoxFit.contain,
                                            );
                                          },
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            );
                                          },
                                        )
                                        : Image.asset(
                                          "assets/images/logo.png",
                                          fit: BoxFit.contain,
                                        ),
                              ),

                              /// Bottom container (color change on tap)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Sirf clicked category blue, baaki grey
                                    for (
                                      int i = 0;
                                      i < isSelectedList.length;
                                      i++
                                    ) {
                                      isSelectedList[i] = (i == index);
                                    }
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelectedList[index]
                                            ? const Color(0xFF004271)
                                            : Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categorys.name.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            isSelectedList[index]
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// Sections
                SectionWidget(false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 📦 Section Widget
class SectionWidget extends ConsumerWidget {
  final bool single;
  SectionWidget(this.single);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offers = ref.watch(offerProvider);

    if (offers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final homeModel = offers[0];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            homeModel.sections.map((section) {
              final items = section.items.items;

              log("${section.title} has ${items.length} items");
              log(jsonEncode(items.map((e) => e.toJson()).toList()));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          section.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        QwikPicksScreen(item: homeModel),
                              ),
                            );
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: single ? 200 : 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        double width = single ? 301 : 120;
                        double height = single ? 150 : 120;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServicesDetailsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    item.imageUrl,
                                    width: width,
                                    height: height,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              width: width,
                                              height: height,
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
