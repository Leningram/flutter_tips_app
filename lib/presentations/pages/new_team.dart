import 'package:flutter/material.dart';

class NewTeamScreen extends StatefulWidget {
  const NewTeamScreen({super.key});

  @override
  State<NewTeamScreen> createState() => _NewTeamScreenState();
}

class _NewTeamScreenState extends State<NewTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        label: const Text('Create team'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
