import 'package:flutter/material.dart';
import 'package:jobs_apply_admin_panel/utils/enums/payment_status.dart';
import 'package:provider/provider.dart';

import '../../providers/premium_request/premium_orders_provider.dart';

class PremiumRequestPage extends StatefulWidget {
  @override
  State<PremiumRequestPage> createState() => _PremiumRequestPageState();
}

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
        return provider.orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: provider.orders.length,
          itemBuilder: (context, index) {
            final order = provider.orders[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(12),
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
                        Text('Status:'),
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
}
