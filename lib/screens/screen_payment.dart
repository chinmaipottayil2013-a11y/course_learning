import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/razorpay_constants.dart';

import 'package:learning_course2/providers/razorpay_provider.dart';
import 'package:provider/provider.dart';

class ScreenPayment extends StatelessWidget {
  final double total;
  final List<dynamic> courseIds;
  const ScreenPayment({
    super.key,
    required this.total,
    required this.courseIds,
  });

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<RazorpayProvider>();
    final isSuccess = paymentProvider.status == PaymentStatus.success;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isSuccess ? 'Receipt' : 'Payment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),

        child: isSuccess
            ? _ReceiptView(receipt: paymentProvider.receipt!)
            : _CheckoutView(provider: paymentProvider, total: total),
      ),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  final RazorpayProvider provider;
  final double total;
  const _CheckoutView({required this.provider, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(
            Icons.school_outlined,
            size: 75,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Course Enrollment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter Development Course',
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total amount',
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                '₹${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.lock_outline, color: Colors.green),
          title: Text('Secure payment with Razorpay'),
          subtitle: Text('UPI, cards and net banking'),
        ),
        const Spacer(),
        if (provider.message != null)
          Text(provider.message!, style: const TextStyle(color: Colors.red)),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: provider.isLoading
                ? null
                : () => context.read<RazorpayProvider>().pay(
                    keyId: RazorpayConstants.keyId,
                    amountInPaisa: 90000,
                    currency: 'INR',
                    courseName: 'Flutter development',
                  ),
            child: provider.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Pay'),
          ),
        ),
      ],
    );
  }
}

class _ReceiptView extends StatelessWidget {
  final PaymentReceipt receipt;
  const _ReceiptView({required this.receipt});

  String formatdate(DateTime datTime) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(datTime.day)}/${two(datTime.month)}/${datTime.year} ${two(datTime.hour)}:${two(datTime.minute)}';
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        SizedBox(width: 16),
        Flexible(child: Text(value, textAlign: TextAlign.right)),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    final rupees = (receipt.amountInPaisa / 100).toStringAsFixed(2);
    return Column(
      children: [
        const SizedBox(height: 16),
        const Icon(Icons.check_circle, color: Colors.green, size: 72),
        const SizedBox(height: 12),
        const Text(
          'Payment Successful',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _row('Amount paid', '₹$rupees'),
              const Divider(),
              _row('Course', receipt.courseName),
              _row('Payment ID', receipt.paymentId),
              _row('Date', formatdate(receipt.paidAt)),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              context.read<RazorpayProvider>().reset();
            },
            child: const Text('Done'),
          ),
        ),
      ],
    );
  }
}
