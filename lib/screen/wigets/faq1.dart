import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CleaningRequirementPage extends StatefulWidget {
  const CleaningRequirementPage({super.key});

  @override
  State<CleaningRequirementPage> createState() =>
      _CleaningRequirementPageState();
}

class _CleaningRequirementPageState extends State<CleaningRequirementPage> {
  int selectedPlan = 0;
  int selectedCleaner = 2;
  String selectedHours = "1.5 hr/service";
  String selectedMaterial = "With material";

  final List<String> hoursOptions = [
    "1 hr/service ",
    "1.5 hr/service",
    "2 hr/service",
    "3 hr/service",
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.all(w * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPlanCard(w, h),
          SizedBox(height: h * 0.02),
          _buildCleanerSelection(w, h),
          SizedBox(height: h * 0.02),
          _buildHoursSelection(w, h),
          SizedBox(height: h * 0.02),
          _buildMaterialSelection(w, h),
        ],
      ),
    );
  }

  Widget _buildPlanCard(double w, double h) {
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
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pick a Plan That Fits You",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.015),
          SizedBox(
            height: h * 0.21, // Thoda vertical space jyada
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(plans.length, (index) {
                  bool isSelected = selectedPlan == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: index == 0 ? 0 : w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top section: description + price
                          Container(
                            width: 190,
                            padding: EdgeInsets.symmetric(
                              vertical: h * 0.024,
                              horizontal: w * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                width: 1.3,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plans[index]["description"]!,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: h * 0.01),
                                Text(
                                  plans[index]["price"]!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Bottom title section, highlighted
                          Container(
                            width: 190,
                            padding: EdgeInsets.symmetric(
                              vertical: h * 0.016,
                              horizontal: w * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Color(0xFFE6F2FF)
                                      : Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  width: 1.2,
                                ),
                                left: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  width: 1.2,
                                ),
                                right: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  width: 1.2,
                                ),
                                top: BorderSide.none,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                plans[index]["title"]!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanerSelection(double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How many cleaners do you need?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.015),
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) {
                  int cleanerCount = index + 1;
                  bool isSelected = selectedCleaner == cleanerCount;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedCleaner = cleanerCount);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: w * 0.03),
                      padding: EdgeInsets.symmetric(
                        vertical: h * 0.012,
                        horizontal: w * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        "$cleanerCount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.blue : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursSelection(double w, double h) {
    bool hasSelected = selectedHours != null && selectedHours.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How many hours should they stay?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.015),
          Container(
            decoration: BoxDecoration(
              color: hasSelected ? Color(0xFFE6F2FF) : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedHours,
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                filled: true,
                fillColor: hasSelected ? Color(0xFFE6F2FF) : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: hasSelected ? Colors.blue : Colors.grey.shade400,
                    width: 1,
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
                              selectedHours == option
                                  ? Colors.blue
                                  : Colors.black,
                          fontWeight:
                              selectedHours == option
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: (val) {
                setState(() => selectedHours = val!);
              },
            ),
          ),
          SizedBox(height: h * 0.01),
          Text(
            "AED 80/service",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialSelection(double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Do you need cleaning materials?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.015),
          Row(
            children:
                ["With material", "Without material"].map((opt) {
                  bool isSelected = selectedMaterial == opt;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedMaterial = opt);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: w * 0.03),
                      padding: EdgeInsets.symmetric(
                        vertical: h * 0.012,
                        horizontal: w * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        opt,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.blue : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: h * 0.01),
          Text(
            "+AED 10/service",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
