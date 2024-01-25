import 'package:news/model/cat_mod.dart';

List<CatMod> getCategories() {
  List<CatMod> category =[];
  CatMod catMod = new CatMod();

  catMod.categoryName = "Business";
  catMod.image = "image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Entertainment";
  catMod.image = "image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "General";
  catMod.image = "image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Health";
  catMod.image = "image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Sports";
  catMod.image = "image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  return category;
}