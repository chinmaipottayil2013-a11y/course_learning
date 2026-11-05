import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/notification_provider.dart';
import 'package:learning_course2/reusables/notification_widget.dart';
import 'package:provider/provider.dart';

class ScreenNotifcations extends StatefulWidget {
  const ScreenNotifcations({super.key});

  @override
  State<ScreenNotifcations> createState() => _ScreenNotifcationsState();
}

class _ScreenNotifcationsState extends State<ScreenNotifcations> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().getNotifications();
    });
  }

  void onScroll() {
    if (_controller.hasClients) return;

    final notificationProvider = context.read<NotificationProvider>();
    if (notificationProvider.isLoading || notificationProvider.isLoadingMore) {
      return;
    }

    if (_controller.position.extentAfter < 200) {
      context.read<NotificationProvider>().loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 8),
                Consumer<NotificationProvider>(
                  builder: (context, value, child) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorsConstants.containerColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${value.unread}',
                      style: TextStyle(
                        fontSize: 10,
                        color: ColorsConstants.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorsConstants.containerColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Mark as read',
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorsConstants.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorsConstants.containerColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () =>
                        context.read<NotificationProvider>().deleteAll(),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: ColorsConstants.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: Consumer<NotificationProvider>(
                builder: (context, notificationProvider, child) {
                  if (notificationProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (notificationProvider.errorMessage != null) {
                    return Center(
                      child: Text(notificationProvider.errorMessage!),
                    );
                  }
                  if (notificationProvider.notificationsList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsConstants.containerColor,
                            ),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: ColorsConstants.primary,
                              size: 25,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'No Notifications',
                            style: TextStyle(
                              color: ColorsConstants.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'You\'re completely upto date!',
                            style: TextStyle(
                              color: ColorsConstants.secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        notificationProvider.notificationsList.length +
                        (notificationProvider.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index ==
                          notificationProvider.notificationsList.length) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      final notifications =
                          notificationProvider.notificationsList[index];
                      return NotificationWidget(
                        notificationModel: notifications,
                      );
                    },
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
