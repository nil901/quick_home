import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/payment_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/util/enum.dart';
import '../../api_services/Providers.dart';
import '../../util/custom_app_bar.dart';

void clearProviders(WidgetRef ref) {
  ref.read(selectedCartProvider.notifier).state = null;
  ref.read(selectedPaymentProvider.notifier).state = null;
  ref.read(serviceDetailsProvider.notifier).state = null;
  ref.read(appliedCouponProvider.notifier).state = null;
}

class PaymentScreen extends ConsumerStatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedExpert;
  const PaymentScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedExpert,
  });
  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  Future<void> paymentAPi(WidgetRef ref) async {
    ref.read(serviceDetailsProvider.notifier).state = null;
    try {
      final selectedItem = ref.read(selectedCartProvider);
      final cartId = selectedItem?.id;
      final response = await ApiService.postRequest(getPayment, {
        "cartid": cartId,
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['status'] == true) {
        final details = PaymentModel.fromJson(response.data['data']);
        ref.read(selectedPaymentProvider.notifier).state = details;
        //  log("Service Details: ${details.data?.service?.name}");
      }
    } catch (e) {
      print("Error fetching service details: $e");
    }
  }

  Future<void> createBooking(WidgetRef ref, BuildContext context) async {
    try {
      final userId = await AppPreference().getInt(PreferencesKey.userId);
      final selectedItem = ref.read(selectedCartProvider);
      final cartId = selectedItem?.id;

      if (userId == null || cartId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User or Cart ID not found")),
        );
        return;
      }

      // 🗓 Convert "Oct 31, 2025" → "2025-10-31"
      final parsedDate = DateFormat("MMM dd, yyyy").parse(widget.selectedDate);
      final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      // ⏰ Convert "10:00 AM" → "10:00" (24-hour format)
      final parsedTime = DateFormat("hh:mm a").parse(widget.selectedTime);
      final formattedTime = DateFormat("HH:mm").format(parsedTime);

      // ✅ Final body exactly as API expects
      final body = {
        "user": userId,
        "cartid": cartId,
        "scheduledDate": formattedDate,
        "preferredTime": formattedTime,
      };

      print("📦 Final API Body => $body");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Creating booking...")));

      final response = await ApiService.postRequest(createBookingUrl, body);

      if (response.data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data["message"] ?? "Booking created"),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => MainHomeScreen(initialTab: BottomTab.bookings),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data["message"] ?? "Failed to create booking",
            ),
          ),
        );
      }
    } catch (e) {
      print("❌ Error creating booking: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentAPi(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPayment = ref.watch(selectedPaymentProvider);
    final selectedItem = ref.watch(selectedCartProvider);
    final addressList = ref.watch(addressProvider);
    final appliedCoupon = ref.watch(appliedCouponProvider);

    // 🏡 Find default address
    final defaultAddress =
        addressList.isNotEmpty
            ? addressList.firstWhere((a) => a.isDefault == true)
            : null;

    return WillPopScope(
      onWillPop: () async {
        clearProviders(ref);
        return true;
      },
      child: Scaffold(
        backgroundColor: HexColor('#FFFFFF'),
        appBar: CustomAppBar(
          title: 'Your Payment',
          showBackButton: () {
            clearProviders(ref);
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Dynamic Address Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: HexColor('#EAEAEA'), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/home.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    defaultAddress != null
                        ? Text(
                          defaultAddress.addressDetails ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        )
                        : const Text(
                          'No default address found. Please add one.',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => MainHomeScreen(initialTab: BottomTab.bookings),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: HexColor('#FFFFFF'),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: HexColor('#EAEAEA'), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/timeIcon.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 10),

                          Text(
                            '${widget.selectedDate}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ' - ${widget.selectedTime}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Text(
                          //   'Expert: $selectedExpert',
                          //   style: const TextStyle(
                          //     fontSize: 13,
                          //     color: Colors.black87,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Selected Service Card
              if (selectedItem != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: HexColor('#FFFFFF'),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: HexColor('#E2E2E2'), width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Image Section ---
                      Container(
                        width: 80,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: HexColor('#B5B5B5'),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            selectedItem.service?.image ?? '',
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

                      const SizedBox(width: 12),

                      // --- Text Section ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title
                            Text(
                              selectedItem.itemName ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#353535'),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 6),

                            // Description
                            Text(
                              selectedItem.service?.description ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 8),

                            // Divider (wrapped safely)
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFA1A1A1),
                            ),

                            const SizedBox(height: 8),

                            // Price
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'AED ${selectedItem.totalPrice}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#353535'),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),
              // 🔹 Coupons Section
              InkWell(
                onTap: () {
                  CouponBottomSheet.show(context);
                },

                child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: HexColor('#FCFCFC'),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: HexColor('#EAEAEA'), width: 0.25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.local_offer_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Coupons',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'All Coupons >',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Divider(
                        color: HexColor('#A1A1A1'),
                        thickness: 0.5,
                        height: 1,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (appliedCoupon != null)
                            Row(
                              children: [
                                Text(
                                  appliedCoupon,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Applied',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                          // 🔹 Remove Button
                          TextButton(
                            onPressed: () async{
                              print("DDDDDDDDDDDDDDDDDDDDDDD");
                              ref.read(appliedCouponProvider.notifier).state =
                                  null;
                                     await paymentAPi(ref);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Coupon removed")),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(40, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Container(
                              height: 19,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: HexColor('#969696'),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor('#646464'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // 🔹 Price Details Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: HexColor('#E4F9FF'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Item total'),
                        Text('AED ${selectedItem?.totalPrice ?? 0}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Taxes and fee'),
                        Text(
                          'AED ${selectedPayment?.pricingSummary?.taxAmount ?? 0}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Discount amount'),
                        Text(
                          'AED ${selectedPayment?.pricingSummary?.discountAmount ?? 0}',
                        ),
                      ],
                    ),
                    const Divider(height: 25, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total amount',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'AED ${selectedPayment?.pricingSummary?.totalAmount ?? 0}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Divider(height: 25, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Amount to pay'),
                        Text(
                          'AED ${selectedPayment?.pricingSummary?.totalAmount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 Book Service Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#004271'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    createBooking(ref, context);
                  },
                  child: const Text(
                    'Book Service',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CouponBottomSheet extends ConsumerStatefulWidget {
  const CouponBottomSheet({super.key});

  @override
  ConsumerState<CouponBottomSheet> createState() => _CouponBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black38,
      backgroundColor: Colors.transparent,
      builder: (context) => const CouponBottomSheet(),
    );
  }
}

class _CouponBottomSheetState extends ConsumerState<CouponBottomSheet> {
  final TextEditingController couponController = TextEditingController();
  Future<void> paymentAPi(WidgetRef ref) async {
   // ref.read(serviceDetailsProvider.notifier).state = null;
    try {
      final selectedItem = ref.read(selectedCartProvider);
      final cartId = selectedItem?.id;
      final response = await ApiService.postRequest(getPayment, {
        "cartid": cartId,
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['status'] == true) {
        final details = PaymentModel.fromJson(response.data['data']);
        ref.read(selectedPaymentProvider.notifier).state = details;
        //  log("Service Details: ${details.data?.service?.name}");
      }
    } catch (e) {
      print("Error fetching service details: $e");
    }
  }

  Future<void> applyCouponCode(
    BuildContext context,
    WidgetRef ref,
    String code,
  ) async {
    final userId = AppPreference().getInt(PreferencesKey.userId);
    final selectedItem = ref.read(selectedCartProvider);
    final cartId = selectedItem?.id;

    try {
      final response = await ApiService.postRequest(applyCoupon, {
        "user": userId,
        "cartid": cartId,
        "couponCode": code,
      });

      if (response.data["status"] == true) {
        final data = response.data["data"];
        final discount = data["cart_item"]["discount_amount"];
        final totalAmount = data["cart_totals"]["total_amount"];

        ref.read(appliedCouponProvider.notifier).state = code;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["message"] ?? "Coupon applied")),
        );
        paymentAPi(ref);
        // final selectedPayment = ref.read(selectedPaymentProvider);
        // if (selectedPayment != null) {
        //   ref.read(selectedPaymentProvider.notifier).state =
        //       selectedPayment.copyWith(
        //         pricingSummary: selectedPayment.pricingSummary?.copyWith(
        //           discountAmount: discount.toString(),
        //           totalAmount: totalAmount.toString(),
        //         ),
        //       );
        // }

        final selectedPayment = ref.read(selectedPaymentProvider);
        if (selectedPayment != null) {
          final updatedPayment = selectedPayment.copyWith(
            pricingSummary: selectedPayment.pricingSummary?.copyWith(
              discountAmount: discount.toString(),
              totalAmount: totalAmount.toString(),
            ),
          );

          // 👇 State update karega instantly
          ref.read(selectedPaymentProvider.notifier).state = updatedPayment;

          // 👇 Rebuild ko instantly force karne ke liye
          // ref.invalidate(selectedPaymentProvider);
        }

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["message"] ?? "Invalid coupon")),
        );
      }
    } catch (e) {
      print("❌ Error applying coupon: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to apply coupon")));
    }
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentData = ref.watch(selectedPaymentProvider);
    final apiCoupons = paymentData?.coupons ?? [];

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.transparent),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder:
              (context, scrollController) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: HexColor('#E4F9FF'),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 6,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Coupons",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: couponController,
                            decoration: InputDecoration(
                              hintText: "Enter Coupon Code",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xFFA1A1A1),
                                  width: 0.25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFA1A1A1),
                              width: 0.25,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              applyCouponCode(
                                context,
                                ref,
                                couponController.text.trim(),
                              );
                            },
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(thickness: 1, color: HexColor('#A1A1A1')),
                    const SizedBox(height: 12),
                    const Text(
                      "Special Offers",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child:
                          apiCoupons.isNotEmpty
                              ? ListView.builder(
                                controller: scrollController,
                                itemCount: apiCoupons.length,
                                itemBuilder: (context, index) {
                                  final coupon = apiCoupons[index].couponCode;
                                  if (coupon == null) return const SizedBox();
                                  return InkWell(
                                    onTap: () {
                                      applyCouponCode(
                                        context,
                                        ref,
                                        coupon.code ?? '',
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      width: 350,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: HexColor("#EAEAEA"),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  coupon.code ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: HexColor("#004271"),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  coupon.description ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "Discount: ${coupon.discountValue ?? ''} ${coupon.discountType ?? ''}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: HexColor("#FCFCFC"),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color: HexColor("#004271"),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              coupon.code ?? '',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: HexColor("#004271"),
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                              : const Center(
                                child: Text(
                                  "No coupons available.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
        ),
      ],
    );
  }
}
