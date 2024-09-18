import 'package:costermers/pages/PaymentPage.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatefulWidget {
  final String name;
  final String food;
  final String offer;
  final String imageUrl;
  final String description; // New field for description
  final String category; // New field for category

  const EmployeeDetails({
    super.key,
    required this.name,
    required this.food,
    required this.offer,
    required this.imageUrl,
    required this.description, // Required for description
    required this.category, // Required for category
  });

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  int quantity = 1; // Initial quantity
  double totalPrice = 0.0; // Total price initialized to 0

  @override
  void initState() {
    super.initState();
    totalPrice =
        double.parse(widget.food); // Initialize total price based on food price
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      totalPrice = quantity * double.parse(widget.food);
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = quantity * double.parse(widget.food);
      });
    }
  }

  void navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          totalPrice: totalPrice,
          name: widget.name,
          imageUrl: widget.imageUrl,
          quantity: quantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item Details",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 1, 2),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Display price and offer
            Text(
              "Price: LKR ${widget.food}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Offer: ${widget.offer}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Display category
            Text(
              "Category: ${widget.category}",
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 10),

            // Display description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            Column(
              children: [
                Row(
                  children: [
                    // Decrease button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        color: const Color.fromARGB(255, 5, 186, 11),
                        onPressed: decreaseQuantity,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$quantity",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Increase button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: const Color.fromARGB(255, 1, 84, 4),
                        onPressed: increaseQuantity,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Display total price
                Text(
                  "Total Price: LKR ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                // Proceed to Payment Button
                ElevatedButton(
                  onPressed: () => navigateToPayment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
