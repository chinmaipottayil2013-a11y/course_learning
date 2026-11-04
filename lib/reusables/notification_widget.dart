import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';

import 'package:learning_course2/models/notifciations/notification_model.dart';
import 'package:learning_course2/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.tryParse(notificationModel.createdDate);
    final formatteddate = dateTime != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(dateTime.toLocal())
        : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Consumer<NotificationProvider>(
        builder: (context, providerNotification, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    notificationModel.title,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await context.read<NotificationProvider>().deleteNot(
                      notification: notificationModel,
                    );
                  },
                  child: Icon(Icons.close, size: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              notificationModel.description,
              overflow: providerNotification.isExpanded(notificationModel.id)
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              maxLines: providerNotification.isExpanded(notificationModel.id)
                  ? null
                  : 2,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.60),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () =>
                  providerNotification.toggleMore(notificationModel.id),
              child: Text(
                providerNotification.isExpanded(notificationModel.id)
                    ? 'Read less'
                    : 'Read more',
                style: TextStyle(
                  fontSize: 11,
                  color: ColorsConstants.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              formatteddate,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
