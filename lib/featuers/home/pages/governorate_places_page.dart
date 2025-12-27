import 'package:flutter/material.dart';
import 'package:tourist_guide/featuers/home/widgets/place_card_detiles.dart';
import 'package:tourist_guide/featuers/home/widgets/book_a_hotel_room.dart';

class GovernoratePlacesPage extends StatefulWidget {
  final String governorateName;
  final Color governorateColor;

  const GovernoratePlacesPage({
    super.key,
    required this.governorateName,
    required this.governorateColor,
  });

  @override
  State<GovernoratePlacesPage> createState() => _GovernoratePlacesPageState();
}

class _GovernoratePlacesPageState extends State<GovernoratePlacesPage> {
  final List<String> categories = [
    'الكل',
    'الفنادق',
    'المطاعم',
    'المعالم',
    'المنتزهات',
    'التعليمية',
  ];
  String selectedCategory = 'الكل';

  // بيانات افتراضية للمنشآت حسب المحافظة
  List<Map<String, String>> _getPlacesForGovernorate() {
    // يمكنك تخصيص البيانات حسب كل محافظة
    final Map<String, List<Map<String, String>>> governoratesData = {
      'صنعاء': [
        {
          'title': 'فندق موفمبيك',
          'subtitle': 'صنعاء',
          'footer': 'أجنحة فاخرة - 5 نجوم',
          'avatar': 'M',
          'category': 'الفنادق',
          'rating': '4.6',
          'price': '450 ر.س / الليلة',
        },
        {
          'title': 'فندق ايجل',
          'subtitle': 'صنعاء - شارع الزبيري',
          'footer': 'موقع مركزي',
          'avatar': 'E',
          'category': 'الفنادق',
          'rating': '4.2',
          'price': '320 ر.س / الليلة',
        },
        {
          'title': 'مطعم ريماس',
          'subtitle': 'صنعاء - شارع حدة',
          'footer': 'أكلات شعبية وفاخرة',
          'avatar': 'R',
          'category': 'المطاعم',
          'rating': '4.4',
          'cuisine': 'عربي، بحري',
        },
        {
          'title': 'المتحف الوطني',
          'subtitle': 'صنعاء القديمة',
          'footer': 'متحف وتاريخ محلي',
          'avatar': 'م',
          'category': 'التعليمية',
          'hours': '9:00 - 17:00',
        },
        {
          'title': 'باب اليمن',
          'subtitle': 'صنعاء القديمة',
          'footer': 'معلم تاريخي',
          'avatar': 'ب',
          'category': 'المعالم',
          'rating': '4.8',
        },
      ],
      'عدن': [
        {
          'title': 'فندق ميركيور',
          'subtitle': 'عدن - كريتر',
          'footer': 'إطلالة بحرية رائعة',
          'avatar': 'M',
          'category': 'الفنادق',
          'rating': '4.5',
          'price': '380 ر.س / الليلة',
        },
        {
          'title': 'شاطئ الغدير',
          'subtitle': 'عدن',
          'footer': 'شاطئ عائلي',
          'avatar': 'ش',
          'category': 'المنتزهات',
          'rating': '4.3',
        },
        {
          'title': 'مطعم السمك الطازج',
          'subtitle': 'عدن - التواهي',
          'footer': 'مأكولات بحرية طازجة',
          'avatar': 'س',
          'category': 'المطاعم',
          'rating': '4.6',
        },
        {
          'title': 'صهاريج عدن',
          'subtitle': 'عدن - كريتر',
          'footer': 'معلم أثري',
          'avatar': 'ص',
          'category': 'المعالم',
          'rating': '4.7',
        },
      ],
      'الحديدة': [
        {
          'title': 'فندق الماسة',
          'subtitle': 'الحديدة',
          'footer': 'قريب من الكورنيش',
          'avatar': 'م',
          'category': 'الفنادق',
          'rating': '4.1',
          'price': '280 ر.س / الليلة',
        },
        {
          'title': 'كورنيش الحديدة',
          'subtitle': 'الحديدة',
          'footer': 'منتزه بحري',
          'avatar': 'ك',
          'category': 'المنتزهات',
          'rating': '4.4',
        },
        {
          'title': 'مطعم البحر الأحمر',
          'subtitle': 'الحديدة - الكورنيش',
          'footer': 'أسماك طازجة',
          'avatar': 'ب',
          'category': 'المطاعم',
          'rating': '4.3',
        },
      ],
      'تعز': [
        {
          'title': 'فندق الجند',
          'subtitle': 'تعز',
          'footer': 'إطلالة جبلية',
          'avatar': 'ج',
          'category': 'الفنادق',
          'rating': '4.0',
          'price': '250 ر.س / الليلة',
        },
        {
          'title': 'قلعة القاهرة',
          'subtitle': 'تعز',
          'footer': 'معلم تاريخي',
          'avatar': 'ق',
          'category': 'المعالم',
          'rating': '4.8',
        },
        {
          'title': 'جبل صبر',
          'subtitle': 'تعز',
          'footer': 'منتزه طبيعي',
          'avatar': 'ج',
          'category': 'المنتزهات',
          'rating': '4.7',
        },
      ],
      'حضرموت': [
        {
          'title': 'فندق المكلا',
          'subtitle': 'المكلا - حضرموت',
          'footer': 'فندق فاخر',
          'avatar': 'م',
          'category': 'الفنادق',
          'rating': '4.4',
          'price': '350 ر.س / الليلة',
        },
        {
          'title': 'شبام',
          'subtitle': 'حضرموت',
          'footer': 'مدينة الناطحات الطينية',
          'avatar': 'ش',
          'category': 'المعالم',
          'rating': '4.9',
        },
        {
          'title': 'وادي حضرموت',
          'subtitle': 'حضرموت',
          'footer': 'منظر طبيعي خلاب',
          'avatar': 'و',
          'category': 'المنتزهات',
          'rating': '4.8',
        },
      ],
      'إب': [
        {
          'title': 'فندق السحاب',
          'subtitle': 'إب',
          'footer': 'جو معتدل',
          'avatar': 'س',
          'category': 'الفنادق',
          'rating': '3.9',
          'price': '200 ر.س / الليلة',
        },
        {
          'title': 'جبال يريم',
          'subtitle': 'إب',
          'footer': 'مناظر طبيعية',
          'avatar': 'ي',
          'category': 'المنتزهات',
          'rating': '4.5',
        },
      ],
    };

    return governoratesData[widget.governorateName] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final places = _getPlacesForGovernorate();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'منشآت ${widget.governorateName}',
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        elevation: theme.appBarTheme.elevation,
        backgroundColor: widget.governorateColor,
        iconTheme: theme.appBarTheme.iconTheme,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: إضافة وظيفة البحث
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryChips(),
          Expanded(
            child: Builder(
              builder: (context) {
                final filteredPlaces = places
                    .where(
                      (p) =>
                          selectedCategory == 'الكل' ||
                          p['category'] == selectedCategory,
                    )
                    .toList();

                if (filteredPlaces.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: filteredPlaces.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildPlaceCardFromMap(filteredPlaces[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      color: theme.cardColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: categories.map((category) {
            bool isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: isSelected
                      ? BorderSide.none
                      : BorderSide(color: theme.dividerColor, width: 1.5),
                ),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedCategory = category;
                    }
                  });
                },
              ),
            );
          }).toList(),
        ),
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
                Text(
                  place['title']!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: theme.textTheme.bodySmall?.color, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        place['subtitle']!,
                        style: TextStyle(color: theme.textTheme.bodySmall?.color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  place['footer']!,
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                ),
                if (place['rating'] != null) ...[
                  const SizedBox(height: 8),
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
              ],
            ),
          ),
          Divider(
            height: 1,
            color: theme.dividerColor,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlaceCardDetiles(
                          placeType: place['category'],
                        ),
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

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 100,
              color: theme.hintColor,
            ),
            const SizedBox(height: 24),
            Text(
              'لا توجد منشآت في هذه الفئة',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'جرب تصفح فئة أخرى',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


