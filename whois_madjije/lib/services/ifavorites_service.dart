class Favorite {
  String domainName;
  DateTime dateTime;

  Favorite({
    required this.domainName,
    required this.dateTime});

  bool isEmpty() => domainName == '!empty!';

  factory Favorite.empty() {
    return Favorite(
      dateTime: DateTime.now(),
      domainName: '!empty!',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domainName': domainName,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}

abstract class IFavoritesService {
  Future<List<Favorite>> getFavorites();
  Future<Favorite?> getFavorite(String domain);
  Future<void> addFavorite(Favorite favorite);
  Future<void> removeFromFavorites(String domain);
}
