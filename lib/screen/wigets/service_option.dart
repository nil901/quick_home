import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/service_details_model.dart';

/// 🔹 Riverpod Providers
final selectedPlanProvider = StateProvider<SubscriptionPlan?>((ref) => null);
final showAddToCartProvider = StateProvider<bool>((ref) => false);

class ServiceOptions extends ConsumerStatefulWidget {
  final List<SubscriptionPlan> plans;
  final VoidCallback? onPlanSelected;

  const ServiceOptions({super.key, required this.plans, this.onPlanSelected});

  @override
  ConsumerState<ServiceOptions> createState() => _ServiceOptionsState();
}

class _ServiceOptionsState extends ConsumerState<ServiceOptions> {
  int? expandedIndex;
  int? selectedIndex;
  bool hasRemoved = false; // ✅ Added: prevent multiple removals

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Pick a Plan That Fits You',
        'content': buildPlansList(widget.plans),
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: List.generate(sections.length, (index) {
          final section = sections[index];
          final isExpanded = expandedIndex == index;

          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                section['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              iconColor: Colors.black,
              collapsedIconColor: Colors.black54,
              initiallyExpanded: isExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  expandedIndex = expanded ? index : null;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: section['content'] as Widget,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// 🔹 Horizontal plans list with Riverpod + Unselect feature
  Widget buildPlansList(List<SubscriptionPlan> plans) {
    if (plans.isEmpty) return const Text("No plans available.");

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () async {
              final currentSelected = selectedIndex;

              setState(() {
                // 👇 Unselect if same plan tapped again
                if (currentSelected == index) {
                  selectedIndex = null;
                  ref.read(selectedPlanProvider.notifier).state = null;
                } else {
                  selectedIndex = index;
                  ref.read(selectedPlanProvider.notifier).state = plan;
                }
              });

              // Hide Add to Cart button when changing selection
              ref.read(showAddToCartProvider.notifier).state = false;

              // ✅ Only trigger callback once
              if (!hasRemoved && widget.onPlanSelected != null) {
                widget.onPlanSelected!();
                hasRemoved = true;
              }

              print("Selected plan price: ${plan.pricePerTime}");
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: kscoundPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? kprimary : kscoundPrimaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔸 Top: description + price
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            plan.description ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: kprimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "AED ${plan.pricePerTime ?? ''}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? kprimary : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Bottom: plan frequency
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? kscoundPrimaryColor
                              : Colors.blue.shade50,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      plan.frequencyType ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? kprimary : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}