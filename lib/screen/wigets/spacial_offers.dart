// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quick_home/api_services/Providers.dart';
// import 'package:quick_home/screen/dashboard/qwik_picks.dart';
// import 'package:quick_home/model/home_model.dart';
// import 'package:quick_home/screen/dashboard/services_details_screen.dart';

// class SpcialOffersWidget extends ConsumerWidget {
//   final bool single;

//   SpcialOffersWidget(this.single);

//   @override
//   Widget build(BuildContext context, ref) {
//     final offer = ref.watch(offerProvider);

//     if (offer.isEmpty) {
//       return const SizedBox.shrink(); // Don't show anything if no offers
//     }

//     // Flatten all items from all sections into a single list
//     final HomeModel homeModel = offer.first;
//     final List<Item> allItems =
//         homeModel.sections.expand((section) => section.items.items).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             padding: EdgeInsets.zero,
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => QwikPicksScreen(item: homeModel),
//               ),
//             );
//             print("Button pressed");
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Special Offers &  Compaings",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text("See all", style: TextStyle(color: Colors.blue)),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: single ? 180 : 170, // Adjust height if single item
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: allItems.length,
//             itemBuilder: (context, index) {
//               double width = single ? 301 : 120;
//               double height = single ? 150 : 120;
//               final item = allItems[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) =>
//                               ServicesDetailsScreen(serviceId: item.id),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 12),
//                   width: width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.network(
//                           item.imageUrl,
//                           width: width,
//                           height: height,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         item.name,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
