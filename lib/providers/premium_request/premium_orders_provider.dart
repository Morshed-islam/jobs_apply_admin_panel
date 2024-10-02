import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/premium/premium_order.dart';

class PremiumOrdersProvider with ChangeNotifier {
  List<PremiumOrder> _orders = [];

  List<PremiumOrder> get orders => _orders;

  Future<void> fetchPremiumOrders() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('premium_orders').get();

    _orders = snapshot.docs
        .map((doc) => PremiumOrder.fromFirestore(doc))
        .toList();

    notifyListeners();
  }

  Future<void> updatePremiumPaymentStatus(
      String docId, String newStatus) async {
    await FirebaseFirestore.instance
        .collection('premium_orders')
        .doc(docId)
        .update({'premium_payment_status': newStatus});

    fetchPremiumOrders(); // Refresh the data
  }
}
