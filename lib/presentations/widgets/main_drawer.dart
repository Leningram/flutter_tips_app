import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/presentations/pages/settings_screen.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final team = ref.watch(teamProvider);

    void setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'settings') {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
      }
    }

    return Drawer(
        child: Column(
      children: [
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
                team?.name ?? 'Loading...',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                    ),
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
            setScreen('main');
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
            setScreen('settings');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Выйти',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
          ),
          onTap: () {
            ref.read(teamProvider.notifier).clearTeam();
            FirebaseAuth.instance.signOut();
          },
        )
      ],
    ));
  }
}
