class Favorite {
  String domainName;
  DateTime dateTime;
  bool registered;

  Favorite({
    required this.domainName,
    required this.dateTime,
    required this.registered,
  });

  bool isEmpty() => domainName == '!empty!';

  factory Favorite.empty() {
    return Favorite(
      dateTime: DateTime.now(),
      domainName: '!empty!',
      registered: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domainName': domainName,
      'dateTime': dateTime.toIso8601String(),
      'registered': registered
    };
  }
}

abstract class IFavoritesService {
  Future<List<Favorite>> getFavorites();
  Future<Favorite?> getFavorite(String domain);
  Future<void> addFavorite(Favorite favorite);
  Future<void> removeFromFavorites(String domain);
}
