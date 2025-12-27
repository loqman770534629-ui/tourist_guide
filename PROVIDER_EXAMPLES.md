# 📚 أمثلة استخدام Provider في Tourist Guide

## نظرة عامة

تم إضافة 4 Providers رئيسية للمشروع:
1. **ThemeProvider** - إدارة الوضع الليلي/النهاري
2. **AuthProvider** - إدارة المصادقة
3. **PlacesProvider** - إدارة الأماكن السياحية
4. **FavoritesProvider** - إدارة المفضلات

---

## 1️⃣ ThemeProvider - إدارة الثيم

### الاستخدام الأساسي

```dart
import 'package:provider/provider.dart';
import 'package:tourist_guide/core/providers/theme_provider.dart';

// في أي Widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Column(
      children: [
        // عرض الحالة الحالية
        Text('الوضع الحالي: ${themeProvider.isDarkMode ? "ليلي" : "نهاري"}'),
        
        // زر التبديل
        ElevatedButton(
          onPressed: () => themeProvider.toggleTheme(),
          child: Text('تبديل الوضع'),
        ),
      ],
    );
  }
}
```

### استخدام Consumer (أفضل للأداء)

```dart
Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return SwitchListTile(
      title: Text(themeProvider.isDarkMode ? 'وضع نهاري' : 'وضع ليلي'),
      value: themeProvider.isDarkMode,
      onChanged: (_) => themeProvider.toggleTheme(),
    );
  },
)
```

### تعيين الثيم مباشرة

```dart
// تفعيل الوضع الليلي
context.read<ThemeProvider>().setTheme(true);

// تفعيل الوضع النهاري
context.read<ThemeProvider>().setTheme(false);
```

---

## 2️⃣ AuthProvider - إدارة المصادقة

### تسجيل الدخول

```dart
import 'package:provider/provider.dart';
import 'package:tourist_guide/core/providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future<void> _login(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    
    final success = await authProvider.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    
    if (success) {
      // الانتقال للصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      // عرض رسالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage ?? 'خطأ')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            
            // عرض مؤشر التحميل
            if (authProvider.isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('تسجيل الدخول'),
              ),
          ],
        );
      },
    );
  }
}
```

### إنشاء حساب

```dart
Future<void> _signUp(BuildContext context) async {
  final authProvider = context.read<AuthProvider>();
  
  final success = await authProvider.signUp(
    email: emailController.text,
    password: passwordController.text,
  );
  
  if (success) {
    // نجح التسجيل
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }
}
```

### تسجيل الخروج

```dart
Future<void> _logout(BuildContext context) async {
  await context.read<AuthProvider>().signOut();
  
  // العودة لصفحة تسجيل الدخول
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => LoginPage()),
  );
}
```

### التحقق من حالة المصادقة

```dart
Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    if (authProvider.isAuthenticated) {
      return HomePage();
    } else {
      return LoginPage();
    }
  },
)
```

---

## 3️⃣ PlacesProvider - إدارة الأماكن

### عرض قائمة الأماكن

```dart
import 'package:provider/provider.dart';
import 'package:tourist_guide/core/providers/places_provider.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlacesProvider>(
      builder: (context, placesProvider, child) {
        if (placesProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (placesProvider.places.isEmpty) {
          return Center(child: Text('لا توجد أماكن'));
        }
        
        return ListView.builder(
          itemCount: placesProvider.places.length,
          itemBuilder: (context, index) {
            final place = placesProvider.places[index];
            return ListTile(
              title: Text(place.title),
              subtitle: Text(place.location),
              trailing: Text('⭐ ${place.rating}'),
            );
          },
        );
      },
    );
  }
}
```

### تصفية الأماكن حسب الفئة

```dart
class CategoryFilter extends StatelessWidget {
  final List<String> categories = [
    'الكل',
    'الفنادق',
    'المطاعم',
    'المعالم',
    'التعليمية',
    'المنتزهات',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Consumer<PlacesProvider>(
      builder: (context, placesProvider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = placesProvider.selectedCategory == category;
              
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    placesProvider.filterByCategory(category);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
```

### البحث في الأماكن

```dart
class SearchBar extends StatelessWidget {
  final controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'ابحث عن مكان...',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (query) {
        context.read<PlacesProvider>().searchPlaces(query);
      },
    );
  }
}
```

### الحصول على مكان بواسطة ID

```dart
void navigateToDetails(BuildContext context, String placeId) {
  final placesProvider = context.read<PlacesProvider>();
  final place = placesProvider.getPlaceById(placeId);
  
  if (place != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlaceDetailsPage(place: place),
      ),
    );
  }
}
```

### تحديث البيانات من API

```dart
// في initState أو عند الحاجة
@override
void initState() {
  super.initState();
  // تحميل الأماكن من API
  Future.microtask(() {
    context.read<PlacesProvider>().loadPlaces();
  });
}
```

---

## 4️⃣ FavoritesProvider - إدارة المفضلات

### إضافة/إزالة من المفضلة

```dart
import 'package:provider/provider.dart';
import 'package:tourist_guide/core/providers/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  final String placeId;
  
  const FavoriteButton({required this.placeId});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, child) {
        final isFavorite = favProvider.isFavorite(placeId);
        
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            favProvider.toggleFavorite(placeId);
            
            // عرض رسالة
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite ? 'تم الإزالة من المفضلة' : 'تم الإضافة للمفضلة'
                ),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
```

### عرض عدد المفضلات

```dart
Consumer<FavoritesProvider>(
  builder: (context, favProvider, child) {
    return Badge(
      label: Text('${favProvider.favoritesCount}'),
      child: Icon(Icons.favorite),
    );
  },
)
```

### عرض قائمة المفضلات

```dart
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoritesProvider>();
    final placesProvider = context.watch<PlacesProvider>();
    
    // الحصول على الأماكن المفضلة
    final favoritePlaces = favProvider.getFavoritePlaces(
      placesProvider.allPlaces,
    );
    
    if (favoritePlaces.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('لا توجد مفضلات بعد'),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {
        final place = favoritePlaces[index];
        return ListTile(
          title: Text(place.title),
          subtitle: Text(place.location),
          trailing: FavoriteButton(placeId: place.id),
        );
      },
    );
  }
}
```

---

## 🔄 استخدام Multiple Providers معاً

### مثال: صفحة تفاصيل المكان مع المفضلات

```dart
class PlaceDetailsPage extends StatelessWidget {
  final Place place;
  
  const PlaceDetailsPage({required this.place});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          // زر المفضلة
          Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              final isFavorite = favProvider.isFavorite(place.id);
              
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () => favProvider.toggleFavorite(place.id),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الصور
            Image.network(place.images.first),
            
            // التفاصيل
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(place.location),
                  Text(place.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### مثال: صفحة Home متكاملة

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('دليلك السياحي'),
        actions: [
          // عرض عدد المفضلات
          Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FavoritesPage()),
                      );
                    },
                  ),
                  if (favProvider.favoritesCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${favProvider.favoritesCount}',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, placesProvider, child) {
          return Column(
            children: [
              // شريط البحث
              SearchBar(),
              
              // فلاتر الفئات
              CategoryFilter(),
              
              // قائمة الأماكن
              Expanded(
                child: ListView.builder(
                  itemCount: placesProvider.places.length,
                  itemBuilder: (context, index) {
                    final place = placesProvider.places[index];
                    return PlaceCard(place: place);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

---

## 📝 نصائح مهمة

### 1. استخدم `context.read` للإجراءات فقط
```dart
// ✅ صحيح - لا يحتاج rebuild
ElevatedButton(
  onPressed: () => context.read<ThemeProvider>().toggleTheme(),
  child: Text('تبديل'),
)

// ❌ خاطئ - يسبب rebuild غير ضروري
final provider = context.watch<ThemeProvider>();
ElevatedButton(
  onPressed: () => provider.toggleTheme(),
  child: Text('تبديل'),
)
```

### 2. استخدم `context.watch` لقراءة البيانات
```dart
// ✅ صحيح - يستمع للتغييرات
@override
Widget build(BuildContext context) {
  final isDark = context.watch<ThemeProvider>().isDarkMode;
  return Text('الوضع: ${isDark ? "ليلي" : "نهاري"}');
}
```

### 3. استخدم `Consumer` للتحسين
```dart
// ✅ أفضل - فقط Consumer يعاد بناؤه
Column(
  children: [
    Text('عنوان ثابت'), // لا يعاد بناؤه
    Consumer<PlacesProvider>(
      builder: (context, provider, child) {
        return Text('${provider.places.length}'); // يعاد بناؤه عند التغيير
      },
    ),
  ],
)
```

### 4. لا تنس dispose
جميع الـ Providers تدير الموارد تلقائياً، لكن تأكد من عدم الاستماع بعد dispose:

```dart
@override
void dispose() {
  // Provider تدير dispose تلقائياً
  super.dispose();
}
```

---

## 🎯 الخلاصة

### الـ Providers المتاحة:
✅ **ThemeProvider** - الثيم والألوان  
✅ **AuthProvider** - المصادقة والمستخدم  
✅ **PlacesProvider** - الأماكن والبحث والتصفية  
✅ **FavoritesProvider** - المفضلات  

### الطرق الثلاث للوصول:
1. `context.read<T>()` - للإجراءات فقط (لا rebuild)
2. `context.watch<T>()` - للقراءة مع الاستماع (rebuild)
3. `Consumer<T>` - للتحسين (rebuild جزئي)

---

**آخر تحديث**: ديسمبر 2025  
**الحالة**: جاهز للاستخدام ✅


