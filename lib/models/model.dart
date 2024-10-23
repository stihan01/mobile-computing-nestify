import 'package:flutter/material.dart';
import 'blueprint_post.dart';

class Model extends ChangeNotifier{
  final List<BlueprintPost> _blueprintList = [];
  List<BlueprintPost> get blueprintList => _blueprintList;

  final List<BlueprintPost> _favorites = [];
  List<BlueprintPost> get favorites => _favorites;

  Model() {
    _setup();
  }

  void _setup() {
    _blueprintList.add(BlueprintPost('Hanna\'s Buzz Hotel', 'Wood, bamboo, and twine', 'A bug hotel specifically made for bees', 'Gardening'));
    _blueprintList.add(BlueprintPost('DIY Birdhouse', 'Wood, nails, and paint', 'A simple birdhouse for your garden', 'Gardening'));
    _blueprintList.add(BlueprintPost('DIY Plant Hanger', 'Macrame cord and a ring', 'A simple plant hanger for your home', 'Home Decor'));
    _blueprintList.add(BlueprintPost('DIY Macrame Wall Hanging', 'Macrame cord and a stick', 'A simple wall hanging for your home', 'Home Decor'));
    _blueprintList.add(BlueprintPost('DIY Coasters', 'Cork and paint', 'A simple coaster set for your home', 'Home Decor'));
    _blueprintList.add(BlueprintPost('DIY Painted Rocks', 'Rocks and paint', 'A simple painted rock set for your home', 'Home Decor'));
    _blueprintList.add(BlueprintPost('DIY Bath Bombs', 'Baking soda, citric acid, and essential oils', 'A simple bath bomb set for your home', 'Self Care'));
  
    favorites.add(_blueprintList[0]);
    favorites.add(_blueprintList[1]);
    favorites.add(_blueprintList[2]);
    notifyListeners();
  }

  void addFavorite(BlueprintPost post) {
    _favorites.add(post);
    notifyListeners();
  }

  
  void addBlueprint(blueprintPost){
    _blueprintList.add(blueprintPost);
    notifyListeners();
  }
}