import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';

class Restaurants extends StatefulWidget {
  final Food food;
  const Restaurants({super.key, required this.food});

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    //get the restaurant menu and choose a random item
    final items = context.read<DeliciousChoices>();
    final randomRestaurantIndex = Random().nextInt(items.restaurantList.length);
    setState(() {
      randomRestaurantIndex;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Restaurants'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    widget.food.imagePath,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.food.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Restaurants(
                            food: items.restaurantList[randomRestaurantIndex],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ReorderableListView(
                autoScrollerVelocityScalar: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onReorder: (int oldIndex, int newIndex) {
                  setState(
                    () {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Food item = items.restaurantList.removeAt(oldIndex);
                      items.restaurantList.insert(newIndex, item);
                    },
                  );
                },
                children: [
                  for (int index = 0;
                      index < items.restaurantList.length;
                      index += 1)
                    Card(
                      key: Key('$index'),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Restaurants(
                                food: items.restaurantList[index],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                height: 50,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(items.restaurantList[index].name,
                                      style: const TextStyle(fontSize: 20)),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
