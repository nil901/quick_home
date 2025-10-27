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
import 'package:quick_home/provide/wishlist_provider.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/util/ratting.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future<void> wishlistApi(WidgetRef ref) async {
    if (isLoading) return; // Prevent multiple simultaneous calls

    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });

    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      if (userId == null) {
        throw Exception("User ID not found");
      }

      final response = await ApiService.postRequest(wishlist, {"user": userId});

      if (response?.data == null) {
        throw Exception("Invalid response from server");
      }

      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? "Failed to load wishlist");
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: kprimary))
              : hasError
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error loading wishlist',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      errorMessage,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => wishlistApi(ref),
                      child: Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimary,
                      ),
                    ),
                  ],
                ),
              )
              : wishlist.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty_wishlist.png',
                      height: 120,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your wishlist is empty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add items that you like to your wishlist',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
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
                                                      ServicesDetailsScreen(),
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
                                      "user": AppPreference().getInt(
                                        PreferencesKey.userId,
                                      ),
                                      "wishlist_id":
                                          item.wishlist?.id.toString(),
                                    },
                                  );

                                  if (response.data['success'] == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Item removed from wishlist',
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    wishlistApi(ref);
                                  } else {
                                    throw Exception(
                                      response.data['message'] ??
                                          'Failed to remove item',
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to remove item: ${e.toString()}',
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
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
