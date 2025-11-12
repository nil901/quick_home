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
import 'package:quick_home/util/size.dart';

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

    try {
      final response = await ApiService.postRequest(getCart, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      final int? statusCode = response.statusCode;

      // 🔹 जर 404 आला तर — जुना डेटा क्लिअर करा आणि notify करा
      if (statusCode == 404) {
        ref.read(cartProvider.notifier).update((state) => []);
        debugPrint("Cart cleared: status 404");
        setState(() => isLoading = false);
        return;
      }

      if (response.data['status'] == true) {
        final List<dynamic> data = response.data['data']['cart_items'] ?? [];

        // 🔹 आधी जुना डेटा clear करा
        ref.read(cartProvider.notifier).update((state) => []);

        // 🔹 नवीन डेटा तयार करा
        final List<CartModel> newCartItems =
            data.map((json) => CartModel.fromJson(json)).toList();

        // 🔹 नवीन डेटा assign करा
        ref.read(cartProvider.notifier).update((state) => newCartItems);

        debugPrint("Cart updated successfully (${newCartItems.length} items)");
      } else {
        // जर status false असेल तरी clear करा
        ref.read(cartProvider.notifier).update((state) => []);
        debugPrint("Cart API returned false status");
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching cart items: $e");
      debugPrintStack(stackTrace: stackTrace);

      // 🔹 Error आल्यासही जुना डेटा clear करा
      ref.read(cartProvider.notifier).update((state) => []);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                          allow_increment: item.allowIncrement ?? 0,
                          index: index,
                          quantity: item.quantity!,
                          isSelected: _selectedIndex == index,
                          onSelect: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            ref.read(selectedCartProvider.notifier).state =
                                item;
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
                    child: Column(
                      children: [
                        // ✅ Conditionally show buttons only when item is selected
                        if (_selectedIndex != null) ...[
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // Action for "Add Services"
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Add Services tapped"),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: kprimary,
                                        width: 1,
                                      ),
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
                                    if (_selectedIndex != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => SelectedMyAddress(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please select a service first",
                                          ),
                                        ),
                                      );
                                    }
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
                        ] else ...[
                          // ✅ Show disabled buttons or message when nothing is selected
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please select an item first",
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add Services",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please select an item first",
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade400,
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
                        ],
                      ],
                    ),
                  ),
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
    required int allow_increment,
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
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: kscoundPrimaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    // Quantity selector
                                    Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: kscoundPrimaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // ➖ Minus button
                                          GestureDetector(
                                            onTap: () async {
                                              if (quantity > 1) {
                                                await updateQuantity(
                                                  cartId,
                                                  quantity - 1,
                                                );
                                              } else {
                                                if (allow_increment == 0) {
                                                  final response =
                                                      await ApiService.postRequest(
                                                        deleteCart,
                                                        {
                                                          "user": AppPreference()
                                                              .getInt(
                                                                PreferencesKey
                                                                    .userId,
                                                              ),
                                                          "cartid": cartId,
                                                        },
                                                      );

                                                  if (response.data['status'] ==
                                                      true) {
                                                    ref
                                                        .read(
                                                          cartProvider.notifier,
                                                        )
                                                        .update((state) {
                                                          return state
                                                              .where(
                                                                (item) =>
                                                                    item.id
                                                                        .toString() !=
                                                                    cartId,
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
                                                } else {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Minimum quantity is 1",
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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

                                          // Quantity number
                                          Text(
                                            '$quantity',
                                            style: TextStyle(fontSize: 16),
                                          ),

                                          // ➕ Plus button
                                          GestureDetector(
                                            onTap:
                                                allow_increment == 1
                                                    ? () async {
                                                      await updateQuantity(
                                                        cartId,
                                                        quantity + 1,
                                                      );
                                                    }
                                                    : null, // disabled
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6.0,
                                                  ),
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                                color:
                                                    allow_increment == 1
                                                        ? kprimary
                                                        : Colors.grey.shade400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),
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
                                        SnackBar(
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

                              w10,
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
