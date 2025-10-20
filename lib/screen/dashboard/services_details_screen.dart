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
import 'package:quick_home/screen/wigets/faq_comman.dart';
import 'package:quick_home/screen/wigets/how_many_pepole.dart';
import 'package:quick_home/screen/wigets/matrial_options.dart';
import 'package:quick_home/screen/wigets/service_option.dart';
import 'package:quick_home/util/ratting.dart';
import 'package:quick_home/util/size.dart';
import 'package:quick_home/util/toast_msg.dart';

class ServicesDetailsScreen extends ConsumerStatefulWidget {
  const ServicesDetailsScreen({super.key, required this.serviceId});
  final int serviceId;
  @override
  ConsumerState<ServicesDetailsScreen> createState() =>
      _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends ConsumerState<ServicesDetailsScreen> {
  bool isEnglish = true;

  @override
  void initState() {
    ServiceDetailsAPi(ref);
    super.initState();
  }

  bool _isLoading = false;
  Future<void> ServiceDetailsAPi(WidgetRef ref) async {
    try {
      final response = await ApiService.postRequest(viewService, {
        "service": widget.serviceId,
        "type": "",
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
  Widget build(BuildContext context) {
    final serviceDetails = ref.watch(serviceDetailsProvider);

    final service = serviceDetails?.data?.service;
    final selectedPlan = ref.watch(selectedPlanProvider);
    final selectedMaterial = ref.watch(selectedMaterialProvider);
    final selectedCount = ref.watch(cleanerCountProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4F9FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              isEnglish ? 'Ironing' : 'كي الملابس',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body:
          service == null
              ? const Center(
                child: CircularProgressIndicator(),
              ) // loader while null
              : Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Language Switch
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 18,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ServiceDetailsAPi(ref);
                                  setState(() => isEnglish = true);
                                },
                                child: _langButton(
                                  selected: isEnglish,
                                  text: 'In English',
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() => isEnglish = false);
                                },
                                child: _langButton(
                                  selected: !isEnglish,
                                  text: 'In Arabic',
                                ),
                              ),
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
                        // Title, Rating, Price, Book Now
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEnglish ? '${service?.name}' : 'كي الملابس',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                isEnglish
                                    ? '${service?.shortDescription}'
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffE4F9FF),
                                      foregroundColor: const Color(0xff004271),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      isEnglish ? 'Book Now' : 'احجز الآن',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Divider(thickness: 0.9),
                        // About the Service
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
                            style: const TextStyle(fontSize: 13.2, height: 1.5),
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
                            isEnglish ? 'Select requirements' : 'حدد المتطلبات',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),

                        ServiceOptions(plans: service.subscriptionPlans!),

                        const CleanerCountSelector(),

                        MatrialOptions(matrial: service.materials!),

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
                                  return _includedText(isEnglish ? text : text);
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

                        h50,
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Consumer(
                            builder: (context, ref, _) {
                              // final selectedPlan = ref.watch(
                              //   selectedPlanProvider,
                              // );
                              // final selectedMaterial = ref.watch(
                              //   selectedMaterialProvider,
                              // );
                              // final selectedCount =
                              //     ref.watch(cleanerCountProvider) ?? 0;

                              // double totalPrice = 0;

                              // // ✅ Add plan price if selected
                              // if (selectedPlan != null) {
                              //   totalPrice +=
                              //       double.tryParse(
                              //         selectedPlan.pricePerTime ?? '0',
                              //       ) ??
                              //       0;
                              // }

                              // // ✅ Add material price * count
                              // final materialPrice =
                              //     double.tryParse(
                              //       selectedMaterial?.materialPrice ?? '0',
                              //     ) ??
                              //     0;
                              // totalPrice += materialPrice * selectedCount;
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

                              // ✅ Always add plan price * count
                              if (selectedPlan != null) {
                                totalPrice +=
                                    (double.tryParse(
                                          selectedPlan.pricePerTime ?? '0',
                                        ) ??
                                        0) *
                                    selectedCount;
                              }

                              // ✅ Add material price * count only if material is selected
                              if (selectedMaterial != null) {
                                totalPrice +=
                                    (double.tryParse(
                                          selectedMaterial.materialPrice ?? '0',
                                        ) ??
                                        0) *
                                    selectedCount;
                              }

                              return ElevatedButton(
                                onPressed: () async {
                                  try {
                                    Dio dio = Dio();

                                    FormData formData = FormData.fromMap({
                                      "user": AppPreference().getInt(
                                        PreferencesKey.userId,
                                      ),
                                      "service": widget.serviceId,
                                      "package": selectedPlan?.id,
                                      "material": cardClickState ? 1 : 0,
                                      "providersCount": selectedCount,
                                    });
                                  formData.fields.forEach((field) {
  print("${field.key}: ${field.value}");
});
                                    final response = await dio.post(
                                      "http://admin.qwikhom.ae/api/addToCart",
                                      data: formData,
                                    );

                                    if (response.data['status'] == true) {
                                      print("Added to cart successfully");
                                      Utils().showTost(
                                        "Added to cart successfully",
                                      );
                                    } else {
                                      print(
                                        "Failed: ${response.data['message']}",
                                      );
                                      Utils().showTost(
                                        "Failed: ${response.data['message']}",
                                      );
                                    }
                                  } catch (e) {
                                    print("Error: $e");
                                  }
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
                                child: Text(
                                  'Service Cost AED ${totalPrice.toStringAsFixed(2)}',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
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
