import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';

final cleanerCountProvider = StateProvider<int?>((ref) => null);

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
                      if (selectedCount == number) {
                        // If already selected → unselect
                        ref.read(cleanerCountProvider.notifier).state = null;
                      } else {
                        // Else select this number
                        ref.read(cleanerCountProvider.notifier).state = number;
                      }
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: HexColor("#E4F9FF"),
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
