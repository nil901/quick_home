// import 'package:flutter/material.dart';
// import 'package:quick_home/color/colors.dart';
// import 'package:quick_home/screen/dashboard/cart_screen.dart';
// import 'package:quick_home/screen/notifaction_screen.dart';

// class CommanAppBar extends StatelessWidget {
//   const CommanAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       color: kscoundPrimaryColor,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(Icons.location_on, color: Colors.black, size: 30),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Patil Classics",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "Tidake colony, Durwankur Lawns, Nashik ....",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade700,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const Icon(
//                             Icons.keyboard_arrow_down,
//                             size: 16,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NotificationScreen(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.notifications_none,
//                   color: Colors.black,
//                   size: 24,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CartScreen()),
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.shopping_cart_outlined,
//                   color: Colors.black,
//                   size: 24,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import '../api_services/Providers.dart';
import '../color/colors.dart';
import '../provide/cart_prov.dart';
import '../screen/dashboard/cart_screen.dart';
import '../screen/dashboard/selected_address_screen.dart';
import '../screen/notifaction_screen.dart';

class CommanAppBar extends ConsumerStatefulWidget {
  const CommanAppBar({super.key});

  @override
  ConsumerState<CommanAppBar> createState() => _CommanAppBarState();
}

class _CommanAppBarState extends ConsumerState<CommanAppBar> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => cartServices().addressApi(ref));
  }

  @override
  Widget build(BuildContext context) {
    final addressList = ref.watch(addressProvider);

    // ✅ Handle empty or missing address safely
    final defaultAddress =
        addressList.isNotEmpty
            ? addressList.firstWhere(
              (addr) => addr.isDefault,
              orElse: () => addressList.first,
            )
            : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: kscoundPrimaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectedMyAddress(),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: HexColor('#004271'), size: 30),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Show name or loading text
                        Text(
                          defaultAddress?.user?.name ?? "Loading address...",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                defaultAddress?.addressDetails ??
                                    "Select your address...",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: Colors.black,
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
