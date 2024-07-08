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
  final _form = GlobalKey<FormState>();
  String _enteredName = '';
  bool _isLoading = false;

  void _createEmployee() async {
    final team = ref.read(teamProvider);

    _isLoading = true;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      _isLoading = false;
      return;
    }
    _form.currentState!.save();
    final duplicate = team!.employees.any((employee) =>
        employee.name.trim().toLowerCase() ==
        _enteredName.trim().toLowerCase());
    if (duplicate) {
      // Handle the duplicate case, for example, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Сотрудник с таким именем уже существует')),
      );
      _isLoading = false;
      return;
    }
    await ref.read(teamProvider.notifier).addEmployee(_enteredName.trim());
    _isLoading = false;
  }

  void _removeEmployee(String id) {
    ref.read(teamProvider.notifier).removeEmployee(id);
  }

  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);
    return Form(
      key: _form,
      child: Column(
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
                      onPressed: () => {_removeEmployee(item.id)},
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
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              label: Text('Имя нового сотрудника'),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Введите имя';
              }
              if (value.length < 3) {
                return 'Минимум 3 символа';
              }
              return null;
            },
            onSaved: (value) {
              _enteredName = value!;
            },
          ),
          TextButton(
              onPressed: _isLoading ? null : _createEmployee,
              child: const Text('Добавить'))
        ],
      ),
    );
  }
}
