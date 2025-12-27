import 'package:flutter/material.dart';

// اللون الأساسي الذي تستخدمه في تطبيقك
const Color primaryColor = Color(0xFF0098DB);

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesPageState createState() => _FavoritesPageState();
}

// نحتاج TickerProviderStateMixin لاستخدام TabController
class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- بيانات وهمية مؤقتة ---
  // في التطبيق الحقيقي، هذه القائمة ستكون متغيرة (Stateful)
  // وعند الضغط على القلب، ستحذف العنصر من القائمة وتستدعي setState
  final List<Map<String, dynamic>> _allFavorites = [
    {
      "id": "1",
      "title": "فندق ريتز كارلتون",
      "location": "دبي، الإمارات",
      "rating": 4.8,
      "type": "hotel",
      "imageUrl":
          "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400",
    },
    {
      "id": "2",
      "title": "متحف اللوفر",
      "location": "باريس، فرنسا",
      "rating": 4.9,
      "type": "place",
      "imageUrl":
          "https://images.unsplash.com/photo-1552832230-c01979360fde?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400",
    },
    {
      "id": "3",
      "title": "مطعم نصرت ستيك هاوس",
      "location": "اسطنبول، تركيا",
      "rating": 4.5,
      "type": "restaurant",
      "imageUrl":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400",
    },
    {
      "id": "4",
      "title": "برج إيفل",
      "location": "باريس، فرنسا",
      "rating": 4.7,
      "type": "place",
      "imageUrl":
          "https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=400",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 تبويبات
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // استخدام نفس اللون الأساسي
        title: Text(
          'المفضلات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // يمكنك إضافة أيقونات أخرى هنا إذا أردت
        // actions: [
        //   IconButton(icon: Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        // ],
        elevation: 1.0,
      ),
      body: Column(
        children: [
          // --- 1. شريط البحث ---
          _buildSearchBar(),

          // --- 2. شريط التبويبات (Tabs) ---
          Container(
            color: Theme.of(context).cardColor,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'الكل'),
                Tab(text: 'فنادق'),
                Tab(text: 'مطاعم'),
                Tab(text: 'أماكن'),
              ],
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).textTheme.bodySmall?.color,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 3.0,
            ),
          ),

          // --- 3. محتوى التبويبات ---
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // المحتوى 1: الكل
                _buildFavoritesList(_allFavorites),

                // المحتوى 2: فنادق
                _buildFavoritesList(
                  _allFavorites.where((i) => i['type'] == 'hotel').toList(),
                ),

                // المحتوى 3: مطاعم
                _buildFavoritesList(
                  _allFavorites
                      .where((i) => i['type'] == 'restaurant')
                      .toList(),
                ),

                // المحتوى 4: أماكن
                _buildFavoritesList(
                  _allFavorites.where((i) => i['type'] == 'place').toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- ودجت شريط البحث ---
  Widget _buildSearchBar() {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.6);
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: theme.scaffoldBackgroundColor,
      child: TextField(
        textDirection: TextDirection.rtl,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: '   البحث في المفضلات ',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: Icon(Icons.search, color: hintColor),
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none, // بدون إطار
          ),
        ),
      ),
    );
  }

  // --- ودجت بناء قائمة المفضلات ---
  Widget _buildFavoritesList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      // --- 4. حالة القائمة الفارغة ---
      return _buildEmptyState();
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        // --- 5. استدعاء البطاقة الجديدة ---
        return _buildFavoriteItemCard(
          title: item['title'],
          location: item['location'],
          rating: item['rating'],
          imageUrl: item['imageUrl'],
          onUnlike: () {
            // كمثال، سنقوم بحذفه من القائمة المؤقتة
            setState(() {
              _allFavorites.removeWhere((fav) => fav['id'] == item['id']);
            });
          },
        );
      },
    );
  }

  // --- 6. تصميم البطاقة الأسطورية (الأهم) ---
  Widget _buildFavoriteItemCard({
    required String title,
    required String location,
    required double rating,
    required String imageUrl,
    required VoidCallback onUnlike,
  }) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = textColor.withOpacity(0.7);
    
    return Card(
      color: theme.cardColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 130, // ارتفاع ثابت للبطاقة
          child: Row(
            textDirection: TextDirection.rtl, // لترتيب العناصر من اليمين
            children: [
              // --- الصورة (على اليمين) ---
              SizedBox(
                width: 130, // عرض مربع للصورة
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: imageUrl,
                  fit: BoxFit.cover,
                  height: 130,
                  imageErrorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(Icons.broken_image, color: hintColor),
                  ),
                ),
              ),

              // --- التفاصيل (في المنتصف) ---
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. العنوان
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // 2. الموقع
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: hintColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                color: hintColor,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // 3. التقييم
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // --- أيقونة القلب (على اليسار) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite, // قلب ممتلئ لأنه في المفضلة
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: onUnlike, // عند الضغط، يتم استدعاء دالة الحذف
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ودجت حالة "لا توجد بيانات" ---
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
            Icon(Icons.favorite_border, size: 100, color: hintColor),
            const SizedBox(height: 24),
            Text(
              'لا توجد عناصر مفضلة هنا',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'قم بإضافة الأماكن التي تعجبك بالضغط على أيقونة القلب.',
              style: TextStyle(fontSize: 16, color: hintColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
