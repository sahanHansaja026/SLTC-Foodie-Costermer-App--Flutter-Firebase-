import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costermers/services/auth/auth_service.dart';
import 'package:flutter/material.dart';


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final String userEmail = authService.getUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user_email', isEqualTo: userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!.docs;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index].data();
                final String status = order['status'] ?? 'unknown';

                // Define the color based on the status
                Color getStatusColor(String status) {
                  switch (status.toLowerCase()) {
                    case 'available':
                      return Colors.green;
                    case 'canceled':
                      return Colors.red;
                    case 'ready to deliver':
                      return Colors.orange;
                    case 'processing':
                      return const Color.fromARGB(255, 4, 0, 247);
                    case 'delivered':
                      return const Color.fromARGB(255, 251, 1, 222);
                    default:
                      return const Color.fromARGB(255, 0, 0, 0);
                  }
                }

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: SizedBox(
                      width: 100,
                      child: order['image_url'] != null
                          ? Image.network(
                              order['image_url'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.error,
                                size: 100,
                                color: Colors.red,
                              ),
                            )
                          : const Icon(Icons.image, size: 100),
                    ),
                    title: Text(order['food_name'] ?? 'No name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quentity : ${order['quantity']}'),
                        Text('Total: LKR ${order['total_price'].toStringAsFixed(2)}'),
                        Text('Date: ${order['date']}'),
                        Text('Time: ${order['time']}'),
                        Text(
                          'Status: ${status[0].toUpperCase()}${status.substring(1)}',
                          style: TextStyle(
                            color: getStatusColor(status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: (status == 'ready to deliver' || status == 'delivered' || status == 'canceled')
                        ? null // Disable cancel button for these statuses
                        : IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () async {
                              // Confirm cancellation
                              final bool confirmCancel = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Cancel Order'),
                                    content: const Text('Are you sure you want to cancel this order?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmCancel) {
                                // Call the function to cancel the order
                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(orders[index].id)
                                    .update({'status': 'canceled'});

                                // Show a confirmation message
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Order canceled successfully!')),
                                );
                              }
                            },
                          ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
