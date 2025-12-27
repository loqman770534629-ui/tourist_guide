import 'package:flutter/foundation.dart';
import 'package:tourist_guide/core/providers/places_provider.dart';

/// Provider لإدارة المفضلات
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  // Getters
  Set<String> get favoriteIds => _favoriteIds;
  int get favoritesCount => _favoriteIds.length;

  /// التحقق إذا كان المكان في المفضلة
  bool isFavorite(String placeId) {
    return _favoriteIds.contains(placeId);
  }

  /// إضافة أو إزالة من المفضلة
  void toggleFavorite(String placeId) {
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
    } else {
      _favoriteIds.add(placeId);
    }
    notifyListeners();
  }

  /// إضافة إلى المفضلة
  void addFavorite(String placeId) {
    _favoriteIds.add(placeId);
    notifyListeners();
  }

  /// إزالة من المفضلة
  void removeFavorite(String placeId) {
    _favoriteIds.remove(placeId);
    notifyListeners();
  }

  /// مسح كل المفضلات
  void clearFavorites() {
    _favoriteIds.clear();
    notifyListeners();
  }

  /// الحصول على قائمة الأماكن المفضلة
  List<Place> getFavoritePlaces(List<Place> allPlaces) {
    return allPlaces.where((place) => _favoriteIds.contains(place.id)).toList();
  }

  /// تحميل المفضلات من التخزين المحلي (للمستقبل)
  Future<void> loadFavorites() async {
    // TODO: تحميل المفضلات من SharedPreferences أو Supabase
    // final prefs = await SharedPreferences.getInstance();
    // final favorites = prefs.getStringList('favorites') ?? [];
    // _favoriteIds.addAll(favorites);
    // notifyListeners();
  }

  /// حفظ المفضلات في التخزين المحلي (للمستقبل)
  Future<void> saveFavorites() async {
    // TODO: حفظ المفضلات في SharedPreferences أو Supabase
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('favorites', _favoriteIds.toList());
  }
}
