import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/core/constants/razorpay_constants.dart';
import 'package:learning_course2/models/courses/region_selection_model.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/providers/razorpay_provider.dart';
import 'package:learning_course2/screens/screen_bottom_nav.dart';
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

    final homeProvider = context.watch<HomescreenProvider>();

    final selectedRegion = homeProvider.regionSelectionModel
        .where((region) => region.id == homeProvider.selectedRegionId)
        .firstOrNull;

    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsConstants.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          isSuccess ? 'Payment Receipt' : 'Checkout',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 21,
            letterSpacing: -0.4,
            color: ColorsConstants.textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isSuccess
              ? _ReceiptView(
                  key: const ValueKey('receipt'),
                  receipt: paymentProvider.receipt!,
                )
              : _CheckoutView(
                  key: const ValueKey('checkout'),
                  provider: paymentProvider,
                  total: total,
                  selectionModel: selectedRegion,
                  courseCount: courseIds.length,
                ),
        ),
      ),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  final RegionSelectionModel? selectionModel;
  final RazorpayProvider provider;
  final double total;
  final int courseCount;

  const _CheckoutView({
    super.key,
    required this.provider,
    required this.total,
    required this.selectionModel,
    required this.courseCount,
  });

  @override
  Widget build(BuildContext context) {
    final currency = selectionModel?.currency ?? 'INR';

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 92,
                    width: 92,
                    decoration: BoxDecoration(
                      color: ColorsConstants.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      size: 46,
                      color: ColorsConstants.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                const Center(
                  child: Text(
                    'Complete your enrollment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      color: ColorsConstants.textColor,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'You’re one step away from starting your learning journey.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFEAECF0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.025),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ORDER SUMMARY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          color: Colors.black45,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: ColorsConstants.background,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: ColorsConstants.primary,
                              size: 24,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Course enrollment',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsConstants.textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$courseCount ${courseCount == 1 ? 'course' : 'courses'}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            size: 22,
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Divider(height: 1),
                      ),

                      const Text(
                        'Total amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        '$currency ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: ColorsConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFEAECF0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F7EE),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFF16834A),
                          size: 23,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Secure payment',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: ColorsConstants.textColor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Powered by Razorpay',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.verified_user_outlined,
                        color: Colors.green,
                        size: 21,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                const Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 17,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Please verify your order total before proceeding.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (provider.message != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      provider.message!,
                      style: const TextStyle(
                        color: Color(0xFFB42318),
                        fontSize: 13,
                      ),
                    ),
                  ),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () => context.read<RazorpayProvider>().pay(
                            keyId: RazorpayConstants.keyId,
                            amountInPaisa: (total * 100).round(),
                            regionId:
                                context
                                    .read<HomescreenProvider>()
                                    .selectedRegionId ??
                                3,
                            currency: currency,
                            courseName: 'Courses',
                            verify: (orderId, paymentId, signature) =>
                                context.read<CartProvider>().verifyPayment(
                                  razorpayOrderId: orderId,
                                  razorpayPaymentId: paymentId,
                                  razorpaySignature: signature,
                                  regionId:
                                      context
                                          .read<HomescreenProvider>()
                                          .selectedRegionId ??
                                      3,
                                ),
                          ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorsConstants.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 23,
                            width: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_rounded, size: 18),
                              SizedBox(width: 10),
                              Text(
                                'Pay securely',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Your payment is processed securely by Razorpay.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReceiptView extends StatelessWidget {
  final PaymentReceipt receipt;

  const _ReceiptView({super.key, required this.receipt});

  String formatDate(DateTime dateTime) {
    String two(int n) => n.toString().padLeft(2, '0');

    return '${two(dateTime.day)}/${two(dateTime.month)}/${dateTime.year} '
        '${two(dateTime.hour)}:${two(dateTime.minute)}';
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ColorsConstants.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final amount = (receipt.amountInPaisa / 100).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F7EE),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF16834A),
                      size: 62,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Payment Successful!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      color: ColorsConstants.textColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your payment has been completed successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFEAECF0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              color: ColorsConstants.primary,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Payment receipt',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: ColorsConstants.textColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),
                        const Divider(height: 1),

                        _row('Amount paid', '₹$amount'),
                        const Divider(height: 1),
                        _row('Course', receipt.courseName),
                        const Divider(height: 1),
                        _row('Payment ID', receipt.paymentId),
                        const Divider(height: 1),
                        _row('Date', formatDate(receipt.paidAt)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF16834A),
                        size: 17,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Transaction confirmation',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                context.read<RazorpayProvider>().reset();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColorsConstants.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue learning',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, size: 19),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
