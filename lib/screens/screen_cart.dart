import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

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
    final cartScreenProvider = context.watch<CartProvider>();
    final homeProvider = context.watch<HomescreenProvider>();

    final selectedRegion = homeProvider.regionSelectionModel
        .where((r) => r.id == homeProvider.selectedRegionId)
        .firstOrNull;

    return Scaffold(
      backgroundColor: ColorsConstants.background,

      appBar: AppBar(
        centerTitle: true,

        title: const Text(
          'Your Courses',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: ColorsConstants.textColor,
            fontSize: 23,
            letterSpacing: -0.5,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: ColorsConstants.background,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Added Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsConstants.textColor,
                ),
              ),

              const SizedBox(height: 20),

              if (cartScreenProvider.isLoading)
                Expanded(
                  child: Center(
                    child: SpinKitFadingCircle(color: Colors.blue.shade900),
                  ),
                )
              else if (cartScreenProvider.errorMessage != null)
                Expanded(
                  child: Center(
                    child: Text(
                      cartScreenProvider.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else if (cartScreenProvider.cartModel == null)
                const Expanded(
                  child: Center(child: Text('No cart data available')),
                )
              else if (cartScreenProvider.cartModel!.items.isEmpty)
                const Expanded(child: Center(child: Text('Your cart is empty')))
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: cartScreenProvider.cartModel!.items.length,
                      itemBuilder: (context, index) {
                        final item = cartScreenProvider.cartModel!.items[index];

                        return CartScreenWidget(
                          cartItemModel: item,
                          number: index + 1,
                          regionId: homeProvider.selectedRegionId ?? 3,
                          regionSelectionModel: selectedRegion,
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    final cart = cartScreenProvider.cartModel!;
                    final courseIds = cart.items
                        .map((e) => e.course.id)
                        .toList();
                    final total =
                        double.tryParse(cart.courseTotal.toString()) ?? 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenPayment(courseIds: courseIds, total: total),
                      ),
                    );
                  },
                  child: Text('Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
