import 'package:flutter/material.dart';
import 'package:tourist_guide/featuers/home/widgets/place_card_detiles.dart';
import 'package:tourist_guide/featuers/home/pages/governorate_places_page.dart';
import 'package:tourist_guide/featuers/home/widgets/book_a_hotel_room.dart';
import 'package:tourist_guide/featuers/home/pages/notofication_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // المحافظات اليمنية مرتبة حسب الأكثر زيارة
  final List<Map<String, dynamic>> governorates = [
    {
      'name': 'صنعاء',
      'icon': '🏛️',
      'color': const Color(0xFF2196F3), // أزرق
      'visitors': '2.5M',
    },
    {
      'name': 'عدن',
      'icon': '🌊',
      'color': const Color(0xFF00BCD4), // سماوي
      'visitors': '1.8M',
    },
    {
      'name': 'الحديدة',
      'icon': '🏖️',
      'color': const Color(0xFF009688), // أخضر مائي
      'visitors': '1.5M',
    },
    {
      'name': 'تعز',
      'icon': '⛰️',
      'color': const Color(0xFF4CAF50), // أخضر
      'visitors': '1.3M',
    },
    {
      'name': 'حضرموت',
      'icon': '🏜️',
      'color': const Color(0xFFFF9800), // برتقالي
      'visitors': '1.1M',
    },
    {
      'name': 'إب',
      'icon': '🌄',
      'color': const Color(0xFF8BC34A), // أخضر فاتح
      'visitors': '900K',
    },
  ];

  // بيانات مختلطة لجميع المنشآت
  final List<Map<String, String>> places = const [
    {
      'title': 'موفمبيك',
      'subtitle': 'صنعاء',
      'footer': 'اجنحة فاخرة',
      'avatar': 'M',
      'category': 'الفنادق',
      'rating': '4.6',
      'price': '450 ر.س / الليلة',
    },
    {
      'title': 'ايجل',
      'subtitle': 'صنعاء',
      'footer': 'موقع مركزي',
      'avatar': 'E',
      'category': 'الفنادق',
      'rating': '4.2',
      'price': '320 ر.س / الليلة',
    },
    {
      'title': 'ريماس',
      'subtitle': 'صنعاء',
      'footer': 'أكلات شعبية وفاخرة',
      'avatar': 'R',
      'category': 'المطاعم',
      'rating': '4.4',
      'cuisine': 'عربي، بحري',
      'priceRange': 'متوسط',
    },
    {
      'title': 'المتحف الوطني',
      'subtitle': 'صنعاء القديمة',
      'footer': 'متحف وتاريخ محلي',
      'avatar': 'م',
      'category': 'التعليمية',
      'hours': '9:00 - 17:00',
      'type': 'متحف',
    },
    {
      'title': 'شاطئ الغدير',
      'subtitle': 'عدن',
      'footer': 'شاطئ عائلي رائع',
      'avatar': 'ش',
      'category': 'المنتزهات',
      'rating': '4.5',
    },
    {
      'title': 'قلعة القاهرة',
      'subtitle': 'تعز',
      'footer': 'معلم تاريخي قديم',
      'avatar': 'ق',
      'category': 'المعالم',
      'rating': '4.8',
    },
    {
      'title': 'كورنيش الحديدة',
      'subtitle': 'الحديدة',
      'footer': 'منتزه بحري',
      'avatar': 'ك',
      'category': 'المنتزهات',
      'rating': '4.3',
    },
    {
      'title': 'مطعم البحر الأحمر',
      'subtitle': 'الحديدة',
      'footer': 'مأكولات بحرية طازجة',
      'avatar': 'ب',
      'category': 'المطاعم',
      'rating': '4.5',
    },
    {
      'title': 'شبام حضرموت',
      'subtitle': 'حضرموت',
      'footer': 'مدينة الناطحات الطينية',
      'avatar': 'ش',
      'category': 'المعالم',
      'rating': '4.9',
    },
  ];

  // دالة إعادة التحميل
  Future<void> _handleRefresh() async {
    // محاكاة تحميل البيانات من API
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم تحديث البيانات بنجاح'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // فتح صفحة البحث
  void _openSearch() {
    showSearch(
      context: context,
      delegate: PlaceSearchDelegate(places: places),
    );
  }

  // فتح صفحة الإشعارات
  void _openNotifications() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const NotificationsPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: theme.appBarTheme.elevation,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: theme.appBarTheme.iconTheme?.color,
            size: 28,
          ),
          onPressed: _openNotifications,
          tooltip: 'الإشعارات',
        ),
        title: Text("دليلك السياحي", style: theme.appBarTheme.titleTextStyle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: theme.appBarTheme.iconTheme?.color,
              size: 28,
            ),
            onPressed: _openSearch,
            tooltip: 'البحث',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: theme.colorScheme.primary,
        backgroundColor: theme.cardColor,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildGovernorates()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverPadding(
              padding: const EdgeInsets.all(12.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index.isOdd) {
                    return const SizedBox(height: 12);
                  }
                  final placeIndex = index ~/ 2;
                  return _buildPlaceCardFromMap(places[placeIndex]);
                }, childCount: places.length * 2 - 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGovernorates() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المحافظات الأكثر زيارة',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.trending_up,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: governorates.length,
              itemBuilder: (context, index) {
                final gov = governorates[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GovernoratePlacesPage(
                            governorateName: gov['name'],
                            governorateColor: gov['color'],
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  gov['color'],
                                  gov['color'].withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gov['color'].withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                gov['icon'],
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            gov['name'],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            gov['visitors'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceCardFromMap(Map<String, String> place) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      color: theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: theme.dividerColor,
            child: Center(
              child: Text(
                place['avatar']!,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: theme.hintColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        place['title']!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    if (place['rating'] != null)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            place['rating']!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.textTheme.bodySmall?.color,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        place['subtitle']!,
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  place['footer']!,
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    place['category'] ?? '',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PlaceCardDetiles(placeType: place['category']),
                      ),
                    );
                  },
                  child: Text(
                    'عرض التفاصيل',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (place['category'] == 'الفنادق')
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BookingScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'احجز',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// SearchDelegate للبحث
class PlaceSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> places;

  PlaceSearchDelegate({required this.places});

  @override
  String get searchFieldLabel => 'ابحث عن مكان...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.iconTheme?.color,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.hintColor),
        border: InputBorder.none,
      ),
      textTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
          tooltip: 'مسح',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
      tooltip: 'رجوع',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final theme = Theme.of(context);

    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: theme.hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'ابحث عن فنادق، مطاعم، أو معالم',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final results = places.where((place) {
      final titleLower = place['title']!.toLowerCase();
      final subtitleLower = place['subtitle']!.toLowerCase();
      final categoryLower = place['category']!.toLowerCase();
      final footerLower = place['footer']!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          subtitleLower.contains(searchLower) ||
          categoryLower.contains(searchLower) ||
          footerLower.contains(searchLower);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: theme.hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد نتائج لـ "$query"',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final place = results[index];
        return _buildSearchResultCard(context, place, theme);
      },
    );
  }

  Widget _buildSearchResultCard(
    BuildContext context,
    Map<String, String> place,
    ThemeData theme,
  ) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      color: theme.cardColor,
      child: InkWell(
        onTap: () {
          close(context, place['title']!);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  PlaceCardDetiles(placeType: place['category']),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: theme.dividerColor,
              child: Center(
                child: Text(
                  place['avatar']!,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: theme.hintColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          place['title']!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      if (place['rating'] != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              place['rating']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: theme.textTheme.bodySmall?.color,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place['subtitle']!,
                          style: TextStyle(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    place['footer']!,
                    style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      place['category'] ?? '',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
