import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/wishlist_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/cart_screen.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/util/no_data_found.dart';
import 'package:quick_home/util/ratting.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  bool isLoading = false;
  Future<void> wishlistApi(WidgetRef ref) async {
    setState(() {
      isLoading = true;
    });
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(wishlist, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        setState(() {
          isLoading = false;
        });
        print(data);

        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    wishlistApi(ref);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    const kprimary = Color(0xFF004271);
    const kscoundPrimaryColor = Color(0xFFE6F6FF);
    const kblack = Colors.black;
    final wishlist = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6F6FF),
        elevation: 0,
        title: InkWell(
          onTap: () {
            wishlistApi(ref);
          },
          child: Text(
            'My Wishlist',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: kprimary))
              : wishlist.isEmpty
              ? Center(child: NoDataFoundScreen(onRetry: () {}))
              : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.015,
                ),
                child: ListView.builder(
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    final item = wishlist[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left: Image + Book Now / Counter + Options
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.service?.imageUrl ?? '',
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            height: 80,
                                            width: 80,
                                            color: Colors.grey[200],
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                              color: Colors.grey,
                                              height: 40,
                                            ),
                                          );
                                        },
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                            height: 80,
                                            width: 80,
                                            alignment: Alignment.center,
                                            child:
                                                const CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kscoundPrimaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 13,
                                        ),
                                        child: Text(
                                          "Book Now",
                                          style: TextStyle(
                                            color: kprimary,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Text(
                                    //   "options 4",
                                    //   style: const TextStyle(
                                    //     fontSize: 13,
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(width: 12),

                                // Right: Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.service!.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.service!.shortDescription
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Starts at AED ${item.service!.priceOnetime}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: kblack,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          RatingStarsComman(
                                            rating:
                                                item.service!.averageRating ??
                                                0,
                                          ),
                                          Text(
                                            '(${item.service!.totalReviews} reviews)',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: HexColor("#353535"),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 15),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      ServicesDetailsScreen(
                                                        serviceId:
                                                            item.service!.id,
                                                        name:
                                                            item.service!.name
                                                                .toString(),
                                                      ),
                                            ),
                                          );
                                        },
                                        child: const Text(
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
                                ),
                              ],
                            ),
                          ),

                          // 🗑 Delete Icon (Top Right)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () async {
                                try {
                                  final response = await ApiService.postRequest(
                                    wishlistDelete,
                                    {
                                      "user":
                                          "${AppPreference().getInt(PreferencesKey.userId)}",
                                      "wishlist_id":
                                          item.wishlist?.id.toString(),
                                    },
                                  );
                                  print(response?.data['data']);
                                  if (response.data['success'] == true) {
                                    wishlistApi(ref);
                                    final data = response.data['data'] as List;
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(data);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print("Error fetching appointments: $e");
                                  throw Exception("Failed to load data");
                                }
                              },
                              child: Image.asset(
                                'assets/images/delete.png',
                                //color: Colors.black54,
                                height: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      bottomNavigationBar: Container(
        height: height * 0.08,
        decoration: const BoxDecoration(
          color: Color(0xFFE6F6FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
