import 'package:costermers/components/my_drawer.dart';
import 'package:costermers/pages/EmployeeDetails.dart';
import 'package:costermers/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Stream<QuerySnapshot>? employeeStream;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // Define 6 categories for tabs
    _tabController.addListener(_handleTabChange); // Add listener for tab changes
    loadEmployeeDetails(); // Load all employees initially
  }

  Future<void> loadEmployeeDetails([String? category]) async {
    employeeStream = DatabaseMethods().getEmployeeDetails(category: category);
    setState(() {});
  }

  void _handleTabChange() {
    // Load employees based on selected tab index
    switch (_tabController.index) {
      case 0:
        loadEmployeeDetails(); // All employees
        break;
      case 1:
        loadEmployeeDetails('Beverages');
        break;
      case 2:
        loadEmployeeDetails('Snacks');
        break;
      case 3:
        loadEmployeeDetails('Main Course');
        break;
      case 4:
        loadEmployeeDetails('Desserts');
        break;
      case 5:
        loadEmployeeDetails('Fast Food');
        break;
    }
  }

  // Widget to display employee details based on category
  Widget employeeDetailsWidget(String? category) {
    // Load employees based on category
    loadEmployeeDetails(category);

    return StreamBuilder<QuerySnapshot>(
      stream: employeeStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Employee Data Available'));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.65,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeDetails(
                      name: ds['Name'],
                      food: ds['food'],
                      offer: ds['offer'],
                      imageUrl: ds['ImageURL'],
                      description: ds['description'], category: ds['category'],
                    ),
                  ),
                );
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          ds['ImageURL'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds['Name'],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ds['food'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ds['offer'],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SLTC Foodie"),
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Make tabs scrollable if they don't fit in one line
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Beverages"),
            Tab(text: "Snacks"),
            Tab(text: "Main Course"),
            Tab(text: "Desserts"),
            Tab(text: "Fast Food"),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          employeeDetailsWidget(null), // All employees
          employeeDetailsWidget('Beverages'), // Beverages category
          employeeDetailsWidget('Snacks'), // Snacks category
          employeeDetailsWidget('Main Course'), // Main Course category
          employeeDetailsWidget('Desserts'), // Desserts category
          employeeDetailsWidget('Fast Food'), // Fast Food category
        ],
      ),
    );
  }
}
