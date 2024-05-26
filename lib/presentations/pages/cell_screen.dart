import 'package:flutter/material.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';

class CellScreen extends StatelessWidget {
  const CellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ячейка'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Рубли:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('125000', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Евро:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('200', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Доллары:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('30', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Фунты:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('0', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Итого:', style: currencyText2),
                              SizedBox(
                                width: 5,
                              ),
                              Text('129000 руб.', style: currencyText2),
                            ])),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Card(
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Остаток:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1290', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Всего часов:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('129', style: currencyText1),
                            ])),
                    Divider(height: 1, thickness: 2),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('За один час:', style: currencyText1),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1290', style: currencyText1),
                            ])),
                  ])),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.errorContainer),
              child: Text(
                'Сбросить',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
