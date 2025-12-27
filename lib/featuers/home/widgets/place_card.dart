import 'package:flutter/material.dart';

class PlaceCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String footerText;
  final String avatarLetter;
  final VoidCallback? onTap;

  const PlaceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.footerText,
    this.avatarLetter = 'A', // حرف افتراضي
    this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  // --- التغيير 2: إضافة متغير "الحالة" لتتبع القلب ---
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // --- (نفس الألوان من الكود الأصلي) ---
    final Color avatarBgColor = Colors.blue.shade100;
    final Color avatarTextColor = Colors.blue.shade800;
    final Color placeholderBgColor = Colors.blue.shade50;
    final Color placeholderIconColor = Colors.blue.shade200;
    final Color borderColor = Colors.grey.shade300;

    return GestureDetector(
      onTap: widget.onTap, // لجعل البطاقة قابلة للضغط
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: borderColor, width: 1.0),
        ),
        elevation: 2.0,
        margin: EdgeInsets.all(4.0),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- الجزء العلوي (العنوان) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  CircleAvatar(
                    backgroundColor: avatarBgColor,
                    radius: 20,
                    child: Text(
                      widget.avatarLetter, // استخدام 'widget.' للوصول للمتغير
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: avatarTextColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title, // استخدام 'widget.'
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.subtitle, // استخدام 'widget.'
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- (جزء الصورة الوهمية - بدون تغيير) ---
            Expanded(
              child: Container(
                color: placeholderBgColor,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: placeholderIconColor,
                    size: 60,
                  ),
                ),
              ),
            ),

            // --- التغيير 3: تعديل الجزء السفلي ليحتوي على (نص + أيقونة) ---
            Padding(
              // قللنا الـ padding العمودي قليلاً ليتناسب مع حجم الأيقونة
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 8.0,
              ),
              child: Row(
                textDirection: TextDirection.rtl, // لترتيب العناصر من اليمين
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // لفصل النص عن الأيقونة
                children: [
                  // 1. النص (نضعه داخل Expanded ليأخذ كل المساحة المتاحة)
                  Expanded(
                    child: Text(
                      widget.footerText, // استخدام 'widget.'
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // مسافة فاصلة
                  // 2. أيقونة القلب القابلة للضغط
                  IconButton(
                    icon: Icon(
                      // تحديد الأيقونة بناءً على الحالة
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      // تحديد اللون بناءً على الحالة
                      color: _isFavorite ? Colors.blue : Colors.grey.shade600,
                      size: 28, // حجم الأيقونة
                    ),
                    onPressed: () {
                      // عند الضغط، قم بتغيير الحالة
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
