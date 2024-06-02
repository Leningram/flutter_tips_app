import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Row(
            children: [
              Icon(
                Icons.monetization_on_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                'FourSeasons',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,                    ),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Главная',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
          ),
          onTap: () {
            onSelectScreen('main');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Настройки',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
          ),
          onTap: () {
            onSelectScreen('settings');
          },
        )
      ],)
    );
  }
}
