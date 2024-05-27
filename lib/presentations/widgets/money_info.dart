import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';
import 'package:flutter_tips_app/utils/formatters.dart';

class MoneyInfo extends StatelessWidget {
  const MoneyInfo({super.key, required this.team});

  final Team team;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(capitalize(team.mainCurrencyName),
                          style: currencyText1),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(team.mainCurrencySum.toString(),
                          style: currencyText1),
                    ])),
            const Divider(height: 1, thickness: 2),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: team.currencies.length,
              itemBuilder: (context, index) {
                final currency = team.currencies[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(capitalize(currency.name), style: currencyText1),
                      const SizedBox(width: 5),
                      Text(currency.amount.toString(), style: currencyText1),
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
