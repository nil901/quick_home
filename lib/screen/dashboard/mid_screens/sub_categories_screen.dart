import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/home_prov.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/util/ratting.dart';
import 'package:quick_home/util/size.dart';

class SubCategoriesscreenDetails extends ConsumerStatefulWidget {
  const SubCategoriesscreenDetails({super.key, this.catId});
  final catId;

  @override
  ConsumerState<SubCategoriesscreenDetails> createState() =>
      _SubCategoriesscreenDetailsState();
}

class _SubCategoriesscreenDetailsState
    extends ConsumerState<SubCategoriesscreenDetails> {
  List<int> counters = [1, 0, 0];
  @override
  void initState() {
    HomeServices().subCategoriesApi(ref, widget.catId);
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

                  // ComboSection(
                  //   title: "Fresh & Comfy Combo",
                  //   offerCode: "NEW15",
                  //   service: "Sofa + Carpet cleaning",
                  //   price: 1499,
                  //   oldPrice: 1999,
                  //   rating: 4,
                  //   reviews: "25 k reviews",
                  // ),
                  // SizedBox(height: 20),
                  // ComboSection(
                  //   title: "Sparkle Combo",
                  //   offerCode: "NEW15",
                  //   service: "Basic home + Bathroom",
                  //   price: 1499,
                  //   oldPrice: 1999,
                  //   rating: 4,
                  //   reviews: "10 k reviews",
                  // ),
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
  List<bool> bookedStatus = [];
  List<int> countStatus = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subCategory = ref.read(productProvider);
      if (subCategory.isNotEmpty) {
        setState(() {
          bookedStatus = List.filled(subCategory.length, false);
          countStatus = List.filled(subCategory.length, 0);
        });
      }
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final subCategory = ref.watch(productProvider);

    // Handle case when provider updates later (e.g. after API call)
    if (bookedStatus.length != subCategory.length) {
      bookedStatus = List.filled(subCategory.length, false);
      countStatus = List.filled(subCategory.length, 0);
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subCategory.length,
      itemBuilder: (context, index) {
        final item = subCategory[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- Left Image + Book Section ----
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/logo.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ---- Book Now / Counter ----
                  bookedStatus[index]
                      ? Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: kscoundPrimaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (countStatus[index] > 0) {
                                    countStatus[index]--;
                                  }
                                  if (countStatus[index] == 0) {
                                    bookedStatus[index] = false;
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "–",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${countStatus[index]}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  countStatus[index]++;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  '+',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                          decoration: BoxDecoration(
                            color: kscoundPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 14,
                          ),
                          child: const Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                  const SizedBox(height: 8),
                  const Text(
                    "4 options",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              /// ---- Right Content ----
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Wishlist Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            print(
                              "❤️ Tapped on: ${item.name} (ID: ${item.id}) | Current isWishlisted: ${item.isWishlisted}",
                            );
                            setState(() => isLoading = true);

                            // 🔹 Optimistic UI Update (icon turant change ho)
                            setState(() {
                              item.isWishlisted = !(item.isWishlisted ?? false);
                            });

                            try {
                              final response =
                                  await ApiService.postRequest(wishlistAdd, {
                                    "user": AppPreference().getInt(
                                      PreferencesKey.userId,
                                    ),
                                    "service": item.id.toString(),
                                    "wishlisted":
                                        item.isWishlisted == true ? 1 : 0,
                                  });

                              print("✅ Server Response: ${response.data}");

                              if (response.data['success'] == true) {
                                // ✅ Refresh list
                                await HomeServices().SubcategoreyProductApi(
                                  ref,
                                  item.subcategoryId,
                                );
                              } else {
                                print(
                                  "⚠️ Server reported failure: ${response.data['message'] ?? 'No message'}",
                                );
                                // 🔹 Revert icon if failed
                                setState(() {
                                  item.isWishlisted =
                                      !(item.isWishlisted ?? false);
                                });
                              }
                            } catch (e) {
                              print("❌ Exception on wishlist toggle: $e");
                              // 🔹 Revert icon if error
                              setState(() {
                                item.isWishlisted =
                                    !(item.isWishlisted ?? false);
                              });
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: Icon(
                            item.isWishlisted == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color:
                                item.isWishlisted == true
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    /// Description
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),

                    /// Price
                    Text(
                      "Starts at ₹${item.priceOnetime}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Rating Row
                    Row(
                      children: [
                        RatingStarsComman(
                          rating: item.averageRating ?? 0,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${item.totalReviews ?? 0} reviews)",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// View Details
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ServicesDetailsScreen(serviceId: item.id),
                          ),
                        );
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          return InkWell(
            onTap: () {
              print(
                "wwwwwwwwwwwwwwwwwwwwwwwwwwwwww${subCategory[index].subcategoryId}",
              );
              HomeServices().SubcategoreyProductApi(ref, service.subcategoryId);
            },
            child: Container(
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
            ),
          );
        },
      ),
    );
  }
}
