import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:quick_home/model/service_details_model.dart';

class FaqComman extends StatefulWidget {
  final Map<String, FAQItem>? faqData;
  const FaqComman({super.key, this.faqData});

  @override
  State<FaqComman> createState() => _FaqCommanState();
}

class _FaqCommanState extends State<FaqComman> {


  @override

  @override
  Widget build(BuildContext context) {
    if (widget.faqData == null || widget.faqData!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("No FAQs available.", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.faqData!.length,
      itemBuilder: (context, index) {
        final faq = widget.faqData!.values.elementAt(index);
        final question = faq.question ?? '';
        final answer = parseHtmlString(faq.answer ?? '');

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: HexColor("#F4F2F2"),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              title: Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String parseHtmlString(String htmlString) {
  final document = htmlParser.parse(htmlString);
  return document.body?.text.trim() ?? '';
}
