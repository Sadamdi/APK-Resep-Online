import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'recipe_data.dart'; // Import data resep dari file terpisah

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> filteredRecipes = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void _filterRecipes(String query) {
    setState(() {
      searchQuery = query;
      if (searchQuery.isEmpty) {
        filteredRecipes = recipes;
      } else {
        filteredRecipes = recipes
            .where((recipe) => recipe['title']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is in your kitchen?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Type your ingredients',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(
                            imageUrl: recipe['imageUrl']!,
                            title: recipe['title']!,
                            ingredients: recipe['ingredients']!,
                            instructions: recipe['instructions']!,
                          ),
                        ),
                      );
                    },
                    child: RecipeCard(
                      imageUrl: recipe['imageUrl']!,
                      title: recipe['title']!,
                      calories: recipe['calories']!,
                      time: recipe['time']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String calories;
  final String time;

  const RecipeCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.calories,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
          radius: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Row(
          children: [
            Text(calories),
            const SizedBox(width: 10),
            const Icon(Icons.schedule, size: 16),
            const SizedBox(width: 5),
            Text(time),
          ],
        ),
      ),
    );
  }
}
