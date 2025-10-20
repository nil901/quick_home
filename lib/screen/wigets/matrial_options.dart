import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/service_details_model.dart';
final selectedMaterialProvider = StateProvider<MaterialItem?>((ref) => null);
final cardClickStateProvider = StateProvider<bool>((ref) => false);

class MatrialOptions extends ConsumerStatefulWidget {
  final List<MaterialItem> matrial;

  const MatrialOptions({super.key, required this.matrial});

  @override
  ConsumerState<MatrialOptions> createState() => _MatrialOptionsState();
}

class _MatrialOptionsState extends ConsumerState<MatrialOptions> {
  int? selectedIndex;
  int clickCount = 0; // track number of clicks

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.matrial.length,
        itemBuilder: (context, index) {
          final item = widget.matrial[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;

                clickCount++;
                if (index == 0) {
                  ref.read(cardClickStateProvider.notifier).state = true; // 1 card click
                } else if (index == 1) {
                  ref.read(cardClickStateProvider.notifier).state = false; // 2 card click
                  clickCount = 0; // reset after second click
                }
              });

              ref.read(selectedMaterialProvider.notifier).state = item;
              print("Selected Price: ${item.materialPrice}");
              print("Card Click Bool: ${ref.read(cardClickStateProvider)}");
            },
            child: Container(
              width: 170,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE4F9FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? kprimary : const Color(0xFFE4F9FF),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.materialName ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? kprimary : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "AED ${item.materialPrice}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? kprimary : Colors.black,
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
