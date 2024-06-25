import 'package:flutter/material.dart';
import 'package:flutter_tips_app/presentations/pages/new_team_screen.dart';
import 'package:flutter_tips_app/presentations/widgets/employee_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tips_app/presentations/widgets/new_employee.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  Widget? activePage;

  @override
  void initState() {
    super.initState();
    fetchTeam();
  }

  Future<void> fetchTeam() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<Map<String, dynamic>> teams =
          docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      if (teams.isEmpty) {
        setState(() {
          activePage = const NewTeamScreen();
        });
      } else {
        // if (teams.isNotEmpty) {
        //   ref.read(teamProvider.notifier).setTeam(teams[0])
        // }
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
    } catch (e) {
      setState(() {
        activePage = const Center(
          child: Text('Error loading data'),
        );
      });
    }
  }

  void openAddEmployee() {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 900),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewEmployee(onAddEmployee: (employee) {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                openAddEmployee();
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: activePage ?? const Center(child: Text('Loading...')),
    );
  }
}
