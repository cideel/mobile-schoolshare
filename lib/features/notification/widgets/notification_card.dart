import 'package:flutter/material.dart';
import 'package:schoolshare/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.04,
        vertical: screenSize.height * 0.005,
      ),
      constraints: BoxConstraints(
        maxWidth: isTablet ? 600 : double.infinity,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenSize.width * 0.03),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: screenSize.height * 0.01),
                _buildContent(context),
                SizedBox(height: screenSize.height * 0.01),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Row(
      children: [
        Container(
          width: screenSize.width * (isTablet ? 0.06 : 0.1),
          height: screenSize.width * (isTablet ? 0.06 : 0.1),
          decoration: BoxDecoration(
            color: notification.typeColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(screenSize.width * 0.025),
          ),
          child: Icon(
            notification.typeIcon,
            color: notification.typeColor,
            size: screenSize.width * (isTablet ? 0.035 : 0.05),
          ),
        ),
        SizedBox(width: screenSize.width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                  fontSize: isTablet ? 16 : 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenSize.height * 0.002),
              Text(
                notification.formattedTime,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: isTablet ? 13 : 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Text(
      notification.message,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.8),
        height: 1.4,
        fontSize: isTablet ? 15 : 14,
      ),
      maxLines: isTablet ? 4 : 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Row(
      children: [
        if (notification.senderName != null) ...[
          Icon(
            Icons.person_outline,
            size: isTablet ? 18 : 16,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          SizedBox(width: screenSize.width * 0.01),
          Text(
            notification.senderName!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: isTablet ? 13 : 12,
            ),
          ),
        ],
        if (notification.senderName != null && notification.contentTitle != null)
          const Spacer(),
        if (notification.contentTitle != null) ...[
          Icon(
            Icons.description_outlined,
            size: isTablet ? 18 : 16,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          SizedBox(width: screenSize.width * 0.01),
          Expanded(
            child: Text(
              notification.contentTitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontStyle: FontStyle.italic,
                fontSize: isTablet ? 13 : 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
