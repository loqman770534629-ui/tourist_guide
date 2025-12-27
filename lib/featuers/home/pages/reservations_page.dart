import 'package:flutter/material.dart';
import 'package:tourist_guide/core/constants.dart';
import 'package:tourist_guide/featuers/home/widgets/book_a_hotel_room.dart';
import 'package:tourist_guide/featuers/home/widgets/place_card_detiles.dart';

// اللون الأساسي الذي تستخدمه في تطبيقك

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم DefaultTabController لربط الـ Tabs بالمحتوى
    return DefaultTabController(
      length: 3, // عدد التبويبات: السارية، السابقة، الملغية
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          title: Text(
            'حجوزاتي',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 2,
          // 1. شريط التبويبات المدمج
          bottom: TabBar(
            tabs: [
              Tab(text: 'السارية'),
              Tab(text: 'السابقة'),
              Tab(text: 'الملغية'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
          ),
        ),
        body: TabBarView(
          children: [
            // المحتوى 1: الحجوزات السارية
            buildReservationsList(ReservationStatus.active),

            // المحتوى 2: الحجوزات السابقة
            // سنعرض هنا "حالة عدم وجود بيانات" كمثال
            buildEmptyState(
              icon: Icons.check_circle_outline,
              message: 'لا توجد حجوزات سابقة',
              details: 'ستظهر حجوزاتك المكتملة هنا.',
            ),

            // المحتوى 3: الحجوزات الملغية
            buildEmptyState(
              icon: Icons.cancel_outlined,
              message: 'لا توجد حجوزات ملغية',
              details: 'ستظهر حجوزاتك التي تم إلغاؤها هنا.',
            ),
          ],
        ),
      ),
    );
  }

  // 2. بناء قائمة الحجوزات (البيانات الوهمية)
  Widget buildReservationsList(ReservationStatus status) {
    // في تطبيق حقيقي، هذه البيانات ستأتي من قاعدة البيانات
    final List<Map<String, String>> dummyData = [
      {
        "title": "فندق هيلتون جاردن إن",
        "location": "دبي، الإمارات العربية المتحدة",
        "dates": "15 نوفمبر - 20 نوفمبر (5 ليالي)",
        "status": "مؤكد",
        "imageUrl":
            "https://images.unsplash.com/photo-1566073771259-6a8506099945?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzU4MDN8MHwxfGFsbHx8fHx8fHx8fDE2NjgyNzgxMDI&ixlib=rb-4.0.3&q=80&w=400",
      },
      {
        "title": "جولة الأهرامات وأبو الهول",
        "location": "القاهرة، مصر",
        "dates": "17 نوفمبر (جولة يوم واحد)",
        "status": "مؤكد",
        "imageUrl":
            "https://images.unsplash.com/photo-1569091791842-8d76f10c6054?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzU4MDN8MHwxfGFsbHx8fHx8fHx8fDE2NjgyNzgxMDI&ixlib=rb-4.0.3&q=80&w=400",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dummyData.length,
      itemBuilder: (context, index) {
        final item = dummyData[index];
        return _buildReservationCard(
          context: context,
          title: item['title']!,
          location: item['location']!,
          dates: item['dates']!,
          status: item['status']!,
          imageUrl: item['imageUrl']!,
        );
      },
    );
  }

  // 3. تصميم بطاقة الحجز (العنصر الأهم)
  Widget _buildReservationCard({
    required BuildContext context,
    required String title,
    required String location,
    required String dates,
    required String status,
    required String imageUrl,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias, // لقص الصورة مع حواف الكارد
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. صورة الحجز
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            // في حال حدوث خطأ في تحميل الصورة
            imageErrorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              color: Colors.grey[200],
              child: Icon(
                Icons.broken_image,
                color: Colors.grey[400],
                size: 50,
              ),
            ),
          ),

          // 2. تفاصيل الحجز
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3. العنوان والموقع
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // 4. التاريخ
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      dates,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // 5. الحالة (مؤكد، ملغي...)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors
                        .green
                        .shade100, // لون مختلف حسب الحالة (أخضر لمؤكد)
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 6. شريط الأزرار (الإجراءات)
          Divider(height: 1, thickness: 1, color: Colors.grey[200]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceCardDetiles(),
                      ),
                    );
                  },
                  child: Text(
                    'عرض التفاصيل',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'إلغاء الحجز',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. تصميم حالة "لا توجد بيانات"
  Widget buildEmptyState({
    required IconData icon,
    required String message,
    required String details,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              details,
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: Text(
                'تصفح الأماكن الآن',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// يمكن استخدام هذا لتنظيم الكود
enum ReservationStatus { active, past, cancelled }

// import 'package:flutter/material.dart';

// // --- بيانات المكان (Model Data) ---
// class PlaceDetails {
//   final String title = "فندق موفامبيك";
//   final String location = "أبها، السعودية";
//   final String price = "450 ريال / الليلة";
//   final String description =
//       "يقع الفندق في موقع مميز ويوفر إطلالات جميلة وخدمات عالية الجودة. يتميز بمرافق متكاملة تشمل مطعمًا فاخرًا، ومركزًا للياقة البدنية، ومسابح داخلية وخارجية، مما يجعله وجهة مثالية للعائلات والمسافرين بغرض العمل.";
//   final double rating = 4.0;
//   // بيانات وهمية للإحصائيات
//   final int totalRooms = 45;
//   final int restaurants = 3;
//   final String nearBeach = '500 م';
// }

// class PlaceCardDetiles extends StatelessWidget {
//   PlaceCardDetiles({super.key});

//   final PlaceDetails details = PlaceDetails();

//   // --- دوال المساعدة ---

//   // 1. دالة لبناء نجوم التقييم
//   Widget _buildRatingStars(double rating) {
//     return Row(
//       children: List.generate(5, (index) {
//         if (rating >= index + 1) {
//           return const Icon(Icons.star, color: Colors.amber, size: 28);
//         } else if (rating > index) {
//           return const Icon(Icons.star_half, color: Colors.amber, size: 28);
//         } else {
//           return Icon(Icons.star_border, color: Colors.grey[400], size: 28);
//         }
//       }),
//     );
//   }

//   // 2. دالة لبناء بطاقة إحصائية
//   Widget _buildStatCard(
//     String value,
//     String label,
//     IconData icon,
//     Color color,
//   ) {
//     return Container(
//       width: 100, // حجم ثابت للبطاقة
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: color.withOpacity(0.3), width: 1),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 28),
//           const SizedBox(height: 5),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             label,
//             style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- الـ Widget الرئيسي ---
//   @override
//   Widget build(BuildContext context) {
//     // يجب لف التطبيق بـ Directionality في main.dart، لكن نضعه هنا للتأكد
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         body: Stack(
//           children: [
//             // HEADER IMAGE (مع زر الرجوع والمفضلة)
//             SizedBox(
//               height: 280,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Image.asset(
//                       "assets/splash_image.png", // يجب تغيير هذا إلى مسار صورتك
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.black54, Colors.transparent],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 50,
//                     left: 16,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 20,
//                     right: 20,
//                     child: Text(
//                       details.title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   // زر المفضلة (إضافة عصرية)
//                   Positioned(
//                     top: 50,
//                     right: 16,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.favorite_border),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // CONTENT (المحتوى القابل للتمرير)
//             Padding(
//               padding: const EdgeInsets.only(top: 240),
//               child: Container(
//                 padding: const EdgeInsets.only(
//                   left: 20,
//                   right: 20,
//                   top: 20,
//                   bottom: 0,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // الموقع
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on, color: Colors.blue),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               details.location,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // السعر والتقييم في سطرين منفصلين (أفضل للتنظيم)
//                       Text(
//                         details.price,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF007BFF), // لون أزرق موحد
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // التقييم
//                       _buildRatingStars(details.rating),

//                       const SizedBox(height: 25),

//                       // الوصف (التفاصيل)
//                       const Text(
//                         "التفاصيل",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         details.description,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           height: 1.6,
//                           color: Colors.black87,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                       const SizedBox(height: 30),

//                       // **********************************
//                       // ⭐️ القسم الجديد: الموقع والإحصائيات
//                       // **********************************

//                       // 📍 بطاقة الموقع التفاعلية (Map Tile)
//                       const Text(
//                         "الموقع على الخريطة",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                       const SizedBox(height: 15),
//                       Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             // منطق فتح تطبيق الخرائط
//                             print("Open map for ${details.location}");
//                           },
//                           borderRadius: BorderRadius.circular(15),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 // صورة مكان وهمية للخريطة
//                                 Image.asset(
//                                   "assets/map_placeholder.png", // يمكنك إضافة صورة خريطة وهمية لهذا المسار
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                 ),
//                                 // أيقونة مركزية
//                                 const Icon(
//                                   Icons.pin_drop,
//                                   color: Colors.red,
//                                   size: 45,
//                                 ),
//                                 Positioned(
//                                   bottom: 10,
//                                   right: 10,
//                                   child: Text(
//                                     "عرض الاتجاهات",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       backgroundColor: Colors.black.withOpacity(
//                                         0.5,
//                                       ),
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),

//                       // 📊 إحصائيات المكان البارزة
//                       const Text(
//                         "أبرز الأرقام والمزايا",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                       const SizedBox(height: 15),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStatCard(
//                             details.totalRooms.toString(),
//                             "غرفة",
//                             Icons.bed_outlined,
//                             Colors.blue.shade700,
//                           ),
//                           _buildStatCard(
//                             details.restaurants.toString(),
//                             "مطعم/مقهى",
//                             Icons.restaurant_menu,
//                             Colors.green.shade700,
//                           ),
//                           _buildStatCard(
//                             details.nearBeach,
//                             "قرب الشاطئ",
//                             Icons.waves,
//                             Colors.purple.shade700,
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 120), // مساحة للزر السفلي
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),

//         // BOOKING BUTTON (ثابت في الأسفل)
//         bottomNavigationBar: Container(
//           height: 90, // زيادة الارتفاع لتبدو أكثر عصرية
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -5),
//               ),
//             ],
//           ),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18), // حواف أكثر استدارة
//               ),
//               elevation: 5,
//             ),
//             onPressed: () {},
//             child: const Text(
//               "حجز الآن",
//               style: TextStyle(
//                 fontSize: 22,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // *************** يمكنك تشغيل هذا الكود للتجربة ***************
// // يجب إضافة هذه الجزئية لتشغيل الـ Widget في تطبيق Flutter كامل
// /*
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PlaceCardDetiles(),
//     );
//   }
// }
// */
