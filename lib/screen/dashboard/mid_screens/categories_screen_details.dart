import 'package:flutter/material.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/mid_screens/sub_categories_screen.dart';
import 'package:quick_home/util/size.dart';

class CategoriesScreenDetails extends StatefulWidget {
  const CategoriesScreenDetails({super.key});

  @override
  State<CategoriesScreenDetails> createState() =>
      _CategoriesScreenDetailsState();
}

class _CategoriesScreenDetailsState extends State<CategoriesScreenDetails> {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.cleaning_services, "title": "Home\nCleaning"},
    {"icon": Icons.local_laundry_service, "title": "Deep\nCleaning"},
    {"icon": Icons.kitchen, "title": "Appliance\nCleaning"},
    {"icon": Icons.outdoor_grill, "title": "Outdoor\nCleaning"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: kwhite,
        elevation: 0,
        titleSpacing: 0,

        title: Text(
          "Cleaning",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kgrey, width: 0.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/search.png",
                            color: Colors.black,
                            height: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search here...!",
                                    border: InputBorder.none,

                                    hintStyle: TextStyle(
                                      color: kblack,
                                      fontSize: 12,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
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
              ],
            ),
            SizedBox(height: 15),

            // 🖼 Top Image Banner
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                "https://img.freepik.com/free-photo/african-american-couple-cleaning-living-room_23-2149014531.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // 📂 Sub Categories Title
            Text(
              "Sub Categories",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // 🧹 Sub Categories List
            // Sub Categories List
            Container(
              height: 130,
              color: kwhite, // 🔹 ListView background color
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoriesscreenDetails(),
                        ),
                      );
                    },
                    child: categoryCard(
                      categories[index]['icon'] as IconData,
                      categories[index]['title'] as String,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Category Card
  Widget categoryCard(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: kwhite,
        child: Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.all(16),
          width: 100,
          decoration: BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.shade300,
            //     spreadRadius: 1,
            //     blurRadius: 5,
            //   ),
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.black),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
