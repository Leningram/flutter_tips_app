import 'package:flutter/material.dart';
import 'package:flutter_tips_app/presentations/widgets/new_team.dart';

class NewTeamScreen extends StatefulWidget {
  const NewTeamScreen({super.key});

  @override
  State<NewTeamScreen> createState() => _NewTeamScreenState();
}

class _NewTeamScreenState extends State<NewTeamScreen> {

  void openCreateTeamModal() {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 900),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewTeam(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: openCreateTeamModal,
        label: const Text('Create team'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
