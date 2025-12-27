# ملخص قواعد Cursor لمشروع Tourist Guide

تم إنشاء ملف `.cursorrules` شامل لمشروعك. هذا الملف يحتوي على قواعد وإرشادات لتطوير التطبيق.

## 📋 ما تم تضمينه في القواعد

### 1. البنية المعمارية
- ✅ شرح هيكل المجلدات (core, features)
- ✅ قواعد تنظيم الكود
- ✅ فصل UI عن Business Logic

### 2. اتفاقيات التسمية
- ✅ الملفات: `snake_case`
- ✅ الكلاسات: `PascalCase`
- ✅ المتغيرات: `camelCase`
- ✅ الثوابت: `kConstantName`

### 3. نظام الثيمات والألوان
- ✅ كيفية استخدام الثيمات المنظمة
- ✅ الألوان الأساسية للمشروع
- ✅ قواعد استخدام الألوان

### 4. المصادقة (Supabase)
- ✅ كيفية استخدام AuthService
- ✅ تحذيرات أمنية
- ✅ best practices

### 5. كتابة الويدجتات
- ✅ استخدام const
- ✅ متى تستخدم StatefulWidget vs StatelessWidget
- ✅ تسمية State Classes
- ✅ استخدام Keys

### 6. دعم اللغة العربية
- ✅ استخدام RTL
- ✅ التعليقات بالعربية
- ✅ أفضل الممارسات

### 7. تصميم الواجهات
- ✅ Material Design guidelines
- ✅ الأزرار والبطاقات
- ✅ المسافات القياسية

### 8. إدارة الحالة
- ✅ استخدام setState
- ✅ PageController & Animation
- ✅ Timer Management

### 9. معالجة الأخطاء
- ✅ Try-Catch patterns
- ✅ Null Safety
- ✅ استخدام mounted

### 10. أفضل الممارسات
- ✅ الأداء
- ✅ التنقل
- ✅ إدارة Controllers
- ✅ SafeArea

---

## 🐛 مشاكل تم اكتشافها في المشروع

### 1. الأمان
❌ **مشكلة خطيرة**: Supabase credentials موجودة مباشرة في `main.dart`

**الحل المقترح**:
```dart
// بدلاً من:
await Supabase.initialize(
  url: 'https://meodjttfrjpastkzxukc.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
);

// استخدم:
// 1. أضف flutter_dotenv في pubspec.yaml
// 2. أنشئ ملف .env
// 3. استخدم:
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);
```

### 2. الأخطاء الإملائية
يجب تصحيح أسماء الملفات والمجلدات التالية:

```
❌ lib/featuers/           → ✅ lib/features/
❌ regester_page.dart       → ✅ register_page.dart
❌ place_card_detiles.dart  → ✅ place_card_details.dart
❌ notofication_page.dart   → ✅ notification_page.dart
```

### 3. استخدام مفرط لـ ignore comments
```dart
// تجنب:
// ignore: library_private_types_in_public_api
_MainScreenState createState() => _MainScreenState();

// بدلاً من ذلك، لا تحتاج ignore إذا كان الاستخدام صحيح
```

### 4. عدم وجود validation
في صفحات Login و Register، لا يوجد validation للـ inputs:
```dart
// أضف validation
final _formKey = GlobalKey<FormState>();

TextFormField(
  controller: _emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!value.contains('@')) {
      return 'بريد إلكتروني غير صحيح';
    }
    return null;
  },
)
```

### 5. عدم dispose Controllers
في بعض الملفات مثل `login.dart`:
```dart
// تأكد من إضافة dispose
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
```

---

## 📝 خطوات التحسين المقترحة

### المرحلة 1: إصلاحات أساسية (Priority: High)
1. [ ] نقل Supabase credentials إلى .env
2. [ ] تصحيح الأخطاء الإملائية في أسماء الملفات
3. [ ] إضافة dispose لجميع Controllers
4. [ ] إضافة form validation

### المرحلة 2: تحسينات الجودة (Priority: Medium)
5. [ ] إزالة ignore comments غير الضرورية
6. [ ] إضافة error handling شامل
7. [ ] استخدام const في جميع الأماكن المناسبة
8. [ ] توحيد استخدام الألوان من Theme

### المرحلة 3: ميزات إضافية (Priority: Low)
9. [ ] إضافة internationalization (i18n)
10. [ ] إضافة state management solution (Provider, Bloc, Riverpod)
11. [ ] إضافة unit tests
12. [ ] تحسين الـ UI/UX

---

## 🚀 كيفية استخدام قواعد Cursor

### في Cursor IDE
1. الملف `.cursorrules` سيتم قراءته تلقائيًا
2. عند كتابة كود جديد، سيقترح Cursor أنماط متوافقة مع القواعد
3. عند طلب مساعدة من AI، سيتبع القواعد المحددة

### للفريق
- شارك هذا الملف مع أعضاء الفريق
- راجع القواعد عند code review
- حدث القواعد عند إضافة patterns جديدة

---

## 📚 موارد مفيدة

### Flutter
- [Flutter Documentation](https://docs.flutter.dev)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

### Supabase
- [Supabase Flutter Docs](https://supabase.com/docs/reference/dart/introduction)
- [Auth with Supabase](https://supabase.com/docs/guides/auth)

### UI/UX
- [Material Design 3](https://m3.material.io)
- [Flutter UI Challenges](https://github.com/lohanidamodar/flutter_ui_challenges)

---

## 💡 نصائح سريعة

### عند كتابة كود جديد
```dart
// ✅ افعل
const SizedBox(height: 16)
Theme.of(context).primaryColor
debugPrint('Debug message')

// ❌ لا تفعل
SizedBox(height: 16)
Color(0xFF0098DB)  // استخدم من Theme
print('Debug message')
```

### عند إنشاء Widget جديد
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});  // ✅ استخدم const و super.key
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();  // ✅ استخدم const
  }
}
```

### عند استخدام Controllers
```dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});
  
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late final TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();  // ✅ في initState
  }
  
  @override
  void dispose() {
    _controller.dispose();  // ✅ dispose دائمًا
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(controller: _controller);
  }
}
```

---

## 🎯 الخلاصة

تم إنشاء قواعد شاملة تغطي:
- ✅ البنية المعمارية
- ✅ اتفاقيات التسمية
- ✅ أفضل الممارسات
- ✅ معالجة الأخطاء
- ✅ الأمان
- ✅ UI/UX guidelines
- ✅ دعم اللغة العربية

**ملاحظة**: القواعد مصممة لتكون مرجعًا شاملاً، ولكنها ليست صارمة. استخدمها كدليل واضبطها حسب احتياجات مشروعك.

---

**تاريخ الإنشاء**: ديسمبر 2025  
**الإصدار**: 1.0  
**الحالة**: جاهز للاستخدام ✅



