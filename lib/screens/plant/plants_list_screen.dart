import 'package:flutter/material.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyPlantsPage();
  }
}

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({Key? key}) : super(key: key);

  @override
  State createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  void initState() {
    super.initState();
    _loadPlants();
  }

  int bottomNavIndex = 2;
  List<Map<String, dynamic>> plants = [];

  void _showAddPlantDialog() {
    String plantName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Plant'),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter plant name"),
            onChanged: (value) {
              plantName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (plantName.isNotEmpty) {
                  setState(() {
                    plants.add({'plantName': plantName});
                  });
                  Navigator.of(context).pop();

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('plants')
                        .add({'plantName': plantName});
                    _loadPlants();
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _loadPlants() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('plants')
              .get();

      setState(() {
        plants =
            snapshot.docs.map((doc) {
              return {'id': doc.id, 'plantName': doc['plantName']};
            }).toList();
      });
    }
  }

  void _deletePlant(String plantId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Voulez-vous supprimer cette plante ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Oui'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Non'),
              ),
            ],
          );
        },
      );

      if (confirmDelete) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('plants')
            .doc(plantId)
            .delete();

        setState(() {
          plants.removeWhere((plant) => plant['id'] == plantId);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const green700 = Color(0xFF047857);
    const gray200 = Color(0xFFE5E7EB);
    const gray300 = Color(0xFFD1D5DB);
    const gray500 = Color(0xFF6B7280);
    const white = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'My Plants',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/images/logoApp1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            semanticLabel: 'App logo',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
            tooltip: 'More options',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: gray300),
                color: gray200,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: green700,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Plants (${plants.length})',
                        style: const TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          plants.isEmpty
              ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logoApp1.png',
                        width: 64,
                        height: 64,
                        fit: BoxFit.contain,
                        semanticLabel: 'App logo centered',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'You Have No Plants',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "You haven't added any plants yet.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: gray500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.grass,
                          color: green700,
                          size: 40,
                        ),
                        title: Text(
                          plants[index]['plantName'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Click to view details'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deletePlant(plants[index]['id']);
                          },
                        ),
                        onTap: () {
                          // Navigate to plant details screen
                        },
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPlantDialog,
        backgroundColor: green700,
        child: const Icon(Icons.add, size: 28),
        tooltip: 'Add plant',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: bottomNavIndex,
        selectedColor: green700,
        unselectedColor: gray500,
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }
}
