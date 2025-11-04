import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/search_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/util/no_data_found.dart';
import 'package:quick_home/util/ratting.dart';
import 'package:quick_home/util/size.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;

  Future<void> searchApi(WidgetRef ref, String query) async {
    if (query.isEmpty) {
      ref.read(searchProvider.notifier).state = [];
      return;
    }

    try {
      setState(() => isLoading = true);

      final response = await ApiService.postRequest(getSearch, {
        "query": query,
      });
      if (response.data['success'] == true) {
        final data = response.data['data']['services'] as List;
        ref.read(searchProvider.notifier).state =
            data.map((json) => SearchModel.fromJson(json)).toList();
      } else {
        print("Failed: ${response.data['message']}");
      }
    } catch (e) {
      print("Error fetching search results: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    // searchApi(ref);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchList = ref.watch(searchProvider);
    return Material(
      color: kscoundPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kwhite,

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: kscoundPrimaryColor,
                  child: Column(
                    children: [
                      h40,
                      Row(
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: kblack,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        decoration: const InputDecoration(
                                          hintText: "Search here...!",
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          // Delay typing response by 500ms
                                          Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () => searchApi(ref, value),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      h20,
                    ],
                  ),
                ),
                h5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Popular Searches",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                h10,
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:
                        _searchController.text.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 5,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Washing machine repair',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w100,
                                          color: HexColor("#353535"),
                                        ),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: HexColor("#353535"),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            )
                            : searchList.isEmpty
                            ? NoDataFoundScreen(onRetry: () {})
                            : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                final item = searchList[index];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// ---- Left Image + Book Section ----
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.network(
                                              item.imageUrl ?? '',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
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
                                          InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   bookedStatus[index] = true;
                                              //   countStatus[index] = 1;
                                              // });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kprimary,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 12),

                                      /// ---- Right Content ----
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            /// Title + Wishlist Icon
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.name.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      final response =
                                                          await ApiService.postRequest(
                                                            wishlistAdd,
                                                            {
                                                              "user": AppPreference()
                                                                  .getInt(
                                                                    PreferencesKey
                                                                        .userId,
                                                                  ),
                                                              "service":
                                                                  item?.id
                                                                      .toString(),
                                                              "wishlisted":
                                                                  item.isWishlisted ==
                                                                          true
                                                                      ? 0
                                                                      : 1,
                                                            },
                                                          );
                                                      print(
                                                        response?.data['data'],
                                                      );
                                                      if (response
                                                              .data['success'] ==
                                                          true) {
                                                        final data =
                                                            response.data['data']
                                                                as List;
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
                                                      print(
                                                        "Error fetching appointments: $e",
                                                      );
                                                      throw Exception(
                                                        "Failed to load data",
                                                      );
                                                    }
                                                  },

                                                  child: Icon(
                                                    item.isWishlisted == true
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),

                                            /// Description
                                            Text(
                                              item.description.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            /// Price
                                            Text(
                                              "Starts at ₹${item.prices?.onetime ?? 0}",
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
                                                  rating:
                                                      item.averageRating
                                                          ?.toDouble() ??
                                                      0,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "(${item.totalReviews ?? 0} reviews)",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
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
                                                            ServicesDetailsScreen(
                                                              serviceId:
                                                                  item.id!,
                                                              name: item.name!,
                                                            ),
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
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
