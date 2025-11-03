import 'package:flutter/material.dart';

class Payment {
  final String image;
  final String title;
  final String name;
  final String date;
  final String price;

  Payment({
    required this.image,
    required this.title,
    required this.name,
    required this.date,
    required this.price,
  });
}

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff6fbff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff6fbff),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Collection",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search by service or date",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Payment History",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // 💳 Payment List
            Expanded(
              child: ListView.builder(
                itemCount: _payments.length,
                itemBuilder: (context, index) {
                  final payment = _payments[index];
                  return _buildPaymentCard(
                    image: payment.image,
                    title: payment.title,
                    name: payment.name,
                    date: payment.date,
                    price: payment.price,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // In a real app, this data would come from an API or database
  final List<Payment> _payments = [
    Payment(
      image: "assets/images/cleaning.png",
      title: "Home Deep Cleaning",
      name: "Ravi Pagare",
      date: "10 Oct 2025",
      price: "AED 2499",
    ),
    Payment(
      image: "assets/images/beuty.png",
      title: "Facial",
      name: "Sayali",
      date: "07 Oct 2025",
      price: "AED 999",
    ),
    Payment(
      image: "assets/images/loandrey.png",
      title: "Laundry",
      name: "Preeti",
      date: "05 Oct 2025",
      price: "AED 999",
    ),
  ];

  // 🧾 Payment Card
  Widget _buildPaymentCard({
    required String image,
    required String title,
    required String name,
    required String date,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // 🖼 Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 55, height: 55, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // 📄 Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "By $name",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Divider(),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                ),
              ],
            ),
          ),

          // 💰 Price + Paid Tag
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff002b5c),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Paid",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
