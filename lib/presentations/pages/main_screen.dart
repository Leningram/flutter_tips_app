import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/presentations/pages/new_team.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
// import 'package:flutter_tips_app/presentations/widgets/user_info.dart';
// import 'package:flutter_tips_app/providers/team_prodiver.dart';
// import 'package:flutter_tips_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tips_app/providers/team_prodiver.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.actions}) : super(key: key);
  final List<Widget> actions;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? activePage;

  @override
  void initState() {
    super.initState();
    fetchTeam();
  }

  Future<void> fetchTeam() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    List<Map<String, dynamic>> teams =
        docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    if (teams.isEmpty) {
      setState(() {
        activePage = const NewTeamScreen();
      });
    } else {
      setState(() {
        activePage = const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (userEmployee != null) UserInfo(user: userEmployee),
            Divider(
              height: 1,
              thickness: 2,
            ),
            EmployeeList()
          ],
        );
      });
    }
    // if (teams.isNotEmpty) {
    //   ref.read(teamProvider.notifier).setTeam(teams[0])
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activePage ?? const Center(child: Text('Loading...')),
    );
  }
}
