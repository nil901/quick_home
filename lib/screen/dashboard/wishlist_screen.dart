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
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
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
    try {
      final response = await ApiService.postRequest(wishlist, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print("📦 API Response: ${response?.data}");
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        print("⚠️ Wishlist API returned success=false");
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching wishlist: $e");
      print("🔍 StackTrace: $stackTrace");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    wishlistApi(ref);
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
          child: const Text(
            'My Wishlist',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
              ? const Center(child: CircularProgressIndicator(color: kprimary))
              : (wishlist.isEmpty)
              ? const Center(
                child: Text(
                  "No items in your wishlist",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
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
                    final service = item.service;

                    // Safe check
                    if (service == null) return const SizedBox.shrink();

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
                                // Left: Image + Book Now
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        service.imageUrl ??
                                            'https://via.placeholder.com/150',
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
                                          progress,
                                        ) {
                                          if (progress == null) return child;
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
                                        service.name ?? "Unnamed Service",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        service.shortDescription ??
                                            "No description available",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Starts at AED ${service.priceOnetime ?? '0'}",
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
                                                service.averageRating ?? 0.0,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '(${service.totalReviews ?? 0} reviews)',
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
                                                        serviceId: service.id,
                                                        name:
                                                            service.name ?? "",
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

                          // 🗑 Delete Icon
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
                                  print(
                                    "🗑 Delete Response: ${response?.data}",
                                  );
                                  if (response.data['success'] == true) {
                                    print(
                                      "✅ Wishlist item deleted successfully",
                                    );
                                    wishlistApi(ref);
                                  } else {
                                    print("⚠️ Wishlist delete failed");
                                  }
                                } catch (e, stackTrace) {
                                  print("❌ Error deleting wishlist item: $e");
                                  print("🔍 StackTrace: $stackTrace");
                                }
                              },
                              child: Image.asset(
                                'assets/images/delete.png',
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
