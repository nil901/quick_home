import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/dashboard/qwik_picks.dart';
import 'package:quick_home/screen/dashboard/search_screen.dart';
import '../../color/colors.dart';
import '../../util/comman_app_bar.dart';
import '../../util/size.dart';
import '../wigets/bannar_slider.dart';
import 'mid_screens/sub_categories_screen.dart';

final List<Map<String, String>> categories = [
  {'label': 'Core Home Services', 'icon': 'assets/images/cleaning.png'},
  {'label': 'Family Support', 'icon': 'assets/images/repair.png'},
  {'label': 'Personal Care', 'icon': 'assets/images/beuty.png'},
  {'label': 'Home Maintenance', 'icon': 'assets/images/homecleaning.png'},
];


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color:  HexColor('#E4F9FF'),
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

                /// 🔹 TOP SECTION with background color
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      /// 📸 Banner (slider placeholder)
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

                /// 🏷 Categories (Updated UI like ServiceListScreen)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'All Categories',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(
                  height: 136,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to SubCategoriesScreen on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoriesscreenDetails(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 19),
                          width: 100, // Adjust as per design
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFF004271),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(18), // Same curvature sab corners pe
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 86,
                                height: 82,
                                margin: EdgeInsets.only(top: 2, left: 1),
                                child: Image.asset(
                                  category['icon']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFF004271),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    category['label']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
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
                SizedBox(height: 22),
                _buildSection(
                  "Everything We Offer",
                  [
                    'assets/images/offerCat.png',
                    'assets/images/beuty1.png',
                    'assets/images/offercat2.png',
                    'assets/images/cartIm1.png',
                    'assets/images/beuty1.png',
                  ],
                  labels: [
                    "Maids",
                    "Laundry at Home",
                    "Cleaning",
                    "Repair",
                    "Laundry at Home",
                  ],
                ),

                SizedBox(height: 2),
                _buildSection("Qwik Picks", [
                  'assets/images/cartIm1.png',
                  'assets/images/cartIm2.png',
                  'assets/images/cartIm3.png',
                  'assets/images/cartIm2.png',
                  'assets/images/cartIm1.png',
                ],
                    labels: [
                      "Repair",
                      "Spa",
                      "Cleaning",
                      "Beauty",
                      "Repair",
                    ]
                ),

                SizedBox(height: 2),
                _buildSection("Special Offers & Campaigns", [
                  'assets/images/specialOffer.png',
                  'assets/images/specialOffers2.png',
                  'assets/images/specialOffers3.png',
                  'assets/images/specialOffer.png',
                  'assets/images/specialOffers2.png',
                ], single: true),

                SizedBox(height: 2),
                _buildSection("Beauty, Qwik & Easy", [
                  'assets/images/beuty2.png',
                  'assets/images/beuty2.png',
                  'assets/images/beuty.png',
                  'assets/images/beuty3.png',
                  'assets/images/beuty2.png',
                ]
                  , labels: [
                    "Salon at Home",
                    "Mani-pedi",
                    "waxing",
                    "Facial",
                    "Hair Treatment",
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// 📦 Section Builder

  Widget _buildSection(String title, List<String> images, {bool single = false, List<String>? labels}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            Colors.white, // Button ka color, chahe to change kar sakte ho
            foregroundColor: Colors.black, // Text color default
            padding:
            EdgeInsets
                .zero, // Kyunki humne apne padding already child me diya hai
            elevation: 2, // Shadow ka effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QwikPicksScreen()),
            );

            print("Button pressed");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("See all", style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: single ? 158 : 160, // height thodi badhayi for text
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              double width = single ? 301 : 120;
              double height = single ? 150 : 120;

              return Container(
                margin: const EdgeInsets.only(left: 12),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        images[index],
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Text below image
                    if (labels != null && labels.length > index)
                      Text(
                        labels[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

