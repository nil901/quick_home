import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/subscription_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';

class MySubscriptionScreen extends ConsumerStatefulWidget {
  const MySubscriptionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MySubscriptionScreen> createState() =>
      _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends ConsumerState<MySubscriptionScreen> {
  bool isLoading = false;

  Future<void> subscriptionApi(WidgetRef ref) async {
    try {
      setState(() => isLoading = true);
      final response = await ApiService.postRequest(getSubscription, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['status'] == true) {
        final data = response.data as Map<String, dynamic>;
        ref
            .read(subscriptionResponseProvider.notifier)
            .state = SubscriptionResponseModel.fromJson(data);
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching subscription: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => subscriptionApi(ref));
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionData = ref.watch(subscriptionResponseProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff6fbff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff6fbff),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Subscription",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xff002b4e),
          ),
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : subscriptionData?.data?.subscriptions.isEmpty ?? true
              ? const Center(
                child: Text(
                  "No active subscriptions found",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
              : RefreshIndicator(
                onRefresh: () => subscriptionApi(ref),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Active Plan Section
                      const Text(
                        "Active Plans",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xff004271),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            subscriptionData?.data?.subscriptions.length ?? 0,
                        itemBuilder: (context, index) {
                          final subscription =
                              subscriptionData!.data!.subscriptions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${subscription.status ?? 'Active'} Plan",
                                        style: const TextStyle(
                                          color: Color(0xff004271),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff004271),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Text(
                                          "Manage",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                    "Service",
                                    subscription.service?.name,
                                  ),
                                  _buildInfoRow(
                                    "Billing Cycle",
                                    subscription.billingCycle,
                                  ),
                                  _buildInfoRow(
                                    "Valid until",
                                    formatDate(
                                      subscription.nextBillingDate ?? "",
                                    ),
                                  ),
                                  _buildInfoRow(
                                    "Total Amount",
                                    "AED ${subscription.totalAmount}",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 25),
                      const Text(
                        "Explore Other Plans",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff004271),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 🔹 Horizontal Scroll Cards
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: subscriptionData?.data?.exploreOtherPlans.length,
                          itemBuilder: (context, index) {
                            final plan = subscriptionData?.data?.exploreOtherPlans[index];
                            return _buildPlanCard(
                              title: plan?.service?.name ?? "Unknown",
                              price: plan?.pricePerTime ?? "Unknown",
                              subtitle: "Auto renew",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String subtitle,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12.5, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xffe5f8ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: const Text(
              "Know More",
              style: TextStyle(
                color: Color(0xff003366),
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Date formatter
String formatDate(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM yyyy').format(dateTime.toLocal());
  } catch (e) {
    return "Invalid date";
  }
}
