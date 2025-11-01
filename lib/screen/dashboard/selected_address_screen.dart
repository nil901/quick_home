// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:quick_home/api_services/Providers.dart';
// import 'package:quick_home/color/colors.dart';
// import 'package:quick_home/model/address_model.dart';
// import 'package:quick_home/provide/cart_prov.dart';
// import 'package:quick_home/screen/dashboard/address_screen.dart';
// import 'package:quick_home/screen/dashboard/payment_screen.dart';
// import 'package:quick_home/util/custom_app_bar.dart';
// class SelectedMyAddress extends ConsumerStatefulWidget {
//   const SelectedMyAddress({super.key});

//   @override
//   ConsumerState<SelectedMyAddress> createState() => _SelectedMyAddressState();
// }

// class _SelectedMyAddressState extends ConsumerState<SelectedMyAddress> {
//   int? selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() => cartServices().addressApi(ref)); // Fetch address list
//   }

//   @override
//   Widget build(BuildContext context) {
//     final addressList = ref.watch(addressProvider);

//     // Initial default selection
//     if (selectedIndex == null) {
//       final defaultIndex =
//           addressList.indexWhere((addr) => addr.isDefault == true);
//       if (defaultIndex != -1) selectedIndex = defaultIndex;
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(title: 'My Address'),
//       body: addressList.isEmpty
//           ? const Center(child: Text("No address found. Please add a new one."))
//           : Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Select Delivery Address",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "YOUR ADDRESSES",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: addressList.length,
//                       itemBuilder: (context, index) {
//                         final addr = addressList[index];
//                         final isSelected = selectedIndex == index;

//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedIndex = index;
//                             });
//                           },
//                           child: _addressCard(
//                             addr,
//                             isSelected: isSelected,
//                             showButtons: addr.isDefault || isSelected,
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 12),
//                   OutlinedButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AddressScreen(),
//                         ),
//                       );
//                     },
//                     icon: const Icon(Icons.add, color: Color(0xFF004271)),
//                     label: const Text(
//                       'Add New Address',
//                       style: TextStyle(color: Color(0xFF004271)),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Color(0xFF004271)),
//                     ),
//                   ),

//                   SafeArea(
//                     child: Center(
//                       child: Container(
//                         width: 350,
//                         height: 44,
//                         margin: const EdgeInsets.symmetric(vertical: 12),
//                         child: ElevatedButton(
//                           onPressed: () => _showSlotSelector(context),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: kprimary,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: const Text(
//                             "Save and proceed to slots",
//                             style: TextStyle(fontSize: 14, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _addressCard(Address addr,
//       {bool isSelected = false, bool showButtons = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(13),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Radio(
//   value: true,
//   groupValue: isSelected,
//   onChanged: (_) {
//     setState(() {
//       // ref.read(addressProvider) वापरून list मिळवा
//       final addresses = ref.read(addressProvider);
//       selectedIndex = addresses.indexOf(addr);
//     });
//   },
//   activeColor: const Color(0xFF004271),
// ),

//           const SizedBox(width: 5),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   addr.user!.name.toString(),
//                   style:
//                       const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   addr.addressDetails!,
//                   style: const TextStyle(color: Colors.black87, fontSize: 13),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   'Mobile: ${addr.user?.phone}',
//                   style:
//                       const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                 ),
//                 if (showButtons)
//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: () {
//                           // Remove logic
//                         },
//                         child:
//                             const Text('REMOVE', style: TextStyle(fontSize: 12)),
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: Colors.grey),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 0,
//                           ),
//                           minimumSize: const Size(10, 32),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       OutlinedButton(
//                         onPressed: () {
//                           // Edit logic
//                         },
//                         child: const Text('EDIT', style: TextStyle(fontSize: 12)),
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: Colors.grey),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 0,
//                           ),
//                           minimumSize: const Size(10, 32),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   void _showSlotSelector(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: kscoundPrimaryColor,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       isScrollControlled: true,
//       builder: (context) {
//         int selectedTime = 1;
//         int selectedDate = 0;
//         int selectedExpert = -1;

//         List<String> times = [
//           "03:30 PM",
//           "04:30 PM",
//           "05:00 PM",
//           "05:30 PM",
//           "06:30 PM",
//           "07:00 PM",
//         ];

//         List<String> dates = [
//           "Mon, 22",
//           "Tue, 23",
//           "Wed, 24",
//           "Thu, 25",
//           "Fri, 26",
//           "Sat, 27",
//           "Sun, 28",
//         ];

//         List<Map<String, String?>> experts = [
//           {"name": "Best Match for\nYour Service", "image": null},
//           {"name": "Megha", "image": "assets/images/Megha.png"},
//         ];

//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 left: 16,
//                 right: 16,
//                 top: 3,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 12),
//                     child: Row(
//                       children: [
//                         SizedBox(height: 12),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Your Qwik Slot - Choose Date & Time",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: Color(0xFF353535),
//                             ),
//                           ),
//                         ),

//                         SizedBox(width: 90),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             GestureDetector(
//                               onTap: () => Navigator.pop(context),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 5.0),
//                                 child: Icon(Icons.close),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Dates
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Container(
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           // --- Static "Oct" box first ---
//                           Container(
//                             width: 60,
//                             height: 70,
//                             margin: EdgeInsets.only(right: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.transparent,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 17.0),
//                                     child: Text(
//                                       "Oct",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 // Empty space for alignment (since 'Oct' has no date number)
//                                 Text(
//                                   "",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey.shade800,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // --- Rest of the dates as before ---
//                           ...List.generate(dates.length, (i) {
//                             List<String> parts = dates[i].split(',');
//                             String label1 = parts[0].trim();
//                             String label2 =
//                                 parts.length > 1 ? parts[1].trim() : "";
//                             bool isSelected = (selectedDate == i);
//                             return GestureDetector(
//                               onTap: () => setState(() => selectedDate = i),
//                               child: Container(
//                                 width: 60,
//                                 height: 70,
//                                 margin: EdgeInsets.only(right: 8),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       isSelected
//                                           ? Color(0xFF004271)
//                                           : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       label1,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color:
//                                             isSelected
//                                                 ? Colors.white
//                                                 : Colors.grey.shade600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       label2,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             isSelected
//                                                 ? Colors.white
//                                                 : Colors.grey.shade800,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: 24),

//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Selected Time",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                         color: Color(0xFF353535),
//                       ),
//                     ),
//                   ),

//                   // Times
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: List.generate(times.length, (i) {
//                       bool isSelected = selectedTime == i;
//                       return ChoiceChip(
//                         label: Text(times[i]),
//                         selected: isSelected,
//                         onSelected: (val) => setState(() => selectedTime = i),
//                         selectedColor: kprimary,
//                         backgroundColor: kscoundPrimaryColor,
//                         labelStyle: TextStyle(
//                           color: isSelected ? Colors.white : kblack,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           side: BorderSide(color: kprimary, width: 1),
//                         ),
//                       );
//                     }),
//                   ),

//                   SizedBox(height: 32),

//                   Padding(
//                     padding: const EdgeInsets.only(left: 9.0, bottom: 13.0),
//                     child: Text(
//                       'Choose your Expert',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                         color: Color(0xFF353535),
//                       ),
//                     ),
//                   ),

//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: List.generate(experts.length, (index) {
//                         final expert = experts[index];
//                         return Padding(
//                           padding: EdgeInsets.only(
//                             right: 10,
//                           ), // 🔹 CHANGED: small gap
//                           child: ExpertCard(
//                             name: expert['name']!,
//                             imagePath: expert['image'],
//                             isSelected: selectedExpert == index,
//                             onTap: () => setState(() => selectedExpert = index),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),

//                   SizedBox(height: 20),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>  PaymentScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: kprimary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         "Proceed to Payment",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

// class ExpertCard extends StatelessWidget {
//   final String name;
//   final String? imagePath;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const ExpertCard({
//     super.key,
//     required this.name,
//     this.imagePath,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             height: 70,
//             width: 70,
//             decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(
//                 color: isSelected ? Colors.blue.shade900 : Colors.white,
//                 width: 2,
//               ),
//               boxShadow: isSelected ? [] : [],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child:
//                   imagePath != null && imagePath!.isNotEmpty
//                       ? Image.asset(imagePath!, fit: BoxFit.cover)
//                       : Icon(
//                         Icons.person,
//                         size: 45,
//                         color: Colors.grey.shade500,
//                       ),
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             name,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Color(0xFF353535),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/payment_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import '../../api_services/api_services.dart';
import '../../prefs/app_preference.dart';
import '../../prefs/preferences_keys.dart';
import '../../provide/add_address.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/payment_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import '../../api_services/api_services.dart';
import '../../prefs/app_preference.dart';
import '../../prefs/preferences_keys.dart';

class SelectedMyAddress extends ConsumerStatefulWidget {
  const SelectedMyAddress({super.key});

  @override
  ConsumerState<SelectedMyAddress> createState() => _SelectedMyAddressState();
}

class _SelectedMyAddressState extends ConsumerState<SelectedMyAddress> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => cartServices().addressApi(ref));
    Future.microtask(() => cartServices().bookingOptionsApi(ref));
  }

  @override
  Widget build(BuildContext context) {
    final addressList = ref.watch(addressProvider);

    // Select default address initially
    if (selectedIndex == null && addressList.isNotEmpty) {
      final defaultIndex = addressList.indexWhere((a) => a.isDefault == true);
      if (defaultIndex != -1) selectedIndex = defaultIndex;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'My Address'),
      body: RefreshIndicator(
        color: const Color(0xFF004271),
        onRefresh: () async {
          await cartServices().addressApi(ref);
        },
        child:
            addressList.isEmpty
                ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddressScreen(),
                            ),
                          );
                          if (result == true) {
                            await cartServices().addressApi(ref);
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add New Address',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004271),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "No address found. Please add a new one.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                )
                : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                "Select Delivery Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Default Address Section
                              const Text(
                                "DEFAULT ADDRESS",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),

                              if (addressList.any((a) => a.isDefault == true))
                                _addressCard(
                                  addressList.firstWhere(
                                    (a) => a.isDefault == true,
                                  ),
                                  isSelected:
                                      selectedIndex ==
                                      addressList.indexWhere(
                                        (a) => a.isDefault == true,
                                      ),
                                  onSelect: (index) {
                                    setState(() => selectedIndex = index);
                                  },
                                  index: addressList.indexWhere(
                                    (a) => a.isDefault == true,
                                  ),
                                )
                              else
                                const Text(
                                  "No default address found.",
                                  style: TextStyle(color: Colors.grey),
                                ),

                              const SizedBox(height: 20),

                              // Other Address Section
                              const Text(
                                "OTHER ADDRESS",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Column(
                                children: List.generate(addressList.length, (
                                  index,
                                ) {
                                  final addr = addressList[index];
                                  if (addr.isDefault == true)
                                    return const SizedBox();
                                  return _addressCard(
                                    addr,
                                    isSelected: selectedIndex == index,
                                    onSelect:
                                        (i) =>
                                            setState(() => selectedIndex = i),
                                    index: index,
                                  );
                                }),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: 180,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddressScreen(),
                              ),
                            );

                            if (result == true) {
                              await cartServices().addressApi(ref);
                            }
                          },
                          icon: const Icon(Icons.add, color: Color(0xFF004271)),
                          label: const Text(
                            'Add New Address',
                            style: TextStyle(color: Color(0xFF004271)),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF004271)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SafeArea(
                      child: Center(
                        child: Container(
                          width: 350,
                          height: 44,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: ElevatedButton(
                            onPressed: () {
                              _showSlotSelector(context, ref);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kprimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Save and proceed to slots",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _addressCard(
    Address addr, {
    required int index,
    bool isSelected = false,
    required Function(int) onSelect,
  }) {
    final pref = AppPreference();
    final fallbackName = pref.getString(PreferencesKey.name);
    final fallbackPhone = pref.getString(PreferencesKey.phone);

    String? displayName;
    String? displayPhone;

    if (addr.contactDetails != null && addr.contactDetails!.isNotEmpty) {
      final parts = addr.contactDetails!.split(',');
      displayName = parts.isNotEmpty ? parts[0].trim() : null;
      displayPhone = parts.length > 1 ? parts[1].trim() : null;
    }

    displayName ??= addr.user?.name ?? fallbackName ?? '';
    displayPhone ??= addr.user?.phone ?? fallbackPhone ?? '';

    return GestureDetector(
      onTap: () async {
        try {
          final res = await ApiService.postRequest('addressesToDefault', {
            'user': addr.userId,
            'address': addr.id,
          });

          if (res.statusCode == 200) {
            await cartServices().addressApi(ref);
            setState(() {
              selectedIndex = ref
                  .read(addressProvider)
                  .indexWhere((a) => a.id == addr.id);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Default address updated")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF004271) : Colors.grey.shade300,
            width: isSelected ? 1.3 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]
                  : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio(
              value: index,
              groupValue: selectedIndex,
              onChanged: (_) async {
                try {
                  final res = await ApiService.postRequest(
                    'addressesToDefault',
                    {'user': addr.userId, 'address': addr.id},
                  );

                  if (res.statusCode == 200) {
                    await cartServices().addressApi(ref);
                    setState(() {
                      selectedIndex = ref
                          .read(addressProvider)
                          .indexWhere((a) => a.id == addr.id);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Default address updated")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              activeColor: const Color(0xFF004271),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    addr.addressDetails ?? '',
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Mobile: $displayPhone',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  if (isSelected && addr.isDefault == true)
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            final deleteService = ref.read(
                              addressDeleteProvider,
                            );
                            final success = await deleteService.deleteAddress(
                              userId: addr.userId,
                              addressId: addr.id,
                            );

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Address removed successfully"),
                                ),
                              );

                              // Refresh address list
                              await cartServices().addressApi(ref);

                              final updatedList = ref.read(addressProvider);

                              // Agar koi default address nahi hai, first other address ko default banaye
                              if (!updatedList.any((a) => a.isDefault) &&
                                  updatedList.isNotEmpty) {
                                final firstOther = updatedList.first;
                                try {
                                  final res = await ApiService.postRequest(
                                    'addressesToDefault',
                                    {
                                      'user': firstOther.userId,
                                      'address': firstOther.id,
                                    },
                                  );

                                  if (res.statusCode == 200) {
                                    await cartServices().addressApi(ref);

                                    setState(() {
                                      selectedIndex = ref
                                          .read(addressProvider)
                                          .indexWhere(
                                            (a) => a.id == firstOther.id,
                                          );
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "New default address set",
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              } else {
                                setState(() {
                                  selectedIndex = null;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to remove address"),
                                ),
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                            minimumSize: const Size(10, 32),
                          ),
                          child: const Text(
                            'REMOVE',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AddressScreen(address: addr),
                              ),
                            );

                            if (result == true) {
                              await cartServices().addressApi(ref);

                              final updatedList = ref.read(addressProvider);
                              final defaultIndex = updatedList.indexWhere(
                                (a) => a.isDefault == true,
                              );
                              setState(() {
                                selectedIndex =
                                    defaultIndex != -1 ? defaultIndex : null;
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                            minimumSize: const Size(10, 32),
                          ),
                          child: const Text(
                            'EDIT',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSlotSelector(BuildContext context, ref, {Address? address}) {
  showModalBottomSheet(
    backgroundColor: kscoundPrimaryColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      int selectedTime = 0;
      int selectedDate = 0;
      int selectedExpert = -1;

      return StatefulBuilder(
        builder: (context, setState) {
          return SlotSelectorScreen(address: address);
        },
      );
    },
  );
}

class SlotSelectorScreen extends ConsumerStatefulWidget {
  final Address? address;

  const SlotSelectorScreen({super.key, this.address});

  @override
  ConsumerState<SlotSelectorScreen> createState() => _SlotSelectorScreenState();
}

class _SlotSelectorScreenState extends ConsumerState<SlotSelectorScreen> {
  int selectedTime = -1;
  int selectedDate = -1;
  int selectedExpert = -1;
  @override
  void initState() {
    super.initState();

    Future.microtask(() => cartServices().bookingOptionsApi(ref));
    Future.delayed(Duration(milliseconds: 500), () {
      final bookingDates = ref.read(bookingDateProvider);
      if (bookingDates.isNotEmpty) {
        DateTime today = DateTime.now();
        int todayIndex = bookingDates.indexWhere((d) {
          try {
            final date = DateFormat("MMM dd, yyyy").parse(d.formatted);
            return date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;
          } catch (_) {
            return false;
          }
        });

        if (todayIndex != -1) {
          setState(() {
            selectedDate = todayIndex;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(serviceProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const SizedBox(height: 32),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel, color: kprimary, size: 30),
            ),
          ),

          SizedBox(height: 10),
          // --- Dates ---
          Consumer(
            builder: (context, ref, _) {
              final bookingDates = ref.watch(bookingDateProvider);

              String getMonthName(String formattedDate) =>
                  formattedDate.isEmpty ? '' : formattedDate.split(' ').first;

              String getDayShort(String fullDay) =>
                  fullDay.isEmpty ? '' : fullDay.substring(0, 3);

              int getDayNumberFromFormatted(String formattedDate) {
                try {
                  DateTime date = DateFormat(
                    "MMM dd, yyyy",
                  ).parse(formattedDate);
                  return date.day;
                } catch (_) {
                  return 0;
                }
              }

              if (bookingDates.isEmpty) return const SizedBox();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Month display
                    Container(
                      width: 60,
                      height: 70,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getMonthName(bookingDates[0].formatted),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dates list
                    ...List.generate(bookingDates.length, (i) {
                      final date = bookingDates[i];
                      bool isSelected = selectedDate == i;

                      return GestureDetector(
                        onTap: () => setState(() => selectedDate = i),
                        child: Container(
                          width: 60,
                          height: 70,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFF004271)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Colors.transparent
                                      : Colors.grey.shade400,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getDayShort(date.day),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getDayNumberFromFormatted(
                                  date.formatted,
                                ).toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 15),

          const Text(
            "Choose your Expert",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF353535),
            ),
          ),
          const SizedBox(height: 8),

          // --- Experts ---
          Consumer(
            builder: (context, ref, _) {
              final service = ref.watch(serviceProvider);
              print("dddddddddddddddddddddddddddddddddddddddddd");
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(service.length, (index) {
                    final expert = service[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ExpertCard(
                        name: expert.name,
                        imagePath: expert.image,
                        isSelected: selectedExpert == index,
                        onTap: () async {
                          setState(() => selectedExpert = index);

                          try {
                            final response = await ApiService.postRequest(
                              providerAvailableDates,
                              {"serviceProvider": service[index].id},
                            );

                            if (response.data['success'] == true) {
                              Future.microtask(
                                () => cartServices().bookingOptionsApi(
                                  ref,
                                  serviceProviders: expert.id,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to fetch slots"),
                                ),
                              );
                            }
                          } catch (e) {
                            print("Error updating quantity: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Something went wrong"),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          const SizedBox(height: 24),
          const Text(
            "Available Time Slots",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF353535),
            ),
          ),
          const SizedBox(height: 8),

          // --- Times ---
          Consumer(
            builder: (context, ref, _) {
              final times = ref.watch(bookingTimeProvider);

              // जर काही slots नाहीत
              if (times.isEmpty) {
                return const Center(
                  child: Text(
                    "No available slots",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              }

              // फक्त available slots filter करा
              final availableTimes =
                  times.where((t) => t.available == true).toList();

              if (availableTimes.isEmpty) {
                return const Center(
                  child: Text(
                    "No available slots for this date",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              }

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(availableTimes.length, (i) {
                  final slot = availableTimes[i];
                  bool isSelected = selectedTime == i;

                  return ChoiceChip(
                    label: Text(slot.formatted),
                    selected: isSelected,
                    onSelected: (val) => setState(() => selectedTime = i),
                    selectedColor: kprimary,
                    backgroundColor: kscoundPrimaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : kblack,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: kprimary, width: 1),
                    ),
                  );
                }),
              );
            },
          ),

          const SizedBox(height: 20),

          // --- Proceed Button ---
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final times = ref.read(bookingTimeProvider);
                final experts = ref.read(serviceProvider);

                final availableTimes =
                    times.where((t) => t.available == true).toList();

                if (selectedTime < 0 || selectedTime >= availableTimes.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a time")),
                  );
                  return;
                }

                if (selectedExpert < 0 || selectedExpert >= experts.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please choose an expert")),
                  );
                  return;
                }

                final selectedTimeValue =
                    availableTimes[selectedTime].formatted;
                final selectedExpertValue = experts[selectedExpert].name;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PaymentScreen(
                          selectedDate: "Selected Date",
                          selectedTime: selectedTimeValue,
                          selectedExpert: selectedExpertValue,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Proceed to Payment",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ExpertCard extends StatelessWidget {
  final String name;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ExpertCard({
    super.key,
    required this.name,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? Colors.blue.shade900 : Colors.white,
                width: 2,
              ),
              boxShadow: isSelected ? [] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  imagePath != null && imagePath!.isNotEmpty
                      ? Image.network(imagePath!, fit: BoxFit.cover)
                      : Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey.shade500,
                      ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF353535),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
