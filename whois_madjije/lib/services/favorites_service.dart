import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_madjije/services/ifavorites_service.dart';
import 'package:whois_madjije/services/isearch_history_service.dart';

enum FavoritesDatabaseProvider {
  memory,
  fileSystem,
}

class FavoritesService implements IFavoritesService {

  @override
  late Stream<bool> updated$ = _updated.stream;

  final _updated = StreamController<bool>.broadcast();

  @override
  Future<List<Favorite>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('favorites') ?? '[]';

    final List<dynamic> jsonData = json.decode(historyJson);

    final List<Favorite> list = _parseList(jsonData);

    list.sort((x, y) => y.dateTime.compareTo(x.dateTime));

    return list;
  }

  @override
  Future<Favorite?> getFavorite(String domain) async {
    var favorites = await getFavorites();
    favorites = favorites.where((x) => x.domainName == domain).toList();

    if (favorites.isEmpty) {
      return null;
    }

    return favorites.first;
  }

  @override
  Future<void> addFavorite(Favorite favorite) async {
    final prefs = await SharedPreferences.getInstance();

    final historyJson = prefs.getString('favorites') ?? '[]';

    var jsonData = json.decode(historyJson) as List<dynamic>;

    final list = _parseList(jsonData);
    final existingRecord = list.firstWhere((x) => favorite.domainName == x.domainName,
      orElse: () => Favorite.empty());

    if (existingRecord.isEmpty()) {
      jsonData.add(favorite.toJson());

    } else {
      final index = list.indexOf(existingRecord);
      existingRecord.dateTime = favorite.dateTime;

      list[index] = existingRecord;

      jsonData = list.map((x) => x.toJson()).toList();
    }

    await prefs.setString('favorites', json.encode(jsonData));

    _updated.add(true);
  }


  @override
  Future<void> removeFromFavorites(String domain) async {
    var favorites = await getFavorites();
    favorites = favorites.where((element) => element.domainName != domain)
      .toList();

    final jsonData = favorites.map((x) => x.toJson()).toList();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', json.encode(jsonData));

    _updated.add(true);
  }

  List<Favorite> _parseList(List<dynamic> jsonData) {
    return jsonData
      .map((x) => Favorite(
        domainName: x['domainName'],
        dateTime: DateTime.parse(x['dateTime']),
        registered: x['registered'],
      ))
      .toList();
  }
}
