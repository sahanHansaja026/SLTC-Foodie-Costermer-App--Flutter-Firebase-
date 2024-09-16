import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add employee details
  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    try {
      await _firestore.collection("Employee").doc(id).set(employeeInfoMap);
      // Success toast message
      Fluttertoast.showToast(
        msg: "Details added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Error toast message
      Fluttertoast.showToast(
        msg: "Failed to add details: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // Function to get employee details as a stream of snapshots with optional category filter
  Stream<QuerySnapshot> getEmployeeDetails({String? category}) {
    try {
      if (category == null || category.isEmpty) {
        return _firestore.collection("Employee").snapshots();
      } else {
        return _firestore
            .collection("Employee")
            .where('category', isEqualTo: category) // Filtering by category
            .snapshots();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to fetch employee details: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception("Error fetching employee details: $e");
    }
  }
}
