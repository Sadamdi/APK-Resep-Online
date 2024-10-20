import 'dart:convert';

import 'package:http/http.dart' as http;

class RecipeData {
  // Ambil daftar resep dari API
  static Future<List<dynamic>> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['recipes'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  // Ambil detail resep berdasarkan ID
  static Future<dynamic> fetchRecipeById(int id) async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/recipes/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  // Pencarian resep berdasarkan query
  static Future<List<dynamic>> searchRecipes(String query) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/recipes/search?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['recipes']; // Mengembalikan hasil pencarian dari API
    } else {
      throw Exception('Failed to search recipes');
    }
  }
}
