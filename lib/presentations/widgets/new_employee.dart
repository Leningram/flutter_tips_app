import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class NewEmployee extends ConsumerStatefulWidget {
  const NewEmployee({super.key});

  @override
  ConsumerState<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends ConsumerState<NewEmployee> {
  final _form = GlobalKey<FormState>();
  String _enteredName = '';
  var _isLoading = false;

  void _createEmployee() async {
    _isLoading = true;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    await ref.read(teamProvider.notifier).addEmployee(_enteredName);
    if (!mounted) {
      return;
    }
    _isLoading = false;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (builder, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добавить сотрудника',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 15,
                    decoration: const InputDecoration(
                      label: Text('Имя'),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Отмена'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        onPressed: _isLoading ? null : _createEmployee,
                        child: const Text('Сохранить'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
