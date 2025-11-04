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
    setState(() => isLoading = true);
    try {
      final response = await ApiService.postRequest(wishlist, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['success'] == true) {
        final List data = response.data['data'];
        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Wishlist Error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    wishlistApi(ref);
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = ref.watch(wishlistProvider);

    const kprimary = Color(0xFF004271);
    const kscoundPrimaryColor = Color(0xFFE6F6FF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kscoundPrimaryColor,
        elevation: 0,
        title: InkWell(
          onTap: () => wishlistApi(ref),
          child: const Text(
            'My Wishlist',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
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
              ? Center(
                child: NoDataFoundScreen(onRetry: () => wishlistApi(ref)),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final item = wishlist[index];
                  final service = item.wishlist?.service;

                  if (service == null) return const SizedBox();

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
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      service.imageUrl ?? '',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) => Container(
                                            height: 80,
                                            width: 80,
                                            color: Colors.grey[200],
                                            child: const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 13,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kscoundPrimaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Text(
                                      "Book Now",
                                      style: TextStyle(
                                        color: kprimary,
                                        fontSize: 15,
                                      ),
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
                                      service.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      service.shortDescription ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Starts at AED ${service.priceOnetime}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        RatingStarsComman(
                                          rating: service.averageRating ?? 0,
                                        ),
                                        Text(
                                          "(${service.totalReviews ?? 0} reviews)",
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
                                                (_) => ServicesDetailsScreen(
                                                  serviceId: service.id,
                                                  name: service.name ?? '',
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

                        Positioned(
                          top: 8,
                          right: 8,
                          child: InkWell(
                            onTap: () async {
                              await ApiService.postRequest(wishlistDelete, {
                                "user": AppPreference().getInt(
                                  PreferencesKey.userId,
                                ),
                                "wishlist_id": item.wishlist?.id.toString(),
                              });
                              wishlistApi(ref);
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
    );
  }
}
