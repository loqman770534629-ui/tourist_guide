import 'package:flutter/material.dart';

// اللون الأساسي الذي تستخدمه
const Color primaryColor = Color(0xFF0098DB);

// كلاس وهمي لتمثيل بيانات الإشعار
// في التطبيق الحقيقي، هذا سيأتي من قاعدة البيانات
class AppNotification {
  final String id;
  final String title;
  final String body;
  final String time;
  final NotificationType type;
  bool isRead;
  final String? imageUrl; // للعروض

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.isRead = false,
    this.imageUrl,
  });
}

enum NotificationType { alert, offer, general }

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- بيانات وهمية لتجربة التصميم ---
  final List<AppNotification> _notifications = [
    AppNotification(
      id: '1',
      title: 'تم تأكيد حجزك!',
      body: 'فندق هيلتون جاردن إن، من 15 إلى 20 نوفمبر.',
      time: 'منذ 5 دقائق',
      type: NotificationType.alert,
      isRead: false, // غير مقروء
    ),
    AppNotification(
      id: '2',
      title: 'عرض حصري لك!',
      body: 'خصم 30% على جميع الجولات السياحية في باريس.',
      time: 'منذ 1 ساعة',
      type: NotificationType.offer,
      isRead: false, // غير مقروء
      imageUrl:
          'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400',
    ),
    AppNotification(
      id: '3',
      title: 'تذكير بتسجيل الوصول',
      body: 'رحلتك إلى دبي غداً. لا تنسى تسجيل الوصول.',
      time: 'منذ 3 ساعات',
      type: NotificationType.alert,
      isRead: true, // مقروء
    ),
    AppNotification(
      id: '4',
      title: 'مرحباً بك في التطبيق!',
      body: 'نحن سعداء بانضمامك. استكشف أفضل الأماكن السياحية.',
      time: 'منذ 1 يوم',
      type: NotificationType.general,
      isRead: true, // مقروء
    ),
  ];
  // ---------------------------------

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void markAsRead(String id) {
    setState(() {
      final notification = _notifications.firstWhere(
        (n) => n.id == id,
        orElse: () {
          return _notifications.first;
        },
      );
      notification.isRead = true;
    });
  }

  List<AppNotification> _getNotificationsForType(NotificationType type) {
    return _notifications.where((n) => n.type == type).toList();
  }

  List<AppNotification> _getAllNotifications() {
    return _notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإشعارات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          // زر لمسح الكل أو تحديد الكل كمقروء
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n.isRead = true;
                }
              });
            },
            child: Text(
              'تحديد الكل كمقروء',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
        // --- 1. شريط التبويبات (Tabs) ---
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'الكل'),
            Tab(text: 'تنبيهات'),
            Tab(text: 'عروض'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // المحتوى 1: الكل
          buildNotificationsList(_getAllNotifications()),

          // المحتوى 2: تنبيهات (حجوزات + عام)
          buildNotificationsList([
            ..._getNotificationsForType(NotificationType.alert),
            ..._getNotificationsForType(NotificationType.general),
          ]),

          // المحتوى 3: عروض
          buildNotificationsList(
            _getNotificationsForType(NotificationType.offer),
          ),
        ],
      ),
    );
  }

  // --- ودجت بناء قائمة الإشعارات ---
  Widget buildNotificationsList(List<AppNotification> notifications) {
    if (notifications.isEmpty) {
      // --- 5. حالة القائمة الفارغة ---
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        // اختيار التصميم بناءً على نوع الإشعار
        if (notification.type == NotificationType.offer) {
          return buildOfferCard(notification);
        } else {
          return _buildAlertCard(notification);
        }
      },
    );
  }

  // --- 2. تصميم بطاقة الإشعار (للتنبيهات) ---
  Widget _buildAlertCard(AppNotification notification) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.7);
    final primaryColor = theme.colorScheme.primary;
    
    // تحديد الأيقونة واللون بناءً على النوع
    IconData icon;
    Color iconColor;
    switch (notification.type) {
      case NotificationType.alert:
        icon = Icons.hotel; // أو Icons.airplane_ticket
        iconColor = primaryColor;
        break;
      default:
        icon = Icons.campaign;
        iconColor = Colors.orange;
    }

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      // --- 3. تمييز غير المقروء ---
      color: notification.isRead 
          ? theme.cardColor 
          : primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          markAsRead(notification.id);
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // 1. الأيقونة
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.15),
                radius: 24,
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              // 2. المحتوى
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: TextStyle(fontSize: 14, color: hintColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.time,
                      style: TextStyle(fontSize: 12, color: hintColor.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // 3. سهم (لبيان إمكانية الضغط)
              Icon(Icons.arrow_forward_ios, size: 16, color: hintColor),
            ],
          ),
        ),
      ),
    );
  }

  // --- 2. تصميم بطاقة الإشعار (للعروض) ---
  Widget buildOfferCard(AppNotification notification) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.7);
    final primaryColor = theme.colorScheme.primary;
    
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      color: notification.isRead 
          ? theme.cardColor 
          : primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          markAsRead(notification.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.imageUrl != null)
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: notification.imageUrl!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Container(height: 150, color: theme.cardColor),
              ),
            // 2. المحتوى
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: TextStyle(fontSize: 15, color: textColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.time,
                    style: TextStyle(fontSize: 12, color: hintColor),
                  ),
                ],
              ),
            ),
            // 3. زر الإجراء
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: ElevatedButton(
                onPressed: () {
                  markAsRead(notification.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'عرض التفاصيل',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 4. ودجت حالة "لا توجد بيانات" ---
  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.5);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 100,
              color: hintColor,
            ),
            const SizedBox(height: 24),
            Text(
              'لا توجد إشعارات',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ستظهر إشعاراتك الجديدة هنا.',
              style: TextStyle(fontSize: 16, color: hintColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
