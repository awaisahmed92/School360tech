import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoiceNo,
    required this.months,
    required this.amount,
    required this.status,
    required this.items,
    required this.receiveDate,
    required this.paymentMethod,
  });

  final String invoiceNo;
  final List<String> months;
  final String amount;
  final String status;
  final List<(String, String)> items;
  final String receiveDate;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    final paid = status.toLowerCase() == 'paid';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice # $invoiceNo',
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final month in months)
                  Chip(
                    label: Text(month),
                    backgroundColor: const Color(0xFFECE9FF),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Rs.$amount',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: paid
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(status,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Total Fee',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Text('↳ ',
                        style: TextStyle(color: Color(0xFF6B7280))),
                    Expanded(child: Text(item.$1)),
                    Text(item.$2),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text('Receive Date: $receiveDate'),
            Text('Paid via $paymentMethod'),
          ],
        ),
      ),
    );
  }
}
