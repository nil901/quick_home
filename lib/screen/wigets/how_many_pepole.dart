import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';

final cleanerCountProvider = StateProvider<int?>((ref) => null);
final showAddToCartProvider = StateProvider<bool>((ref) => false);

class CleanerCountSelector extends ConsumerStatefulWidget {
  const CleanerCountSelector({super.key});

  @override
  ConsumerState<CleanerCountSelector> createState() =>
      _CleanerCountSelectorState();
}

class _CleanerCountSelectorState extends ConsumerState<CleanerCountSelector> {
  @override
  Widget build(BuildContext context) {
    final selectedCount = ref.watch(cleanerCountProvider);
    final List<int> counts = List.generate(10, (index) => index + 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            "How many cleaners do you need?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          iconColor: Colors.black,
          collapsedIconColor: Colors.black54,
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: counts.length,
                itemBuilder: (context, index) {
                  final number = counts[index];
                  final isSelected = selectedCount == number;

                  return GestureDetector(
                    onTap: () {
                      // ✅ Toggle logic — same number dubara tap karne pe unselect
                      if (isSelected) {
                        ref.read(cleanerCountProvider.notifier).state = null;
                        ref.read(showAddToCartProvider.notifier).state = false;
                      } else {
                        ref.read(cleanerCountProvider.notifier).state = number;
                        ref.read(showAddToCartProvider.notifier).state = true;
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? kprimary.withOpacity(0.1)
                                : HexColor("#E4F9FF"),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? kprimary : HexColor("#E4F9FF"),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? kprimary : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
