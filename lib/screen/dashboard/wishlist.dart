import 'package:flutter/material.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> items = [
    {
      "image": "assets/images/ironing1.png",
      "title": "Ironing",
      "description":
          "Wrinkle-free clothes, crisp and neat – \nready to wear anytime.",
      "price": 499,
      "reviews": "30k reviews",
      "options": "4 options",
    },
    {
      "image": "assets/images/foldng.png",
      "title": "Folding",
      "description":
          "Properly folded clothes to save space \nand keep your wardrobe tidy.",
      "price": 599,
      "reviews": "15k reviews",
      "options": "3 options",
    },
  ];

  List<bool> bookedStatus = [];
  List<int> countStatus = [];

  @override
  void initState() {
    super.initState();
    bookedStatus = List.filled(items.length, false);
    countStatus = List.filled(items.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    const kprimary = Color(0xFF004271);
    const kscoundPrimaryColor = Color(0xFFE6F6FF);
    const kblack = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6F6FF),
        elevation: 0,
        title: const Text(
          'My Wishlist',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Image + Book Now / Counter + Options
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/ironing1.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            bookedStatus[index]
                                ? Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: kscoundPrimaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (countStatus[index] > 0) {
                                              countStatus[index]--;
                                            }
                                            if (countStatus[index] == 0) {
                                              bookedStatus[index] = false;
                                            }
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 1,
                                          ),
                                          child: Text(
                                            "–",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: kprimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${countStatus[index]}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: kprimary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            countStatus[index]++;
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 1,
                                          ),
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: kprimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : InkWell(
                                  onTap: () {
                                    setState(() {
                                      bookedStatus[index] = true;
                                      countStatus[index] = 1;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: kscoundPrimaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 13,
                                      ),
                                      child: Text(
                                        "Book Now",
                                        style: TextStyle(
                                          color: kprimary,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            const SizedBox(height: 8),
                            Text(
                              item["options"],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // Right: Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item["description"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Starts at AED ${item["price"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kblack,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                  const Icon(
                                    Icons.star_half,
                                    size: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "(${item["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const ServicesDetailsScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "View Details",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: kprimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🗑️ Delete Icon (Top Right)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      child: Image.asset(
                        'assets/icons/delete.png', // correct image path
                        width: 22,
                        height: 22,
                        color:
                            Colors
                                .black54, // optional, agar color overlay chahiye
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
