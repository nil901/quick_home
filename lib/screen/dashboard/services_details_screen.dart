import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quick_home/screen/wigets/faq_comman.dart';


class ServicesDetailsScreen extends StatefulWidget {
  const ServicesDetailsScreen({super.key});
  @override
  State<ServicesDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServicesDetailsScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4F9FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              isEnglish ? 'Ironing' : 'كي الملابس',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Switch
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => isEnglish = true);
                    },
                    child: _langButton(selected: isEnglish, text: 'In English'),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() => isEnglish = false);
                    },
                    child: _langButton(selected: !isEnglish, text: 'In Arabic'),
                  ),
                ],
              ),
            ),
            // Top Image
            Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Ironing.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Title, Rating, Price, Book Now
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnglish ? 'Ironing' : 'كي الملابس',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isEnglish
                        ? 'Wrinkle-free clothes, crisp and neat – ready \nto wear anytime.'
                        : 'ملابس خالية من التجاعيد، نظيفة وجاهزة للارتداء في أي وقت.',
                    style: const TextStyle(
                        fontSize: 13, color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 4,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.grey),
                        itemCount: 5,
                        itemSize: 18.0,
                        unratedColor: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 5),
                      const SizedBox(width: 4),
                      const Text('(30k reviews)',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'AED 4.99',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE4F9FF),
                          foregroundColor: const Color(0xff004271),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(isEnglish ? 'Book Now' : 'احجز الآن',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Divider(thickness: 0.9),
            // About the Service
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                isEnglish ? 'About the service' : 'عن الخدمة',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                isEnglish
                    ? 'Say goodbye to wrinkles and creases! Our professional ironing service ensures your clothes look crisp, neat, and perfectly pressed – ready to wear for work, casual outings, or special occasions.'
                    : 'وداعًا للتجاعيد! خدمة الكي الاحترافية تضمن أن ملابسك تبدو مرتبة ونظيفة وجاهزة للارتداء في أي وقت.',
                style: const TextStyle(fontSize: 13.2, height: 1.5),
              ),
            ),
            const SizedBox(height: 18),
            Divider(thickness: 0.9, color: Colors.grey[300]),
            // Our Process Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                isEnglish ? 'Our Process' : 'عملية الخدمة',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            // Our Process Timeline
            _timelineStep(
              stepNum: 1,
              isImageLeft: false,
              imagePath: 'assets/images/Mobile.png',
              title: isEnglish ? 'Book Service' : 'حجز الخدمة',
              description: isEnglish
                  ? 'Schedule ironing at your \npreferred time through the \napp.'
                  : 'حدد موعد كي الملابس المفضل من خلال التطبيق.',
            ),
            _timelineStep(
              stepNum: 2,
              isImageLeft: true,
              imagePath: 'assets/images/Clean.png',
              title: isEnglish ? 'We Arrive' : 'نصل إلى بابك',
              description: isEnglish
                  ? 'Our professional staff \ncomes to your doorstep \nwith all essentials.'
                  : 'يصل موظفونا المحترفون إلى بابك بكل المستلزمات.',
            ),
            _timelineStep(
              stepNum: 3,
              isImageLeft: false,
              imagePath: 'assets/images/Iron.png',
              title: isEnglish ? 'At-Home Ironing' : 'كي الملابس في المنزل',
              description: isEnglish
                  ? 'Clothes are ironed neatly at \nyour place, hassle-free.'
                  : 'يتم كي الملابس بشكل مرتب في منزلك بسهولة.',
            ),
            _timelineStep(
              stepNum: 4,
              isImageLeft: true,
              imagePath: 'assets/images/Cloths.png',
              title: isEnglish ? 'Ready to Wear' : 'جاهز للارتداء',
              description: isEnglish
                  ? 'Crisp, wrinkle-free outfits \nhanded over instantly.'
                  : 'ملابس مرتبة وجاهزة للارتداء فوراً.',
              isLast: true,
            ),
            const SizedBox(height: 18),
            Divider(thickness: 0.9, color: Colors.grey[300]),
            // What's Included
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                isEnglish ? "What's Included?" : 'ما الذي يتضمنه ذلك؟',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _includedText(isEnglish
                      ? 'Professional at-home ironing'
                      : 'كي احترافي في المنزل'),
                  _includedText(isEnglish
                      ? 'Use of safe, quality equipment'
                      : 'استخدام معدات آمنة وعالية الجودة'),
                  _includedText(isEnglish
                      ? 'Neat folding/hanging after ironing'
                      : 'طي/تعليق الملابس بشكل مرتب بعد الكي'),
                  _includedText(isEnglish
                      ? 'Quick service with care handle'
                      : 'خدمة سريعة مع عناية خاصة'),
                  _includedText(isEnglish
                      ? 'Clothes ready to wear instantly'
                      : 'ملابس جاهزة للارتداء فوراً'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Divider(thickness: 0.9, color: Colors.grey[300]),
            // What We Need From You (card style)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                isEnglish ? 'What We Need From You' : 'ما الذي نحتاجه منك',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    neededCard(
                      icon: Image.asset('assets/images/Clean.png', height: 50),
                      text: isEnglish
                          ? 'Clean clothes,\nready to iron'
                          : 'ملابس نظيفة وجاهزة للكي',
                    ),
                    const SizedBox(width: 12),
                    neededCard(
                      icon: Image.asset('assets/images/Clean.png', height: 50),
                      text: isEnglish
                          ? 'Ironing board\nor flat surface'
                          : 'طاولة الكي أو سطح مستوي',
                    ),
                    const SizedBox(width: 12),
                    neededCard(
                      icon: Image.asset('assets/images/Clean.png', height: 50),
                      text: isEnglish
                          ? 'Access to\nelectricity'
                          : 'الوصول إلى الكهرباء',
                    ),
                    const SizedBox(width: 12),
                    neededCard(
                      icon: Image.asset('assets/images/Clean.png', height: 50),
                      text: isEnglish
                          ? 'Access to\nelectricity'
                          : 'الوصول إلى الكهرباء',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Text('Frequently asked questions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: const FaqComman(),
            ), // tumhare FAQ ki class ka naam yahan daalo
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Done'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff004271),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 190, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _langButton({required bool selected, required String text}) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? const Color(0xff004271) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xff004271), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xff004271),
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  static Widget _timelineStep({
    required int stepNum,
    required bool isImageLeft,
    required String imagePath,
    required String title,
    required String description,
    bool isLast = false,
  }) {
    final img = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding:
            const EdgeInsets.only(right: 35.5, left: 35.5, top: 4, bottom: 4),
        child: Image.asset(
          imagePath,
          height: 120,
          width: 130,
          fit: BoxFit.contain,
        ),
      ),
    );

    final circle = Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
              color: Color(0xff004271), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '$stepNum',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          width: 3,
          height: 90,
          color: Colors.grey[300],
        ),
      ],
    );

    final txt = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isImageLeft ? [img, circle, txt] : [txt, circle, img],
      ),
    );
  }

  static Widget neededCard({required Widget icon, required String text}) {
    return Container(
      width: 110,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: icon,
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _includedText(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text('• $text', style: const TextStyle(fontSize: 15.5)),
      );
}