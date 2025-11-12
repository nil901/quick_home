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
                // ===== Search + Banner =====
                Container(
                  width: double.infinity,
                  color: HexColor('#E4F9FF'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
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

                      // Banner Slider
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BannerSlider(),
                      ),
                    ],
                  ),
                ),

                h10,

                // ===== Categories Title =====
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Text(
                    'All Categories',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                h10,

                // ===== Categories Horizontal (compact) =====
                SizedBox(
                  height: 118, // compact height to match screenshot
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      final categorys = category[index];
                      return InkWell(
                        onTap: () {
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
                          margin: const EdgeInsets.only(right: 12),
                          width: 85, // <= compact width (change here if needed)
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF004271),
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              // small image area
                              Container(
                                width: 75,
                                height: 60,
                                margin: const EdgeInsets.only(top: 4),
                                child:
                                    categorys.imageUrl != null &&
                                            categorys.imageUrl!.isNotEmpty
                                        ? Image.network(
                                          categorys.imageUrl!,
                                          fit: BoxFit.contain,
                                        )
                                        : Image.asset(
                                          "assets/images/logo.png",
                                          fit: BoxFit.contain,
                                        ),
                              ),

                              // compact label area
                              Container(
                                height: 35,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF004271),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(14),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    categorys.name.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
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

                // h10,

                // ===== Sections (Offers / Campaigns / Others) =====
                const SizedBox(height: 4),
                SectionWidget(), // replaced below
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------ SECTION WIDGET (Compact Horizontal Cards Like Screenshot) ------------------

class SectionWidget extends ConsumerWidget {
  const SectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final offers = ref.watch(offerProvider);

    if (offers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final homeModel = offers[0];

    // iterate through sections from API
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          homeModel.sections.map<Widget>((section) {
            final items = section.items.items;

            // determine if section is "Special Offers & Campaigns" (keep bigger if you need)
            final String titleLower =
                section.title?.toString().toLowerCase() ?? '';
            final bool isOfferCampaign =
                titleLower.contains('offer') || titleLower.contains('campaign');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title + See all
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        section.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => QwikPicksScreen(item: homeModel),
                            ),
                          );
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Horizontal list for this section
                SizedBox(
                  height:
                      isOfferCampaign
                          ? 180
                          : 160, // offers slightly taller if needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      // widths:
                      // - For offers/campaigns you wanted more visual weight in earlier messages — keep a bit larger
                      // - For all other sections we show compact cards (matches screenshot)
                      final double cardWidth =
                          isOfferCampaign
                              ? MediaQuery.of(context).size.width *
                                  0.78 // slightly large for offers/campaigns
                              : 120; // compact width for other sections

                      final double imageHeight = isOfferCampaign ? 120 : 90;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ServicesDetailsScreen(
                                    serviceId: item.id,
                                    name: item.name,
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: cardWidth,
                          margin: const EdgeInsets.only(right: 12, bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            // border: Border.all(
                            //   color: Colors.grey.shade300,
                            //   width: 1,
                            // ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // image area
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  item.imageUrl,
                                  width: cardWidth,
                                  height: imageHeight,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        width: cardWidth,
                                        height: imageHeight,
                                        color: Colors.grey[200],
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 32,
                                        ),
                                      ),
                                ),
                              ),

                              // title / meta
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
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
              ],
            );
          }).toList(),
    );
  }
}
