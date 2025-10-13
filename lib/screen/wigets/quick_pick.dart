// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quick_home/api_services/Providers.dart';
// import 'package:quick_home/screen/dashboard/qwik_picks.dart';

// class QwikPicksWidget extends ConsumerWidget {
//   final bool single;

//   QwikPicksWidget(this.single);

//   @override
//   Widget build(BuildContext context, ref) {
//     final offer = ref.watch(offerProvider);
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
//               MaterialPageRoute(builder: (context) => QwikPicksScreen()),
//             );
//             print("Button pressed");
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Qwick Picks",
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
//           height: single ? 158 : 160, // Adjust height if single item
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: offer.length,
//             itemBuilder: (context, index) {
//               double width = single ? 301 : 120;
//               double height = single ? 150 : 120;
//               final offers = offer[index];
//               return Container(
//                 margin: const EdgeInsets.only(left: 12),
//                 width: width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.network(
//                         offers.imageUrl.toString(),
//                         width: width,
//                         height: height,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     // if (labels != null && labels!.length > index)
//                     Text(
//                       offers.name,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
