import 'package:flutter/material.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';
import 'package:flutter_tips_app/utils/formatters.dart';
class InfoListItem {
  final String label;
  final int value;

  InfoListItem({required this.label, required this.value});
}

class ListInfo extends StatelessWidget {
  const ListInfo({super.key, required this.items});

  final List<InfoListItem> items;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(capitalize(item.label), style: currencyText1),
                      const SizedBox(width: 5),
                      Text(item.value.toString(), style: currencyText1),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 2),
            ),
          ],
        ),
      ),
    );
  }
}
