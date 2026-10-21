import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/favourite_screen_provider.dart';
import 'package:provider/provider.dart';

class ScreenFavourite extends StatefulWidget {
  const ScreenFavourite({super.key});

  @override
  State<ScreenFavourite> createState() => _ScreenFavouriteState();
}

class _ScreenFavouriteState extends State<ScreenFavourite> {
  @override
  void initState() {
    super.initState();
    // load favourites after the first frame, when context is safe to use
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteScreenProvider>().showFavourites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = context.watch<FavouriteScreenProvider>();
    final courses = favouriteProvider.courseModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite Courses',
          style: TextStyle(
            color: ColorsConstants.textColor,
            fontSize: 23,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favourites',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsConstants
                    .textColor, // was selectionColor, which only colours highlighted text
              ),
            ),
            const SizedBox(height: 20),

            // 1. loading
            if (favouriteProvider.isLoading)
              Expanded(
                child: Center(
                  child: SpinKitCircle(color: Colors.blue.shade900),
                ),
              )
            // 2. error (errorMessage is a String?, so check != null)
            else if (favouriteProvider.errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(favouriteProvider.errorMessage!),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: favouriteProvider.showFavourites, // retry
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            // 3. empty list
            else if (courses.isEmpty)
              const Expanded(child: Center(child: Text('No favourites yet')))
            // 4. the list
            else
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          course.name,
                        ), // change to your real field name
                      ),
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
