import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().getCartItems(regionId: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartScreenProvider = context.watch<CartProvider>();

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

      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
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
              const Expanded(child: Center(child: CircularProgressIndicator()))
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
                child: ListView.builder(
                  itemCount: cartScreenProvider.cartModel!.items.length,
                  itemBuilder: (context, index) {
                    final item = cartScreenProvider.cartModel!.items[index];

                    return ListTile(
                      title: Text(item.course.name),
                      subtitle: Text(item.mrp.toString()),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
