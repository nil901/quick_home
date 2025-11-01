import 'dart:developer';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/service_details_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/home_prov.dart';
import 'package:quick_home/screen/dashboard/cart_screen.dart';
import 'package:quick_home/screen/dashboard/home_Screen.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/screen/wigets/faq_comman.dart';
import 'package:quick_home/screen/wigets/how_many_pepole.dart';
import 'package:quick_home/screen/wigets/matrial_options.dart';
import 'package:quick_home/screen/wigets/service_option.dart';
import 'package:quick_home/util/enum.dart';
import 'package:quick_home/util/ratting.dart';
import 'package:quick_home/util/size.dart';
import 'package:quick_home/util/toast_msg.dart';

class ServicesDetailsScreen extends ConsumerStatefulWidget {
  const ServicesDetailsScreen({
    super.key,
    required this.serviceId,
    required this.name,
  });
  final int serviceId;
  final String name;
  @override
  ConsumerState<ServicesDetailsScreen> createState() =>
      _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends ConsumerState<ServicesDetailsScreen> {
  bool isEnglish = true;
  bool isButtonDisabled = false;
  final showAddToCartProvider = StateProvider<bool>((ref) => false);

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ServiceDetailsAPi(ref);
    });
  }

  bool _isLoading = false;
  Future<void> ServiceDetailsAPi(WidgetRef ref) async {
    ref.read(serviceDetailsProvider.notifier).state = null;
    try {
      final response = await ApiService.postRequest(viewService, {
        ""
                "service":
            widget.serviceId,
        "type": "",
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['success'] == true) {
        final details = ServiceDetailsModel.fromJson(response.data);
        ref.read(serviceDetailsProvider.notifier).state = details;
        //  log("Service Details: ${details.data?.service?.name}");
      }
    } catch (e) {
      print("Error fetching service details: $e");
    }
  }

  @override
  void dispose() {
    // Reset providers when the screen is disposed (e.g., when navigating back)
    // This ensures the screen is fresh every time it's opened.
    Future.microtask(() {
      ref.invalidate(serviceDetailsProvider);
      ref.invalidate(selectedPlanProvider);
      ref.invalidate(selectedMaterialProvider);
      ref.invalidate(cardClickStateProvider);
      ref.invalidate(cleanerCountProvider);
    });
    super.dispose();
  }

  void resetBookNowStateAndRemoveFromCart() async {
    // 👇 Step 1: Book Now UI reset kar
    ref.read(showAddToCartProvider.notifier).state = false;

    // 👇 Step 2: API se item remove kar
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "http://admin.qwikhom.ae/api/removeFromCart",
        data: {
          "user": AppPreference().getInt(PreferencesKey.userId),
          "service": widget.serviceId,
        },
      );

      if (response.data['status'] == true) {
        print("🟢 Item removed from cart successfully!");
      } else {
        print("❌ Failed to remove from cart: ${response.data['message']}");
      }
    } catch (e) {
      print("⚠ Error removing item: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceDetails = ref.watch(serviceDetailsProvider);
    final service = serviceDetails?.data?.service;
    return WillPopScope(
      onWillPop: () async {
        try {
          print("🔄 Trying to clear cache before going back...");

          // 🔹 Clear Riverpod providers
          ref.invalidate(selectedPlanProvider);
          ref.invalidate(selectedMaterialProvider);
          ref.invalidate(cleanerCountProvider);
          ref.invalidate(cardClickStateProvider);

          print("🧹 Cache cleared successfully! ✅");
        } catch (e, stackTrace) {
          print("❌ Cache clear failed on back: $e");
          print("📄 Stack Trace: $stackTrace");
        }

        // ✅ Allow the back navigation
        return true;
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFE4F9FF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              try {
                print("🔄 Trying to clear cache...");

                // 🔹 Invalidate all providers (Riverpod)
                ref.invalidate(selectedPlanProvider);
                ref.invalidate(selectedMaterialProvider);
                ref.invalidate(cleanerCountProvider);
                ref.invalidate(cardClickStateProvider);

                // 🔹 Confirmation
                print("🧹 Cache cleared successfully! ✅");

                // 🔹 Navigate back to Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MainHomeScreen(initialTab: BottomTab.home),
                  ),
                );
              } catch (e, stackTrace) {
                // 🔹 If something goes wrong
                print("❌ Cache clear failed: $e");
                print("📄 Stack Trace: $stackTrace");
              }
            },
          ),

          title: Row(
            children: [
              Flexible(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body:
            service == null
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     ServiceDetailsAPi(ref);
                                //     setState(() => isEnglish = true);
                                //   },
                                //   child: _langButton(
                                //     selected: isEnglish,
                                //     text: 'In English',
                                //   ),
                                // ),
                                const SizedBox(width: 8),
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() => isEnglish = false);
                                //   },
                                //   child: _langButton(
                                //     selected: !isEnglish,
                                //     text: 'In Arabic',
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // Top Image
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage('${service?.imageUrl}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          //Title, Rating, Price, Book Now
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${service?.name}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  isEnglish
                                      ? '${service?.description}'
                                      : 'ملابس خالية من التجاعيد، نظيفة وجاهزة للارتداء في أي وقت.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    RatingStarsComman(
                                      rating: service?.averageRating ?? 0,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    const SizedBox(width: 4),
                                    Text(
                                      '(${service?.totalReviews ?? 0} reviews)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'AED ${service?.subscriptionPlans?.firstWhere((e) => e.frequencyType == "onetime")?.pricePerTime ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(width: 8),
                                    const Spacer(),
                                    Builder(
                                      builder: (context) {
                                        bool showQuantity =
                                            (serviceDetails
                                                    ?.data
                                                    ?.inCartQuantity ??
                                                0) >
                                            0;

                                        if (showQuantity) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // ➖ Minus Button
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xffE4F9FF,
                                                  ),
                                                  foregroundColor: const Color(
                                                    0xff004271,
                                                  ),
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  elevation: 0,
                                                ),
                                                onPressed: () async {
                                                  final currentQty =
                                                      serviceDetails
                                                          ?.data
                                                          ?.inCartQuantity ??
                                                      0;

                                                  if (currentQty > 1) {
                                                    await updateQuantity(
                                                      serviceDetails!
                                                          .data!
                                                          .service!
                                                          .id
                                                          .toString(),
                                                      currentQty - 1,
                                                    );
                                                    setState(() {});
                                                  } else {
                                                    await updateQuantity(
                                                      serviceDetails!
                                                          .data!
                                                          .service!
                                                          .id
                                                          .toString(),
                                                      0,
                                                    );
                                                    setState(() {});
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 18,
                                                ),
                                              ),

                                              // Quantity Display
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xffE4F9FF,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "${serviceDetails?.data?.inCartQuantity ?? 1}",
                                                  style: const TextStyle(
                                                    color: Color(0xff004271),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              // ➕ Plus Button
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xffE4F9FF,
                                                  ),
                                                  foregroundColor:
                                                      (serviceDetails
                                                                      ?.data
                                                                      ?.allowIncrement ??
                                                                  0) ==
                                                              0
                                                          ? Colors
                                                              .grey // disabled color
                                                          : const Color(
                                                            0xff004271,
                                                          ),
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  elevation: 0,
                                                ),
                                                onPressed:
                                                    (serviceDetails
                                                                    ?.data
                                                                    ?.allowIncrement ??
                                                                0) ==
                                                            0
                                                        ? null // disable button
                                                        : () async {
                                                          await updateQuantity(
                                                            serviceDetails!
                                                                .data!
                                                                .service!
                                                                .id
                                                                .toString(),
                                                            (serviceDetails
                                                                        .data!
                                                                        .inCartQuantity ??
                                                                    0) +
                                                                1,
                                                          );
                                                          setState(() {});
                                                        },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xffE4F9FF,
                                              ),
                                              foregroundColor: const Color(
                                                0xff004271,
                                              ),
                                              elevation: 0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 22,
                                                    vertical: 10,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: () async {
                                              ref
                                                  .read(
                                                    showAddToCartProvider
                                                        .notifier,
                                                  )
                                                  .state = true;
                                              await updateQuantity(
                                                serviceDetails!
                                                    .data!
                                                    .service!
                                                    .id
                                                    .toString(),
                                                1,
                                              );
                                              setState(() {});
                                            },
                                            child: Text(
                                              isEnglish
                                                  ? 'Book Now'
                                                  : 'احجز الآن',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Divider(thickness: 0.9),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Text(
                              isEnglish ? 'About the service' : 'عن الخدمة',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              isEnglish
                                  ? '${service?.description}'
                                  : 'وداعًا للتجاعيد! خدمة الكي الاحترافية تضمن أن ملابسك تبدو مرتبة ونظيفة وجاهزة للارتداء في أي وقت.',
                              style: const TextStyle(
                                fontSize: 13.2,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Divider(thickness: 0.9, color: Colors.grey[300]),
                          // Our Process Title
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Text(
                              isEnglish
                                  ? 'Select requirements'
                                  : 'حدد المتطلبات',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),

                          ServiceOptions(
                            plans: service.subscriptionPlans!,
                            onPlanSelected: () async {
                              await updateQuantity(
                                serviceDetails!.data!.service!.id.toString(),
                                (serviceDetails.data!.inCartQuantity ?? 0) - 1,
                              );
                              setState(() {});
                              print("ldmfldmfldmf");
                            },
                          ),
                          Divider(thickness: 0.3),

                          const CleanerCountSelector(),
                          Divider(thickness: 0.3),

                          MaterialOptions(
                            material: serviceDetails!.data!.service!,
                          ),

                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: service.processes?.length,
                            itemBuilder: (context, index) {
                              final step = service.processes![index];

                              final isImageLeft = index % 2 == 1 ? true : false;

                              return _timelineStep(
                                stepNum: index + 1,
                                isImageLeft: isImageLeft,
                                imagePath: step.imageUrl ?? '',
                                title: isEnglish ? step.title! : step.title!,
                                description:
                                    isEnglish
                                        ? step.description
                                        : step.description.toString(),
                                isLast: index == service.processes!.length - 1,
                              );
                            },
                          ),

                          const SizedBox(height: 18),
                          Divider(thickness: 0.9, color: Colors.grey[300]),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Text(
                              isEnglish
                                  ? "What's Included?"
                                  : 'ما الذي يتضمنه ذلك؟',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: service.whatsInclude?.length,
                                  itemBuilder: (context, index) {
                                    final text = service.whatsInclude?[index];
                                    return _includedText(
                                      isEnglish ? text : text,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          Divider(thickness: 0.9, color: Colors.grey[300]),
                          // What We Need From You (card style)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Text(
                              isEnglish
                                  ? 'What We Need From You'
                                  : 'ما الذي نحتاجه منك',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: SizedBox(
                              height: 120, // <--- fix: define a height
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: service.requirements?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final req = service.requirements?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: neededCard(
                                      icon: Image.network(
                                        req?.imageUrl ?? '',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            'assets/images/logo.png',
                                            height: 50,
                                            width: 50,
                                            color: kgrey,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                      text:
                                          isEnglish
                                              ? (req?.title ?? 'Requirement')
                                              : 'متطلب الخدمة',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Text(
                                  'Frequently asked questions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: FaqComman(faqData: service.faq),
                          ), // tumhare FAQ ki class ka naam yahan daalo
                          const SizedBox(height: 20),

                          ///buildQuantityOrBookButton(serviceDetails),
                          h50,
                        ],
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final showAddToCart = ref.watch(
                            showAddToCartProvider,
                          );

                          // 🔹 Yahan listener lagaya hai — agar user koi option change kare
                          // (plan, cleaner, material), to Book Now wapas normal ho jaye
                          ref.listen(selectedPlanProvider, (prev, next) {
                            ref.read(showAddToCartProvider.notifier).state =
                                false;
                          });
                          ref.listen(cleanerCountProvider, (prev, next) {
                            ref.read(showAddToCartProvider.notifier).state =
                                false;
                          });
                          ref.listen(selectedMaterialProvider, (prev, next) {
                            ref.read(showAddToCartProvider.notifier).state =
                                false;
                          });
                          ref.listen(cardClickStateProvider, (prev, next) {
                            ref.read(showAddToCartProvider.notifier).state =
                                false;
                          });

                          return Row(
                            children: [
                              if (!showAddToCart) ...[
                                // 🟦 CANCEL BUTTON
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ref.invalidate(selectedPlanProvider);
                                      ref.invalidate(selectedMaterialProvider);
                                      ref.invalidate(cardClickStateProvider);
                                      ref.invalidate(cleanerCountProvider);
                                      setState(() {});
                                      print("✅ Cache cleared successfully!");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // 🟩 BOOK NOW BUTTON
                                Expanded(
                                  child: Consumer(
                                    builder: (context, ref, _) {
                                      final selectedPlan = ref.watch(
                                        selectedPlanProvider,
                                      );
                                      final cardClickState = ref.watch(
                                        cardClickStateProvider,
                                      );
                                      final selectedMaterial = ref.watch(
                                        selectedMaterialProvider,
                                      );
                                      final selectedCount =
                                          ref.watch(cleanerCountProvider) ?? 0;

                                      double totalPrice = 0;

                                      if (selectedPlan != null) {
                                        totalPrice +=
                                            (double.tryParse(
                                                  selectedPlan.pricePerTime ??
                                                      '0',
                                                ) ??
                                                0) *
                                            selectedCount;
                                      }

                                      if (selectedMaterial == "With Material" ||
                                          cardClickState == true) {
                                        final materialPrice =
                                            (serviceDetails
                                                        ?.data
                                                        ?.service
                                                        ?.withMaterialPrice ??
                                                    0)
                                                .toDouble();
                                        totalPrice +=
                                            materialPrice; // only once
                                      }

                                      return ElevatedButton(
                                        onPressed: () async {
                                          final selectedPlan = ref.read(
                                            selectedPlanProvider,
                                          );
                                          final selectedCount =
                                              ref.read(cleanerCountProvider) ??
                                              0;
                                          final withMaterial =
                                              ref.read(cardClickStateProvider)
                                                  ? 1
                                                  : 0;

                                          if (selectedPlan == null) {
                                            Utils().showTost(
                                              "Please select a plan first",
                                            );
                                            return;
                                          }

                                          try {
                                            Dio dio = Dio();

                                            FormData
                                            formData = FormData.fromMap({
                                              "user": AppPreference().getInt(
                                                PreferencesKey.userId,
                                              ),
                                              "service": widget.serviceId,
                                              "package": selectedPlan.id,
                                              "material": withMaterial,
                                              "providersCount": selectedCount,
                                            });

                                            // Debugging ke liye print
                                            formData.fields.forEach(
                                              (f) =>
                                                  print("${f.key}: ${f.value}"),
                                            );

                                            final response = await dio.post(
                                              "http://admin.qwikhom.ae/api/addToCart",
                                              data: formData,
                                            );

                                            if (response.data['status'] ==
                                                true) {
                                              print(
                                                "✅ Added to cart successfully",
                                              );
                                              Utils().showTost(
                                                "Added to cart successfully",
                                              );

                                              // ✅ Navigate to CartScreen

                                              // 🧹 After coming back → clear cache + refresh UI
                                              try {
                                                print(
                                                  "🔄 Trying to clear cache...",
                                                );

                                                ref.invalidate(
                                                  selectedPlanProvider,
                                                );
                                                ref.invalidate(
                                                  selectedMaterialProvider,
                                                );
                                                ref.invalidate(
                                                  cleanerCountProvider,
                                                );
                                                ref.invalidate(
                                                  cardClickStateProvider,
                                                );
                                                ref.invalidate(
                                                  showAddToCartProvider,
                                                );

                                                print(
                                                  "🧹 Cache cleared successfully! ✅",
                                                );
                                                await Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const CartScreen(),
                                                  ),
                                                );

                                                // 🔁 Full rebuild trigger
                                                if (context.mounted) {
                                                  setState(() {});
                                                }

                                                print(
                                                  "🔁 Page fully refreshed!",
                                                );
                                              } catch (e) {
                                                print(
                                                  "⚠ Cache clear error: $e",
                                                );
                                              }
                                            } else {
                                              print(
                                                "❌ Failed: ${response.data['message']}",
                                              );
                                              Utils().showTost(
                                                "Failed: ${response.data['message']}",
                                              );
                                            }
                                          } catch (e) {
                                            print("⚠ Error: $e");
                                            Utils().showTost(
                                              "Something went wrong",
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xff004271,
                                          ),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Book Now (AED ${totalPrice.toStringAsFixed(2)})',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ] else ...[
                                // 🟧 ADD TO CART BUTTON
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // ✅ Navigate to Cart Screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const CartScreen(),
                                        ),
                                      ).then((_) {
                                        // ✅ Back aane ke baad cache clear hoga
                                        ref.invalidate(selectedPlanProvider);
                                        ref.invalidate(
                                          selectedMaterialProvider,
                                        );
                                        ref.invalidate(cardClickStateProvider);
                                        ref.invalidate(cleanerCountProvider);
                                        ref.invalidate(showAddToCartProvider);
                                        print(
                                          "🧹 Cache cleared after returning from CartScreen!",
                                        );
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff004271),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'View Cart',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget buildQuantityOrBookButton(ServiceDetailsModel? serviceDetails) {
    final qty = serviceDetails?.data?.inCartQuantity ?? 0;

    if (qty > 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ➖ Minus Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffE4F9FF),
              foregroundColor: const Color(0xff004271),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              elevation: 0,
            ),
            onPressed: () async {
              final newQty = (qty - 1).clamp(0, 100); // 0 min, 100 max
              await updateQuantity(
                serviceDetails!.data!.service!.id.toString(),
                newQty,
              );
              setState(() {});
            },
            child: const Icon(Icons.remove, size: 18),
          ),

          // Quantity Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffE4F9FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$qty",
              style: const TextStyle(
                color: Color(0xff004271),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),

          // ➕ Plus Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffE4F9FF),
              foregroundColor: const Color(0xff004271),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              elevation: 0,
            ),
            onPressed: () async {
              final newQty = (qty + 1).clamp(0, 100); // 0 min, 100 max
              await updateQuantity(
                serviceDetails!.data!.service!.id.toString(),
                newQty,
              );
              setState(() {});
            },
            child: const Icon(Icons.add, size: 18),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE4F9FF),
          foregroundColor: const Color(0xff004271),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          await updateQuantity(
            serviceDetails!.data!.service!.id.toString(),
            1, // start quantity
          );
          setState(() {});
        },
        child: Text(
          isEnglish ? 'Book Now' : 'احجز الآن',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }
  }

  Future<void> updateQuantity(String cartId, int newQuantity) async {
    try {
      print(
        "🧾 Updating quantity for cartId: $cartId | New quantity: $newQuantity",
      );

      // 1️⃣ Update local cart immediately (optimistic update)
      ref.read(cartProvider.notifier).update((state) {
        if (state == null) return state;
        return state.map((item) {
          if (item.id.toString() == cartId) {
            return item.copyWith(quantity: newQuantity);
          }
          return item;
        }).toList();
      });

      // 2️⃣ Handle UI visibility based on quantity
      if (newQuantity <= 0) {
        ref.read(showAddToCartProvider.notifier).state = false;
        print("🔄 Quantity is zero — showing Cancel + Service Cost buttons");
      } else {
        ref.read(showAddToCartProvider.notifier).state = true;
        print("🟢 Quantity > 0 — showing Add to Cart button");
      }

      // 3️⃣ Call API
      final response = await ApiService.postRequest(cartUpdateQuantity, {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "service": cartId,
        "quantity": newQuantity,
        "material": false,
      });

      print("🌐 API Response: ${response.data}");

      // 4️⃣ If API fails, rollback
      if (response.data['status'] != true) {
        print("❌ API failed while updating quantity");

        // Optional: refresh service details
        await ServiceDetailsAPi(ref);

        // Rollback local quantity
        ref.read(serviceDetailsProvider.notifier).update((state) {
          if (state == null) return state;
          final currentData = state.data;
          if (currentData == null) return state;

          final updatedData = currentData.copyWith(
            inCartQuantity: (currentData.inCartQuantity ?? 0),
          );

          return state.copyWith(data: updatedData);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update quantity")),
        );
      } else {
        print("✅ Quantity updated successfully on server");

        // ✅ Update serviceDetails quantity locally too
        ref.read(serviceDetailsProvider.notifier).update((state) {
          if (state == null) return state;
          final currentData = state.data;
          if (currentData == null) return state;

          final updatedData = currentData.copyWith(inCartQuantity: newQuantity);
          return state.copyWith(data: updatedData);
        });
      }
    } catch (e, stack) {
      print("🚨 Error updating quantity: $e");
      print("📜 Stack trace: $stack");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  static Widget _langButton({required bool selected, required String text}) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? const Color(0xff004271) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xff004271), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xff004271),
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  static Widget _timelineStep({
    required int stepNum,
    required bool isImageLeft,
    required String imagePath, // network URL expected
    required String title,
    required description,
    bool isLast = false,
  }) {
    final img = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.only(
          right: 35.5,
          left: 35.5,
          top: 4,
          bottom: 4,
        ),
        child: Image.network(
          imagePath,
          height: 120,
          width: 130,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // fallback in case image fails to load
            return Container(
              height: 120,
              width: 130,
              color: Colors.grey[200],
              child: Image.asset(
                "assets/images/logo.png",
                height: 50,
                color: Colors.grey,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: 120,
              width: 130,
              child: Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              ),
            );
          },
        ),
      ),
    );

    final circle = Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xff004271),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$stepNum',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        if (!isLast) Container(width: 3, height: 90, color: Colors.grey[300]),
      ],
    );

    final txt = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isImageLeft ? [img, circle, txt] : [txt, circle, img],
      ),
    );
  }

  static Widget neededCard({required Widget icon, required String text}) {
    return Container(
      width: 110,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.only(top: 14), child: icon),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _includedText(text) => Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text('• $text', style: const TextStyle(fontSize: 15.5)),
  );
}
