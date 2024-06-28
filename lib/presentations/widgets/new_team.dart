import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/team.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';

class NewTeam extends ConsumerStatefulWidget {
  const NewTeam({super.key});

  @override
  ConsumerState<NewTeam> createState() => _NewTeamState();
}

class _NewTeamState extends ConsumerState<NewTeam> {
  final _form = GlobalKey<FormState>();
  String _enteredName = '';

  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Готово'),
        content: const Text('Команда успешно создана.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ОК'),
          ),
        ],
      ),
    );
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ОК'),
          ),
        ],
      ),
    );
  }

  void createTeam() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      String id = '';
      await FirebaseFirestore.instance.collection('teams').add({
        'name': _enteredName,
        'adminId': FirebaseAuth.instance.currentUser!.uid,
        'mainCurrencyName': 'Рубли',
        'mainCurrencySum': 0,
      }).then((DocumentReference docRef) {
        id = docRef.id;
      });

      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
      _showSuccessMessage();
      ref.read(teamProvider.notifier).setTeam(Team(
          name: _enteredName,
          id: id,
          adminId: FirebaseAuth.instance.currentUser!.uid,
          mainCurrencyName: 'Рубли',
          mainCurrencySum: 0,
          currencies: [],
          employees: []));
    } catch (e) {
      _showErrorMessage(e.toString());
    }
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
                    'Создать команду',
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
                      label: Text('Название команды'),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите название';
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
                        onPressed: createTeam,
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
