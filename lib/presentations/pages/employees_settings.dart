import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
import 'package:flutter_tips_app/utils/formatters.dart';

class EmployeesSettings extends ConsumerStatefulWidget {
  const EmployeesSettings({super.key});

  @override
  ConsumerState<EmployeesSettings> createState() => _EmployeesSettingsState();
}

class _EmployeesSettingsState extends ConsumerState<EmployeesSettings> {
  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);
    return Column(
      children: [
        if (team != null)
          ListView.separated(
            shrinkWrap: true,
            itemCount: team.employees.length,
            itemBuilder: (context, index) {
              final item = team.employees[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ListTile(
                  title: Text(capitalize(item.name)),
                  trailing: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => {},
                    icon: const Icon(Icons.delete),
                    label: const Text('Удалить'),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
      ],
    );
  }
}
