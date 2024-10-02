import 'package:cloud_firestore/cloud_firestore.dart';

class PremiumOrder {
  final String id;
  final String userEmail;
  final String transactionId;
  final String paymentMethod;
  String premiumPaymentStatus;

  PremiumOrder({
    required this.id,
    required this.userEmail,
    required this.transactionId,
    required this.paymentMethod,
    required this.premiumPaymentStatus,
  });

  factory PremiumOrder.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PremiumOrder(
      id: data['id'] ?? '',
      userEmail: data['email'] ?? '',
      transactionId: data['transaction_id'] ?? '',
      paymentMethod: data['payment_method'] ?? '',
      premiumPaymentStatus: data['premium_payment_status'] ?? 'PENDING',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': userEmail,
      'transaction_id': transactionId,
      'payment_method': paymentMethod,
      'premium_payment_status': premiumPaymentStatus,
    };
  }
}
