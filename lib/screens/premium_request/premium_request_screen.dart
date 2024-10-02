import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobs_apply_admin_panel/utils/enums/payment_status.dart';
import 'package:provider/provider.dart';

import '../../providers/premium_request/premium_orders_provider.dart';

class PremiumRequestPage extends StatefulWidget {
  @override
  State<PremiumRequestPage> createState() => _PremiumRequestPageState();
}

/*class _PremiumRequestPageState extends State<PremiumRequestPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<PremiumOrdersProvider>(context, listen: false).fetchPremiumOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PremiumOrdersProvider>(
      builder: (context, provider, child) {
        return provider.orders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: provider.orders.length,
          itemBuilder: (context, index) {
            final order = provider.orders[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${order.userEmail}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Transaction ID: ${order.transactionId}'),
                    Text('Payment Method: ${order.paymentMethod}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Status:'),
                        DropdownButton<String>(
                          value: [PAYMENT_STATUS.PENDING.name, PAYMENT_STATUS.PAID.name, PAYMENT_STATUS.PROCESSING.name, PAYMENT_STATUS.CANCELLED.name]
                              .contains(order.premiumPaymentStatus)
                              ? order.premiumPaymentStatus
                              : PAYMENT_STATUS.PENDING.name, // default or fallback value
                          items: [PAYMENT_STATUS.PENDING.name, PAYMENT_STATUS.PAID.name, PAYMENT_STATUS.PROCESSING.name, PAYMENT_STATUS.CANCELLED.name].map((String status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status,style: TextStyle(color: status == PAYMENT_STATUS.PENDING.name ? Colors.orange : status == PAYMENT_STATUS.PAID.name ? Colors.green : status == PAYMENT_STATUS.PROCESSING.name ? Colors.blue : Colors.red),),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context.read<PremiumOrdersProvider>()
                                  .updatePremiumPaymentStatus(order.id, newValue);
                            }
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}*/

class _PremiumRequestPageState extends State<PremiumRequestPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<PremiumOrdersProvider>(context, listen: false).fetchPremiumOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PremiumOrdersProvider>(
      builder: (context, provider, child) {
        if (provider.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width * 0.13,
                    headingRowColor:
                    WidgetStateColor.resolveWith((states) => Colors.grey),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Transaction ID',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Payment Method',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                    rows: provider.orders.map((order) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(order.userEmail)),
                          DataCell(Text(order.transactionId)),
                          DataCell(Text(order.paymentMethod)),
                          DataCell(
                            DropdownButton<String>(
                              value: [
                                PAYMENT_STATUS.PENDING.name,
                                PAYMENT_STATUS.PAID.name,
                                PAYMENT_STATUS.PROCESSING.name,
                                PAYMENT_STATUS.CANCELLED.name
                              ].contains(order.premiumPaymentStatus)
                                  ? order.premiumPaymentStatus
                                  : PAYMENT_STATUS.PENDING.name,
                              items: [
                                PAYMENT_STATUS.PENDING.name,
                                PAYMENT_STATUS.PAID.name,
                                PAYMENT_STATUS.PROCESSING.name,
                                PAYMENT_STATUS.CANCELLED.name
                              ].map((String status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: status ==
                                          PAYMENT_STATUS.PENDING.name
                                          ? Colors.orange
                                          : status ==
                                          PAYMENT_STATUS.PAID.name
                                          ? Colors.green
                                          : status ==
                                          PAYMENT_STATUS
                                              .PROCESSING.name
                                          ? Colors.blue
                                          : Colors.red,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) async {
                                if (newValue != null) {
                                  context
                                      .read<PremiumOrdersProvider>()
                                      .updatePremiumPaymentStatus(
                                      order.id, newValue);

                                  // Also update the user’s collection based on the selected status
                                  bool isPremium = newValue == PAYMENT_STATUS.PAID.name;
                                  String userPremiumStatus = isPremium ? PAYMENT_STATUS.PAID.name : newValue;

                                  // Assuming the user's document ID is the same as order.userId
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(order.userId)
                                      .update({
                                    'is_premium': isPremium,
                                    'premium_payment_status': userPremiumStatus,
                                  });

                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
