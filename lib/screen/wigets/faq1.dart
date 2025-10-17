import 'package:flutter/material.dart';

class CleaningRequirementPage extends StatefulWidget {
  const CleaningRequirementPage({super.key});

  @override
  State<CleaningRequirementPage> createState() =>
      _CleaningRequirementPageState();
}

class _CleaningRequirementPageState extends State<CleaningRequirementPage> {
  int? _currentlyExpandedIndex;

  // State for selections
  int? selectedPlanIndex;
  int? selectedCleanerCount;
  String? selectedHours;
  String? selectedMaterial;

  final List<String> hoursOptions = [
    "1 hr/service",
    "1.5 hr/service",
    "2 hr/service",
    "3 hr/service",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPlanExpansionTile(0),
        const Divider(height: 24, thickness: 1),
        _buildCleanerExpansionTile(1),
        const Divider(height: 24, thickness: 1),
        // _buildHoursExpansionTile(2),
        // const Divider(height: 24, thickness: 1),
        _buildMaterialExpansionTile(3),
      ],
    );
  }

  void _handleExpansion(int index, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        _currentlyExpandedIndex = index;
      } else if (_currentlyExpandedIndex == index) {
        _currentlyExpandedIndex = null;
      }
    });
  }

  Widget _buildPlanExpansionTile(int index) {
    List<Map<String, String>> plans = [
      {
        "description": "For quick, one-time service",
        "price": "AED 1,999",
        "title": "One-Time Quick Fix",
      },
      {
        "description": "For weekly cleaning service",
        "price": "AED 3,499",
        "title": "Weekly Plan",
      },
      {
        "description": "For monthly cleaning service",
        "price": "AED 5,999",
        "title": "Monthly Plan",
      },
      {
        "description": "For Yearly cleaning service",
        "price": "AED 9,999",
        "title": "Annual Plan",
      },
    ];

    return _buildExpansionTile(
      index: index,
      title: "Pick a Plan That Fits You",
      subtitle:
          selectedPlanIndex != null ? plans[selectedPlanIndex!]['title'] : null,
      children: [
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: plans.length,
            itemBuilder: (context, planIndex) {
              bool isSelected = selectedPlanIndex == planIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPlanIndex = planIndex;
                    _currentlyExpandedIndex = index + 1; // Open next
                  });
                },
                child: Container(
                  width: 190,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                plans[planIndex]["description"]!,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                plans[planIndex]["price"]!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFFE6F2FF)
                                  : Colors.grey.shade300,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            plans[planIndex]["title"]!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCleanerExpansionTile(int index) {
    return _buildExpansionTile(
      index: index,
      title: "How many cleaners do you need?",
      subtitle:
          selectedCleanerCount != null
              ? "$selectedCleanerCount Cleaner(s)"
              : null,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(5, (i) {
            int cleanerCount = i + 1;
            bool isSelected = selectedCleanerCount == cleanerCount;
            return ChoiceChip(
              label: Text("$cleanerCount"),
              selected: isSelected,
              backgroundColor: Colors.grey.shade200,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    selectedCleanerCount = cleanerCount;
                    _currentlyExpandedIndex = index + 1; // Open next
                  });
                }
              },
              selectedColor: Colors.blue.shade50,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black87,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHoursExpansionTile(int index) {
    bool hasSelected = selectedHours != null;

    return _buildExpansionTile(
      index: index,
      title: "How many hours should they stay?",
      subtitle: selectedHours ?? "Select hours",
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedHours,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            hint: const Text("Select hours"),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            filled: true,
            fillColor: hasSelected ? const Color(0xFFE6F2FF) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasSelected ? Colors.blue : Colors.grey.shade400,
                width: 1.5,
              ),
            ),
          ),
          items:
              hoursOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(
                      color:
                          selectedHours == option ? Colors.blue : Colors.black,
                      fontWeight:
                          selectedHours == option
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                selectedHours = val;
                _currentlyExpandedIndex = index + 1; // Open next
              });
            }
          },
        ),
        const SizedBox(height: 8),
        const Text(
          "AED 80/service",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildMaterialExpansionTile(int index) {
    return _buildExpansionTile(
      index: index,
      title: "Do you need cleaning materials?",
      subtitle: selectedMaterial,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              ["With material", "Without material"].map((opt) {
                bool isSelected = selectedMaterial == opt;
                return ChoiceChip(
                  label: Text(opt),
                  selected: isSelected,
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedMaterial = opt;
                        _currentlyExpandedIndex =
                            null; // Last one, so collapse all
                      });
                    }
                  },
                  selectedColor: Colors.blue.shade50,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blue : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 8),
        const Text(
          "+AED 10/service",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildExpansionTile({
    required int index,
    required String title,
    String? subtitle,
    required List<Widget> children,
  }) {
    bool isExpanded = _currentlyExpandedIndex == index;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        key: ValueKey(index),
        initiallyExpanded: isExpanded,
        shape: const Border(),
        collapsedShape: const Border(),
        onExpansionChanged: (expanded) => _handleExpansion(index, expanded),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle:
            subtitle != null && !isExpanded
                ? Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                )
                : null,
        childrenPadding: const EdgeInsets.all(16).copyWith(top: 0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
