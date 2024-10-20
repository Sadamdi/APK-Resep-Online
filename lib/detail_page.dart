import 'package:flutter/material.dart';

import 'recipe_data.dart';

class DetailPage extends StatefulWidget {
  final int recipeId;

  const DetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<dynamic> _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = RecipeData.fetchRecipeById(
        widget.recipeId); // Mengambil data detail dari API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menghilangkan AppBar biasa
      body: FutureBuilder<dynamic>(
        future: _recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final recipe = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true, // AppBar tetap menempel di atas
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(recipe['name']),
                    background: Image.network(
                      recipe['image'] ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                    collapseMode: CollapseMode
                        .parallax, // Mengaktifkan parallax untuk scroll
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timer),
                                  const SizedBox(width: 4),
                                  Text('${recipe['prepTimeMinutes']} min'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department),
                                  const SizedBox(width: 4),
                                  Text('${recipe['caloriesPerServing']} Kcal'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.teal), // Garis hijau
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal, // Warna hijau
                            ),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  12.0), // Tambahkan padding untuk spasi antar baris
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var ingredient in recipe['ingredients'])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              4.0), // Tambahkan space antar baris
                                      child: Text('- $ingredient'),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.teal), // Garis hijau
                          const Text(
                            'Instructions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal, // Warna hijau
                            ),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  12.0), // Tambahkan padding untuk spasi antar baris
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < recipe['instructions'].length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              8.0), // Tambahkan jarak antar baris
                                      child: Text(
                                          '${i + 1}. ${recipe['instructions'][i]}'),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Recipe not found.'));
          }
        },
      ),
    );
  }
}
