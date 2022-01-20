import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavourite;
  final Function isFavourite;

  MealDetailScreen(this.toggleFavourite, this.isFavourite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 150.0,
      width: 300.0,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedMeal.title}',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
                child: ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('# ${index + 1}'),
                              ),
                              title: Text(selectedMeal.steps[index]),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavourite(mealId) ? Icons.favorite : Icons.favorite_outline,
          ),
          onPressed: () {
            toggleFavourite(mealId);
          }),
    );
  }
}
