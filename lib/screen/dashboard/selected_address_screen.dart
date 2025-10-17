import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/add_address_prod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/payment_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import '../../prefs/app_preference.dart';
import '../../prefs/preferences_keys.dart';

class SelectedMyAddress extends ConsumerStatefulWidget {
  const SelectedMyAddress({super.key});

  @override
  ConsumerState<SelectedMyAddress> createState() => _SelectedMyAddressState();
}

class _SelectedMyAddressState extends ConsumerState<SelectedMyAddress> {
  int? selectedAddressId;

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to call after the first frame is built.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _fetchAndSetInitialAddress(),
    );
  }

  // Helper to fetch data and set the initial selected address
  Future<void> _fetchAndSetInitialAddress() async {
    // Fetch addresses if the list is empty
    if (ref.read(addressProvider).isEmpty) {
      await cartServices().addressApi(ref);
    }
    // Ensure the widget is still in the tree
    if (mounted) {
      _initializeSelectedId();
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressList = ref.watch(addressProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'My Address'),
      body:
          addressList.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
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
                          addressList.firstWhere((a) => a.isDefault),
                          isSelected:
                              selectedAddressId ==
                              addressList.firstWhere((a) => a.isDefault).id,
                          onSelect: (id) {
                            setState(() => selectedAddressId = id);
                          },
                          id: addressList.firstWhere((a) => a.isDefault).id,
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
                        children: List.generate(addressList.length, (index) {
                          final addr = addressList[index];
                          if (addr.isDefault) return const SizedBox();
                          return _addressCard(
                            addr,
                            isSelected: selectedAddressId == addr.id,
                            onSelect: (id) {
                              // Call the function to handle default address change
                              _setDefaultAddress(id);
                            },
                            id: addr.id,
                          );
                        }),
                      ),

                      const SizedBox(height: 12),

                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push<bool>(
                            // Expect a boolean result
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddressScreen(),
                            ),
                          ).then((result) {
                            // If an address was added/edited (result is true), refetch the list.
                            if (result == true) {
                              _fetchAndSetInitialAddress();
                            }
                          });
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

                      SafeArea(
                        child: Center(
                          child: Container(
                            width: 350,
                            height: 44,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: ElevatedButton(
                              onPressed: () {
                                _showSlotSelector(context);
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
              ),
    );
  }

  // Helper function to set a new default address and call the API
  Future<void> _setDefaultAddress(int newDefaultId) async {
    // Find the address object that needs to be updated
    final addressToUpdate = ref
        .read(addressProvider)
        .firstWhere((address) => address.id == newDefaultId);

    // Show a loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Setting new default address...")),
    );

    // Call the editAddress API
    await ref
        .read(editAddressProvider.notifier)
        .editAddress(
          addressId: newDefaultId,
          contactDetails: addressToUpdate.contactDetails ?? '',
          addressDetails: addressToUpdate.addressDetails ?? '',
          type: addressToUpdate.type ?? 'home',
          isDefault: 1, // 1 for true
        );

    // After API call, update the local state
    if (mounted) {
      // Update the local list for immediate UI feedback
      final currentList = ref.read(addressProvider);
      final newList =
          currentList.map((address) {
            return address.copyWith(isDefault: address.id == newDefaultId);
          }).toList();

      // Sort to bring the new default to the top
      newList.sort((a, b) {
        final bVal = b.isDefault ? 1 : 0;
        final aVal = a.isDefault ? 1 : 0;
        return bVal.compareTo(aVal);
      });

      // Update the provider and the selected ID
      ref.read(addressProvider.notifier).state = newList;
      setState(() {
        selectedAddressId = newDefaultId;
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Default address updated!")));
    }
  }

  // Widget to show when no addresses are available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No address found. Please add a new one."),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (context) => const AddressScreen()),
              ).then((result) {
                if (result == true) {
                  _fetchAndSetInitialAddress();
                }
              });
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
        ],
      ),
    );
  }

  Widget _addressCard(
    Address addr, {
    required int id,
    bool isSelected = false,
    required void Function(int) onSelect,
  }) {
    final pref = AppPreference();
    final fallbackName = pref.getString(PreferencesKey.name);
    final fallbackPhone = pref.getString(PreferencesKey.phone);

    // Extract name & phone from contact_details if available
    String? displayName;
    String? displayPhone;

    if (addr.contactDetails != null && addr.contactDetails!.isNotEmpty) {
      final parts = addr.contactDetails!.split(',');
      displayName = parts.isNotEmpty ? parts[0].trim() : null;
      displayPhone = parts.length > 1 ? parts[1].trim() : null;
    }

    // Fallback if name or phone not provided in contact_details
    displayName ??= addr.user?.name ?? fallbackName ?? '';
    displayPhone ??= addr.user?.phone ?? fallbackPhone ?? '';

    return Container(
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
            value: addr.id,
            groupValue: selectedAddressId,
            onChanged: (_) => onSelect(addr.id),
            activeColor: const Color(0xFF004271),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👇 Name line
                Text(
                  displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),

                // 👇 Address details line
                Text(
                  addr.addressDetails ?? '',
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 6),

                // 👇 Phone line
                Text(
                  'Mobile: $displayPhone',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                // 👇 Show remove/edit for any selected address (removed default check for flexibility)
                if (isSelected)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final deleteService = ref.read(addressDeleteProvider);
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
                            await cartServices().addressApi(
                              ref,
                            ); // Refetch after delete
                          } else {
                            if (!context.mounted) return;
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
                        onPressed: () {
                          Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => AddressScreen(address: addr),
                            ),
                          ).then((result) {
                            if (result == true) {
                              _fetchAndSetInitialAddress();
                            }
                          });
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
    );
  }

  // Helper to initialize or update the selected address ID
  void _initializeSelectedId() {
    final addressList = ref.read(addressProvider);
    if (addressList.isNotEmpty) {
      final defaultAddr = addressList.firstWhere(
        (a) => a.isDefault,
        orElse: () => addressList.first,
      );
      setState(() {
        selectedAddressId = defaultAddr.id;
      });
    }
  }
}

void _showSlotSelector(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: kscoundPrimaryColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      int selectedTime = 1;
      int selectedDate = 0;
      int selectedExpert = -1;

      List<String> times = [
        "03:30 PM",
        "04:30 PM",
        "05:00 PM",
        "05:30 PM",
        "06:30 PM",
        "07:00 PM",
      ];

      List<String> dates = [
        "Mon, 22",
        "Tue, 23",
        "Wed, 24",
        "Thu, 25",
        "Fri, 26",
        "Sat, 27",
        "Sun, 28",
      ];

      List<Map<String, String?>> experts = [
        {"name": "Best Match for\nYour Service", "image": null},
        {"name": "Megha", "image": "assets/images/Megha.png"},
      ];

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 3,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your Qwik Slot - Choose Date & Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF353535),
                          ),
                        ),
                      ),

                      SizedBox(width: 90),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Dates
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        // --- Static "Oct" box first ---
                        Container(
                          width: 60,
                          height: 70,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 17.0),
                                  child: Text(
                                    "Oct",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // --- Rest of the dates as before ---
                        ...List.generate(dates.length, (i) {
                          List<String> parts = dates[i].split(',');
                          String label1 = parts[0].trim();
                          String label2 =
                              parts.length > 1 ? parts[1].trim() : "";
                          bool isSelected = (selectedDate == i);
                          return GestureDetector(
                            onTap: () => setState(() => selectedDate = i),
                            child: Container(
                              width: 60,
                              height: 70,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Color(0xFF004271)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    label1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    label2,
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
                  ),
                ),

                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selected Time",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF353535),
                    ),
                  ),
                ),

                // Times
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(times.length, (i) {
                    bool isSelected = selectedTime == i;
                    return ChoiceChip(
                      label: Text(times[i]),
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
                ),

                SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.only(left: 9.0, bottom: 13.0),
                  child: Text(
                    'Choose your Expert',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF353535),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(experts.length, (index) {
                      final expert = experts[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ), // 🔹 CHANGED: small gap
                        child: ExpertCard(
                          name: expert['name']!,
                          imagePath: expert['image'],
                          isSelected: selectedExpert == index,
                          onTap: () => setState(() => selectedExpert = index),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
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
        },
      );
    },
  );
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
                      ? Image.asset(imagePath!, fit: BoxFit.cover)
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
