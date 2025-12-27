// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class PlaceCardDetiles extends StatefulWidget {
//   const PlaceCardDetiles({super.key});

//   @override
//   State<PlaceCardDetiles> createState() => _PlaceCardDetilesState();
// }

// class _PlaceCardDetilesState extends State<PlaceCardDetiles> {
//   final List<String> images = [
//     'assets/hotel.jpg',
//     'assets/hotel2.jpeg',
//     'assets/hotel3.jpeg',
//   ];

//   late final PageController _pageController;
//   late Timer _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentPage);

//     // change page every 2 seconds
//     _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (!mounted || images.isEmpty) return;
//       _currentPage = (_currentPage + 1) % images.length;
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 300,
//             width: double.infinity,
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: images.length,
//               onPageChanged: (index) => _currentPage = index,
//               itemBuilder: (context, index) {
//                 return Image.asset(images[index], fit: BoxFit.cover);
//               },
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             height: double.infinity,
//             width: double.infinity,
//             child: Text(
//               'فندق موفنبيك',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tourist_guide/featuers/home/widgets/book_a_hotel_room.dart';

class PlaceCardDetiles extends StatefulWidget {
  // إضافة معامل لنوع المكان (فندق، مطعم، معلم، إلخ)
  final String? placeType;

  const PlaceCardDetiles({super.key, this.placeType});

  @override
  State<PlaceCardDetiles> createState() => _PlaceCardDetilesState();
}

class _PlaceCardDetilesState extends State<PlaceCardDetiles> {
  // بيانات ديناميكية حسب نوع المكان
  late String placeName;
  late String location;
  late String rating;
  late String subtitle;
  late String description;
  late String category;
  late double latitude;
  late double longitude;
  late String checkIn;
  late String checkOut;
  late String cancellationPolicy;
  late List<String> images;
  late List<Map<String, dynamic>> facilities;

  late final PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();
    _initializePlaceData();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || images.isEmpty) return;
      _currentPage = (_currentPage + 1) % images.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // تهيئة بيانات المكان حسب النوع
  void _initializePlaceData() {
    final type = widget.placeType ?? 'الفنادق';
    
    if (_isPlaceType(['المطاعم', 'مطعم', 'restaurant'], type)) {
      // بيانات المطعم
      placeName = 'مطعم ريماس';
      location = 'صنعاء';
      rating = '4.7';
      subtitle = 'مطعم ريماس - صنعاء';
      description =
          'مطعم ريماس من أفضل المطاعم في صنعاء، يقدم أشهى المأكولات اليمنية التقليدية والعالمية. يتميز بجو عائلي راقي وخدمة ممتازة. نقدم أطباق متنوعة من المشويات والمندي والحنيذ والكبسة، بالإضافة إلى المقبلات والسلطات الطازجة. جميع أطباقنا محضرة بأجود المكونات.';
      category = 'المطاعم';
      latitude = 15.3694;
      longitude = 44.1910;
      checkIn = '';
      checkOut = '';
      cancellationPolicy = '';
      
      images = [
        'assets/hotel.jpg', // يمكن استبدالها بصور مطاعم
        'assets/hotel2.jpeg',
        'assets/hotel3.jpeg',
      ];
      
      facilities = [
        {'icon': Icons.restaurant_menu, 'name': 'قائمة متنوعة'},
        {'icon': Icons.local_parking, 'name': 'مواقف'},
        {'icon': Icons.wifi, 'name': 'واي فاي'},
        {'icon': Icons.family_restroom, 'name': 'عائلي'},
        {'icon': Icons.delivery_dining, 'name': 'توصيل'},
        {'icon': Icons.credit_card, 'name': 'بطاقات'},
        {'icon': Icons.smoke_free, 'name': 'منطقة غير مدخنين'},
        {'icon': Icons.ac_unit, 'name': 'مكيف'},
      ];
    } else {
      // بيانات الفندق (الافتراضي)
      placeName = 'فندق المسار العزيزية';
      location = 'Makkah';
      rating = '9.5';
      subtitle = 'فندق المسار العزيزية - مكة المكرمة';
      description =
          'يقع فندق المسار العزيزية المصنف نجمة واحدة في منطقة العزيزية الجنوبية بمكة المكرمة، ويبعد مسافة 8 كم عن الحرم المكي الشريف. يوفر الفندق غرف مكيفة مع خدمة الواي فاي المجانية وخدمة الغرف على مدار الساعة.';
      category = 'الفنادق';
      latitude = 21.4225;
      longitude = 39.8262;
      checkIn = '16.00 - 20.00';
      checkOut = '12.00 - 14.00';
      cancellationPolicy =
          'الحجوزات غير مستردة وغير قابلة للإلغاء وغير قابلة للتعديل.';
      
      images = [
        'assets/hotel.jpg',
        'assets/hotel2.jpeg',
        'assets/hotel3.jpeg',
      ];
      
      facilities = [
        {'icon': Icons.wifi, 'name': 'واي فاي'},
        {'icon': Icons.local_parking, 'name': 'مواقف'},
        {'icon': Icons.pool, 'name': 'مسبح'},
        {'icon': Icons.restaurant, 'name': 'مطعم'},
        {'icon': Icons.fitness_center, 'name': 'جيم'},
        {'icon': Icons.spa, 'name': 'سبا'},
        {'icon': Icons.room_service, 'name': 'خدمة غرف'},
        {'icon': Icons.coffee, 'name': 'كافيه'},
      ];
    }
  }

  // التحقق من نوع المكان بشكل مرن
  bool _isPlaceType(List<String> types, String placeType) {
    final lowerType = placeType.toLowerCase();
    for (var type in types) {
      if (lowerType.contains(type.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // المحتوى الرئيسي
          SingleChildScrollView(
            child: Column(
              children: [
                // معرض الصور
                _buildImageGallery(),

                // محتوى التفاصيل
                _buildDetailsContent(),
              ],
            ),
          ),

          // زر الرجوع
          Positioned(top: 50, left: 16, child: _buildBackButton()),
        ],
      ),

      // زر الحجز كـ FloatingActionButton (يظهر فقط للفنادق)
      floatingActionButton: _isHotel() ? _buildFloatingBookingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // التحقق إذا كان المكان فندق
  bool _isHotel() {
    final type = widget.placeType ?? category;
    return type == 'الفنادق' ||
        type == 'فندق' ||
        type.toLowerCase().contains('hotel');
  }

  // معرض الصور مع المؤشرات
  Widget _buildImageGallery() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Image.asset(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  final theme = Theme.of(context);
                  return Container(
                    color: theme.cardColor,
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.4),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // مؤشرات الصور
        Positioned(
          bottom: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // زر الرجوع
  Widget _buildBackButton() {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  // محتوى التفاصيل
  Widget _buildDetailsContent() {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // العنوان والموقع والتقييم
            _buildHeader(),

            const SizedBox(height: 20),

            // العنوان الفرعي والوصف
            _buildDescription(),

            const SizedBox(height: 24),

            // قسم المرافق
            _buildFacilities(),

            const SizedBox(height: 32),

            // قسم الخريطة - جديد
            _buildMapSection(),

            // المعلومات الإضافية - يظهر فقط للفنادق
            if (_isHotel()) ...[
              const SizedBox(height: 32),
              _buildAdditionalInfo(),
            ],

            const SizedBox(height: 100), // مساحة للـ FAB
          ],
        ),
      ),
    );
  }

  // العنوان والموقع والتقييم
  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // العنوان
        Text(
          placeName,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 12),

        // الموقع والتقييم
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // التقييم
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    rating,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'ممتاز',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            // الموقع
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: theme.textTheme.bodySmall?.color,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // العنوان الفرعي والوصف
  Widget _buildDescription() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // العنوان الفرعي
        Text(
          subtitle,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 16,
            color: theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        // الوصف
        Text(
          _showFullDescription
              ? description
              : description.length > 100
              ? '${description.substring(0, 100)}...'
              : description,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            color: theme.textTheme.bodySmall?.color,
            height: 1.5,
          ),
        ),

        // زر عرض المزيد
        if (description.length > 100)
          TextButton(
            onPressed: () {
              setState(() {
                _showFullDescription = !_showFullDescription;
              });
            },
            child: Text(
              _showFullDescription ? 'عرض أقل' : 'عرض المزيد',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  // قسم المرافق
  Widget _buildFacilities() {
    final theme = Theme.of(context);
    final facilitiesTitle = _isHotel() ? 'مرافق نوفرها لكم' : 'خدماتنا ومميزاتنا';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان القسم
        Text(
          facilitiesTitle,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 16),

        // شبكة المرافق
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85, // تقليل النسبة لإعطاء مساحة أكبر عمودياً
          ),
          itemCount: facilities.length,
          itemBuilder: (context, index) {
            final facility = facilities[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      facility['icon'],
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    facility['name'],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // قسم الخريطة - جديد
  Widget _buildMapSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان القسم
        Text(
          'على الخريطة',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 16),

        // الخريطة (قابلة للضغط)
        InkWell(
          onTap: _openGoogleMaps,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // استخدام Google Maps Static API لعرض الخريطة
                  Image.network(
                    'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&markers=color:red%7C$latitude,$longitude&key=YOUR_API_KEY',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // في حالة عدم وجود API key أو خطأ، اعرض placeholder
                      return Container(
                        color: theme.cardColor,
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map,
                                    size: 60,
                                    color: theme.textTheme.bodySmall?.color
                                        ?.withOpacity(0.4),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'اضغط لفتح الموقع على الخريطة',
                                    style: TextStyle(
                                      color: theme.textTheme.bodySmall?.color
                                          ?.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: theme.colorScheme.primary,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Makkah',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: theme.cardColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),

                  // أيقونة للإشارة أن الخريطة قابلة للضغط
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'فتح الخريطة',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // المعلومات الإضافية - جديد
  Widget _buildAdditionalInfo() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // عنوان القسم
        Text(
          'معلومات اضافية',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 16),

        // Check-in
        _buildInfoRow(title: 'Check-in', value: checkIn),

        const SizedBox(height: 12),

        // Check-out
        _buildInfoRow(title: 'Check-out', value: checkOut),

        const SizedBox(height: 16),
        // Cancellation/prepayment
        _buildInfoRow(
          title: 'Cancellation/prepayment',
          value: cancellationPolicy,
          isMultiline: true,
        ),
      ],
    );
  }

  // صف معلومة واحدة
  Widget _buildInfoRow({
    required String title,
    required String value,
    Color? titleColor,
    bool isMultiline = false,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: titleColor ?? theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            color: theme.textTheme.bodySmall?.color,
            height: isMultiline ? 1.5 : 1,
          ),
        ),
      ],
    );
  }

  // فتح Google Maps
  Future<void> _openGoogleMaps() async {
    // رابط Google Maps مع الإحداثيات
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // رابط بديل لتطبيق Google Maps (للهواتف)
    final String googleMapsAppUrl =
        'geo:$latitude,$longitude?q=$latitude,$longitude($placeName)';

    try {
      // محاولة فتح تطبيق الخرائط أولاً
      final Uri uri = Uri.parse(googleMapsAppUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // إذا لم ينجح، افتح الرابط في المتصفح
        final Uri webUri = Uri.parse(googleMapsUrl);
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // في حالة الخطأ، اعرض رسالة
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لا يمكن فتح الخريطة'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // زر الحجز كـ FloatingActionButton (للفنادق فقط)
  Widget _buildFloatingBookingButton() {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FloatingActionButton.extended(
          onPressed: () {
            // الانتقال لصفحة الحجز
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BookingScreen()),
            );
          },
          backgroundColor: primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: const Icon(Icons.calendar_today, color: Colors.white),
          label: const Text(
            'احجز الآن',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
