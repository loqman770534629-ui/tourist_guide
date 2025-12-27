import 'package:flutter/foundation.dart';

/// نموذج بيانات المكان
class Place {
  final String id;
  final String title;
  final String subtitle;
  final String location;
  final String category;
  final String rating;
  final String? price;
  final String? cuisine;
  final String? priceRange;
  final String? hours;
  final String? type;
  final String footer;
  final String avatar;
  final String description;
  final List<String> images;
  final List<String> facilities;
  final double? latitude;
  final double? longitude;
  final String? checkIn;
  final String? checkOut;
  final String? cancellationPolicy;

  Place({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.category,
    required this.rating,
    this.price,
    this.cuisine,
    this.priceRange,
    this.hours,
    this.type,
    required this.footer,
    required this.avatar,
    required this.description,
    this.images = const [],
    this.facilities = const [],
    this.latitude,
    this.longitude,
    this.checkIn,
    this.checkOut,
    this.cancellationPolicy,
  });

  // تحويل من JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      rating: json['rating']?.toString() ?? '0',
      price: json['price'],
      cuisine: json['cuisine'],
      priceRange: json['priceRange'],
      hours: json['hours'],
      type: json['type'],
      footer: json['footer'] ?? '',
      avatar: json['avatar'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      facilities: json['facilities'] != null
          ? List<String>.from(json['facilities'])
          : [],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      cancellationPolicy: json['cancellationPolicy'],
    );
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'location': location,
      'category': category,
      'rating': rating,
      'price': price,
      'cuisine': cuisine,
      'priceRange': priceRange,
      'hours': hours,
      'type': type,
      'footer': footer,
      'avatar': avatar,
      'description': description,
      'images': images,
      'facilities': facilities,
      'latitude': latitude,
      'longitude': longitude,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'cancellationPolicy': cancellationPolicy,
    };
  }
}

/// Provider لإدارة الأماكن السياحية
class PlacesProvider extends ChangeNotifier {
  List<Place> _places = [];
  List<Place> _filteredPlaces = [];
  String _selectedCategory = 'الكل';
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Place> get places => _filteredPlaces;
  List<Place> get allPlaces => _places;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PlacesProvider() {
    // بيانات افتراضية للاختبار
    _loadDummyData();
  }

  /// تحميل بيانات افتراضية (سيتم استبدالها بـ API)
  void _loadDummyData() {
    _places = [
      Place(
        id: '1',
        title: 'فندق موفنبيك',
        subtitle: 'صنعاء',
        location: 'Makkah',
        category: 'الفنادق',
        rating: '4.6',
        price: '450 ر.س / الليلة',
        footer: 'أجنحة فاخرة',
        avatar: 'M',
        description:
            'يقع فندق المسار العزيزية المصنف نجمة واحدة في منطقة العزيزية الجنوبية بمكة المكرمة...',
        images: [
          'assets/hotel.jpg',
          'assets/hotel2.jpeg',
          'assets/hotel3.jpeg',
        ],
        facilities: ['واي فاي', 'مواقف', 'مسبح', 'مطعم', 'جيم', 'سبا'],
        latitude: 21.4225,
        longitude: 39.8262,
        checkIn: '16.00 - 20.00',
        checkOut: '12.00 - 14.00',
        cancellationPolicy:
            'الحجوزات غير مستردة وغير قابلة للإلغاء وغير قابلة للتعديل.',
      ),
      Place(
        id: '2',
        title: 'فندق ايجل',
        subtitle: 'صنعاء',
        location: 'Sana\'a',
        category: 'الفنادق',
        rating: '4.2',
        price: '320 ر.س / الليلة',
        footer: 'موقع مركزي',
        avatar: 'E',
        description: 'فندق في موقع مركزي مع إطلالة رائعة',
        images: ['assets/hotel2.jpeg'],
        facilities: ['واي فاي', 'مواقف', 'مطعم'],
      ),
      Place(
        id: '3',
        title: 'مطعم ريماس',
        subtitle: 'صنعاء',
        location: 'Sana\'a',
        category: 'المطاعم',
        rating: '4.4',
        cuisine: 'عربي، بحري',
        priceRange: 'متوسط',
        footer: 'أكلات شعبية وفاخرة',
        avatar: 'R',
        description: 'مطعم يقدم أكلات شعبية وفاخرة',
        images: ['assets/hotel.jpg'],
      ),
      Place(
        id: '4',
        title: 'المتحف الوطني',
        subtitle: 'صنعاء القديمة',
        location: 'Sana\'a',
        category: 'التعليمية',
        rating: '4.8',
        hours: '9:00 - 17:00',
        type: 'متحف',
        footer: 'متحف وتاريخ محلي',
        avatar: 'م',
        description: 'متحف يحتوي على تاريخ اليمن العريق',
        images: ['assets/hotel3.jpeg'],
      ),
    ];

    _filteredPlaces = _places;
    notifyListeners();
  }

  /// تحميل الأماكن من API (سيتم تنفيذه لاحقاً)
  Future<void> loadPlaces() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // TODO: استبدل هذا بـ API call من صديقك
      await Future.delayed(const Duration(seconds: 1));
      // final response = await http.get(Uri.parse('YOUR_API_URL'));
      // _places = (jsonDecode(response.body) as List)
      //     .map((json) => Place.fromJson(json))
      //     .toList();

      _filteredPlaces = _places;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// تصفية الأماكن حسب الفئة
  void filterByCategory(String category) {
    _selectedCategory = category;

    if (category == 'الكل') {
      _filteredPlaces = _places;
    } else {
      _filteredPlaces = _places
          .where((place) => place.category == category)
          .toList();
    }

    notifyListeners();
  }

  /// البحث في الأماكن
  void searchPlaces(String query) {
    if (query.isEmpty) {
      _filteredPlaces = _places;
    } else {
      _filteredPlaces = _places
          .where(
            (place) =>
                place.title.toLowerCase().contains(query.toLowerCase()) ||
                place.subtitle.toLowerCase().contains(query.toLowerCase()) ||
                place.location.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    notifyListeners();
  }

  /// الحصول على مكان بواسطة ID
  Place? getPlaceById(String id) {
    try {
      return _places.firstWhere((place) => place.id == id);
    } catch (e) {
      return null;
    }
  }

  /// إضافة مكان جديد (للمستقبل)
  void addPlace(Place place) {
    _places.add(place);
    filterByCategory(_selectedCategory); // إعادة تطبيق التصفية
  }

  /// تحديث مكان (للمستقبل)
  void updatePlace(Place place) {
    final index = _places.indexWhere((p) => p.id == place.id);
    if (index != -1) {
      _places[index] = place;
      filterByCategory(_selectedCategory);
    }
  }

  /// حذف مكان (للمستقبل)
  void removePlace(String id) {
    _places.removeWhere((place) => place.id == id);
    filterByCategory(_selectedCategory);
  }
}
