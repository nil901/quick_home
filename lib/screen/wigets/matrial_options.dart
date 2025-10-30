import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/service_details_model.dart';

final selectedMaterialProvider = StateProvider<String?>((ref) => null);
final cardClickStateProvider = StateProvider<bool>((ref) => false);

class MaterialOptions extends ConsumerStatefulWidget {
  final Service material;

  const MaterialOptions({super.key, required this.material});

  @override
  ConsumerState<MaterialOptions> createState() => _MaterialOptionsState();
}

class _MaterialOptionsState extends ConsumerState<MaterialOptions> {
  int? selectedIndex; // 0 = Without Material, 1 = With Material

  @override
  Widget build(BuildContext context) {
    final selectedMaterial = ref.watch(selectedMaterialProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            "Do you need cleaning materials?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          iconColor: Colors.black,
          collapsedIconColor: Colors.black54,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    ref.read(selectedMaterialProvider.notifier).state =
                        "With Material";
                    ref.read(cardClickStateProvider.notifier).state = true;
                    print("Selected: With Material");
                  },
                  child: Container(
                    width: 160,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F9FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            selectedIndex == 1
                                ? kprimary
                                : const Color(0xFFE4F9FF),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "With Material",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "+ AED ${widget.material.withMaterialPrice ?? 0}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == 1 ? kprimary : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 Without Material
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    ref.read(selectedMaterialProvider.notifier).state =
                        "Without Material";
                    ref.read(cardClickStateProvider.notifier).state = false;
                    print("Selected: Without Material");
                  },
                  child: Container(
                    width: 160,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F9FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            selectedIndex == 0
                                ? kprimary
                                : const Color(0xFFE4F9FF),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Without Material",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "AED ${widget.material.withoutMaterialPrice ?? 0}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == 0 ? kprimary : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 With Material
                //   GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         selectedIndex = 1;
                //       });
                //       ref.read(selectedMaterialProvider.notifier).state =
                //           "With Material";
                //       ref.read(cardClickStateProvider.notifier).state = true;
                //       print("Selected: With Material");
                //     },
                //     child: Container(
                //       width: 160,
                //       height: 70,
                //       margin: const EdgeInsets.symmetric(horizontal: 6),
                //       decoration: BoxDecoration(
                //         color: const Color(0xFFE4F9FF),
                //         borderRadius: BorderRadius.circular(20),
                //         border: Border.all(
                //           color:
                //               selectedIndex == 1
                //                   ? kprimary
                //                   : const Color(0xFFE4F9FF),
                //           width: 2,
                //         ),
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Text(
                //             "With Material",
                //             style: TextStyle(
                //               fontSize: 13,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.black87,
                //             ),
                //           ),
                //           const SizedBox(height: 6),
                //           Text(
                //             "+ AED ${widget.material.withMaterialPrice ?? 0}",
                //             style: TextStyle(
                //               fontSize: 13,
                //               fontWeight: FontWeight.bold,
                //               color: selectedIndex == 1 ? kprimary : Colors.black,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
