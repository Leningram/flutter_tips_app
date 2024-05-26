import 'package:flutter/material.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/utils/formatters.dart';
import 'package:flutter_tips_app/styles/text.styles.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});

  final Employee user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: bodyText2,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                formatNumber(user.tipsAmount),
                style: titleText1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'часов:',
                    style: bodyText1,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    user.hours.toString(),
                    style: bodyText1,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'аванс:',
                    style: bodyText1,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    formatNumber(user.advance),
                    style: bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
