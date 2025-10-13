import 'package:flutter/material.dart';
import '../../util/custom_app_bar.dart';

class QwikPicksScreen extends StatefulWidget {
  @override
  State<QwikPicksScreen> createState() => _QwikPicksScreenState();
}

class _QwikPicksScreenState extends State<QwikPicksScreen> {
  final List<_QwikPickItem> items = [
    _QwikPickItem('Deep Cleaning', 'assets/SeeMore/Deep_Cleaning.png'),
    _QwikPickItem(
      'Refrigerator Cleaning',
      'assets/SeeMore/Refrigerator_Cleaning.png',
    ),
    _QwikPickItem('Ironing', 'assets/images/Ironing.png'),
    _QwikPickItem(
      'Disinfection Services',
      'assets/SeeMore/Disinfection_Services.png',
    ),
    _QwikPickItem('pastcontrol', 'assets/SeeMore/pastcontrol.png'),
    _QwikPickItem('mani-pedi', 'assets/SeeMore/mani-pedi.png'),
    _QwikPickItem('facial', 'assets/SeeMore/facial.png'),
    _QwikPickItem('waxing', 'assets/SeeMore/waxing.png'),
    _QwikPickItem('Massage', 'assets/SeeMore/Massage.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBFF),
     appBar: CustomAppBar(title: 'Qwik Picks'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 18,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75, // perfect for big images and 2 line text
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _QwikPickCard(item: items[index]);
          },
        ),
      ),
    );
  }
}

class _QwikPickItem {
  final String title;
  final String imagePath;
  _QwikPickItem(this.title, this.imagePath);
}

class _QwikPickCard extends StatelessWidget {
  final _QwikPickItem item;
  const _QwikPickCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              height: 80,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(item.imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}