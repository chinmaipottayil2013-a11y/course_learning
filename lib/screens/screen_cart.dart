import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/bottom_nav_bar_provider.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:learning_course2/providers/homescreen_provider.dart';
import 'package:learning_course2/reusables/cart_screen_widget.dart';

import 'package:learning_course2/screens/screen_payment.dart';
import 'package:provider/provider.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final regionId = context.read<HomescreenProvider>().selectedRegionId ?? 3;

      context.read<CartProvider>().getCartItems(
        regionId: regionId,
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final homeProvider = context.watch<HomescreenProvider>();

    final cart = cartProvider.cartModel;
    final items = cart?.items ?? [];

    final selectedRegion = homeProvider.regionSelectionModel
        .where((r) => r.id == homeProvider.selectedRegionId)
        .firstOrNull;

    final double total =
        double.tryParse(cart?.courseTotal.toString() ?? '') ?? 0;

    final bool canCheckout =
        !cartProvider.isLoading &&
        cartProvider.errorMessage == null &&
        items.isNotEmpty;

    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: ColorsConstants.textColor,
            fontSize: 23,
            letterSpacing: -0.6,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: ColorsConstants.background,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: ColorsConstants.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: ColorsConstants.primary,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Added Courses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: ColorsConstants.textColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${items.length} ${items.length == 1 ? 'course' : 'courses'} in your cart',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (items.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEAECF0)),
                      ),
                      child: Text(
                        '${items.length} items',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  overscroll: false,
                ),
                child: Builder(
                  builder: (context) {
                    if (cartProvider.isLoading) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue.shade900,
                          size: 42,
                        ),
                      );
                    }

                    if (cartProvider.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.cloud_off_rounded,
                                size: 48,
                                color: Colors.black38,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                cartProvider.errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 16),
                              OutlinedButton.icon(
                                onPressed: () {
                                  final regionId =
                                      homeProvider.selectedRegionId ?? 3;

                                  context.read<CartProvider>().getCartItems(
                                    regionId: regionId,
                                    context: context,
                                  );
                                },
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Try again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (cart == null || items.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 46,
                                  color: ColorsConstants.primary.withValues(
                                    alpha: 0.65,
                                  ),
                                ),
                              ),

                              const Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: ColorsConstants.textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Explore courses and add the ones you want to learn.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  context
                                      .read<BottomNavBarProvider>()
                                      .changeIndex(0);
                                },
                                child: Text('Explore courses'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                      itemCount: items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return CartScreenWidget(
                          cartItemModel: item,
                          number: index + 1,
                          regionId: homeProvider.selectedRegionId ?? 3,
                          regionSelectionModel: selectedRegion,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // Fixed checkout summary at the bottom.
            if (cart != null && items.isNotEmpty)
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 18,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Total price',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '${selectedRegion?.currency ?? 'INR'} ${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: ColorsConstants.textColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: canCheckout
                              ? () {
                                  final courseIds = items
                                      .map((e) => e.course.id)
                                      .toList();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScreenPayment(
                                        courseIds: courseIds,
                                        total: total,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorsConstants.primary,
                            disabledBackgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.grey.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Proceed to Checkout',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded, size: 19),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
