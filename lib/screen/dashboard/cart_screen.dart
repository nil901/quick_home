import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/cart_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import 'package:quick_home/util/no_data_found.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  int? _selectedIndex;
  bool isLoading = false;
  @override
  void initState() {
    cartApi(ref);

    // TODO: implement initState
    super.initState();
  }

  Future<void> cartApi(WidgetRef ref) async {
    setState(() {
      isLoading = true;
    });
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(getCart, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print(response?.data['data']);
      if (response.data['status'] == true) {
        final data = response.data['data']['cart_items'] as List;
        setState(() {
          isLoading = false;
        });
        print(data);

        ref.read(cartProvider.notifier).state =
            data.map((json) => CartModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "My Cart"),
      backgroundColor: Colors.white,
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : cart.isEmpty
              ? NoDataFoundScreen(
                onRetry: () {
                  cartApi(ref);
                },
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return _buildServiceCard(
                          index: index,
                          quantity: item.quantity!,
                          isSelected: _selectedIndex == index,
                          onSelect: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          cartId: item.id.toString(),
                          imagePath: item.service!.image.toString(),
                          title: item.itemName.toString(),
                          description: item.service!.description.toString(),
                          price: 'AED ${item.totalPrice.toString()}',
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: kprimary, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add Services",
                                style: TextStyle(
                                  color: kprimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedMyAddress(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kprimary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(0, 44),
                            ),
                            child: const Text("Add address & slot"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
    );
  }

  Widget _buildServiceCard({
    required int index,
    required bool isSelected,
    required VoidCallback onSelect,
    required String imagePath,
    required String title,
    required String description,
    required String price,
    required String cartId,
    required int quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? kprimary : const Color(0xFFE2E2E2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔘 Radio button
                Padding(
                  padding: const EdgeInsets.only(top: 36, right: 6),
                  child: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? kprimary : Colors.grey,
                    size: 20,
                  ),
                ),

                // Left Image
                Container(
                  width: 80,
                  height: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE2E2E2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Right Side Text + Actions
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: kprimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Divider(color: HexColor("#A1A1A1"), thickness: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: kprimary,
                            ),
                          ),
                          Row(
                            children: [
                              // Quantity selector
                              Container(
                                width: 63,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: kscoundPrimaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Minus button
                                    GestureDetector(
                                      onTap: () async {
                                        if (quantity > 1) {
                                          await updateQuantity(
                                            cartId,
                                            quantity - 1,
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                        ),
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: kprimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    // Plus button
                                    GestureDetector(
                                      onTap: () async {
                                        await updateQuantity(
                                          cartId,
                                          quantity + 1,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                        ),
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: kprimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Delete button
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final response =
                                        await ApiService.postRequest(
                                          deleteCart,
                                          {
                                            "user": AppPreference().getInt(
                                              PreferencesKey.userId,
                                            ),
                                            "cartid": cartId,
                                          },
                                        );

                                    if (response.data['status'] == true) {
                                      ref.read(cartProvider.notifier).update((
                                        state,
                                      ) {
                                        return state
                                            .where(
                                              (item) =>
                                                  item.id.toString() != cartId,
                                            )
                                            .toList();
                                      });

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Item removed from cart",
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Failed to delete item",
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print("Error deleting cart item: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Something went wrong"),
                                      ),
                                    );
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/delete.png',
                                  width: 17,
                                  height: 22,
                                  color: kprimary,
                                ),
                              ),
                            ],
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
      ),
    );
  }

  // Quantity update function
  Future<void> updateQuantity(String cartId, int newQuantity) async {
    try {
      // ✅ Update locally immediately
      ref.read(cartProvider.notifier).update((state) {
        return state.map((item) {
          if (item.id.toString() == cartId) {
            return item.copyWith(quantity: newQuantity);
          }
          return item;
        }).toList();
      });

      // ✅ API call to update on server
      final response = await ApiService.postRequest(cartUpdateQuantity, {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "cartid": cartId,
        "quantity": newQuantity,
      });

      if (response.data['status'] != true) {
        // Rollback in case server fails
        ref.read(cartProvider.notifier).update((state) {
          return state.map((item) {
            if (item.id.toString() == cartId) {
              return item.copyWith(
                quantity: newQuantity - 1,
              ); // Example rollback
            }
            return item;
          }).toList();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update quantity")),
        );
      }
    } catch (e) {
      print("Error updating quantity: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
