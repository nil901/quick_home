import 'package:flutter/material.dart';
import 'package:quick_home/model/home_model.dart';
import '../../util/custom_app_bar.dart';
class QwikPicksScreen extends StatelessWidget {
  final HomeModel item;
  const QwikPicksScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Flatten all items from all sections
    final allItems = item.sections
        .expand((section) => section.items.items)
        .toList();

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
            childAspectRatio: 0.75,
          ),
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            return _QwikPickCard(item: allItems[index]);
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
  final Item item; // now just a single item
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
        onTap: () {
          // navigate to detail page if needed
        },
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
                child: item.imageUrl.isNotEmpty
                    ? Image.network(item.imageUrl, fit: BoxFit.cover)
                    : Icon(Icons.image, size: 40),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                item.name,
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
