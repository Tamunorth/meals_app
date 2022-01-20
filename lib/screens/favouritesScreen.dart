import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return favouriteMeals.isEmpty
        ? Center(
            child: Text('You Have no Favourites, Maybe you should add some!!!'),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                complexity: favouriteMeals[index].complexity,
                affordability: favouriteMeals[index].affordability,
                imageUrl: favouriteMeals[index].imageUrl,
                duration: favouriteMeals[index].duration,
              );
            },
            itemCount: favouriteMeals.length,
          );
  }
}
