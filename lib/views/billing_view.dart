import 'package:flutter/material.dart';

import '../widgets/child_selector_row.dart';
import '../widgets/invoice_card.dart';

class BillingView extends StatefulWidget {
  const BillingView({super.key});

  @override
  State<BillingView> createState() => _BillingViewState();
}

class _BillingViewState extends State<BillingView> {
  String selected = 'muhammad';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Billing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ChildSelectorRow(
            children: const [
              ChildMini(
                  id: 'muhammad',
                  name: 'Muhammad Hamza',
                  meta: '03-A | Autobahn'),
              ChildMini(
                  id: 'hafsa', name: 'Hafsa Shaikh', meta: '01-H | Elementary'),
            ],
            selectedId: selected,
            onSelected: (id) => setState(() => selected = id),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('TOTAL OUTSTANDING AMOUNT: PKR 0',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                InvoiceCard(
                  invoiceNo: 'INV-1001',
                  months: ['Aug-26', 'Sep-26', 'Oct-26'],
                  amount: '12000',
                  status: 'Paid',
                  items: [
                    ('Tuition Fee', 'Rs.10,000'),
                    ('Extra Facility Charges', 'Rs.2,000')
                  ],
                  receiveDate: '24 Oct 2026',
                  paymentMethod: 'Online',
                ),
                InvoiceCard(
                  invoiceNo: 'INV-1002',
                  months: ['May-26', 'Jun-26', 'Jul-26'],
                  amount: '11800',
                  status: 'Paid',
                  items: [
                    ('Tuition Fee', 'Rs.10,000'),
                    ('Annual Charges', 'Rs.1,800')
                  ],
                  receiveDate: '24 Jul 2026',
                  paymentMethod: 'OTC',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
