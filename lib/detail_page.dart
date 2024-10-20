import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String ingredients;
  final String instructions;

  const RecipeDetailPage({
    required this.imageUrl,
    required this.title,
    required this.ingredients,
    required this.instructions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Center(
                child: Image.asset(
                  imageUrl,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Judul resep
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                ingredients,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            
              const Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                instructions,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
