import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/provide/home_prov.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/util/size.dart';

class SubCategoriesscreenDetails extends ConsumerStatefulWidget {
  const SubCategoriesscreenDetails({super.key});

  @override
  ConsumerState<SubCategoriesscreenDetails> createState() =>
      _SubCategoriesscreenDetailsState();
}

class _SubCategoriesscreenDetailsState
    extends ConsumerState<SubCategoriesscreenDetails> {
  List<int> counters = [1, 0, 0];
  @override
  void initState() {
    HomeServices().subCategoriesApi(ref);
    // TODO: implement initState
    super.initState();
  }

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
        backgroundColor: kscoundPrimaryColor,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          "Home Cleaning",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: kscoundPrimaryColor,
              child: Column(
                children: [
                  //h40,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        //sw10,
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: kgrey, width: 0.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  h20,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Services",
                    style: TextStyle(
                      fontSize: 18,
                      color: kblack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  h10,
                  ServiceListScreen(),
                  h10,
                  Text(
                    "Laundry at Home",
                    style: TextStyle(
                      fontSize: 18,
                      color: kblack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  h10,
                  CleaningCardList(),

                  ComboSection(
                    title: "Fresh & Comfy Combo",
                    offerCode: "NEW15",
                    service: "Sofa + Carpet cleaning",
                    price: 1499,
                    oldPrice: 1999,
                    rating: 4,
                    reviews: "25 k reviews",
                  ),
                  SizedBox(height: 20),
                  ComboSection(
                    title: "Sparkle Combo",
                    offerCode: "NEW15",
                    service: "Basic home + Bathroom",
                    price: 1499,
                    oldPrice: 1999,
                    rating: 4,
                    reviews: "10 k reviews",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kprimary,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: Text(
            "View Cart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kwhite,
            ),
          ),
        ),
      ),
    );
  }
}

class CleaningCardList extends ConsumerStatefulWidget {
  const CleaningCardList({super.key});

  @override
  ConsumerState<CleaningCardList> createState() => _CleaningCardListState();
}

class _CleaningCardListState extends ConsumerState<CleaningCardList> {
 
  // Track booked status and count for each item
  List<bool> bookedStatus = [];
  List<int> countStatus = [];

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    final subCategory = ref.watch(serviceModelProvider);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subCategory.length,
      // padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        var item = subCategory[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image + Book Now / Counter
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${item.imageUrl}", 
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // Show a placeholder if image fails to load
                          return Image.asset(
                            "assets/images/logo.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    bookedStatus[index]
                        ? Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: kscoundPrimaryColor,
                            // /  border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (countStatus[index] > 0)
                                      countStatus[index]--;
                                    if (countStatus[index] == 0)
                                      bookedStatus[index] = false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  child: Text(
                                    "–",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kprimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${countStatus[index]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kprimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    countStatus[index]++;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: kprimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : InkWell(
                          onTap: () {
                            setState(() {
                              bookedStatus[index] = true;
                              countStatus[index] = 1;
                            });
                          },
                          child: Container(
                            // height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kscoundPrimaryColor,
                              // border: Border.all(color: kgrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 13,
                              ),
                              child: Text(
                                "Book Now",
                                style: TextStyle(color: kprimary, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(height: 8),
                    const Text(
                      "4 options",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Starts at ₹${item.priceOnetime}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kblack,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const Icon(
                            Icons.star_half,
                            size: 16,
                            color: Colors.orangeAccent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "4654646",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServicesDetailsScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: kprimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combo Offers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Combo Offers')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ComboSection(
                title: "Sparkle Combo",
                offerCode: "NEW15",
                service: "Basic home + Bathroom",
                price: 1499,
                oldPrice: 1999,
                rating: 4,
                reviews: "10 k reviews",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComboSection extends StatelessWidget {
  final String title;
  final String offerCode;
  final String service;
  final int price;
  final int oldPrice;
  final int rating;
  final String reviews;

  ComboSection({
    required this.title,
    required this.offerCode,
    required this.service,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kwhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/book_best.png"),
                      ),

                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                      //color: kblack,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: kscoundPrimaryColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: kprimary),
                            ),
                            child: Text(
                              "Extra 15% off for new users with NEW15",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "AED $price",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "AED $oldPrice",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 16,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "($reviews)",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor("#00B342"),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kscoundPrimaryColor,
                                // border: Border.all(width: 0.5,color: kgrey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              //height: 35,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  "Book Now",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: kprimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceListScreen extends ConsumerWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final subCategory = ref.watch(serviceModelProvider);
    return SizedBox(
      height: 160, // card उंची
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subCategory.length,
        itemBuilder: (context, index) {
          final service = subCategory[index];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade900, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${service.imageUrl}", // Use network URL here
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        // Show a placeholder if image fails to load
                        return Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    "${service.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
