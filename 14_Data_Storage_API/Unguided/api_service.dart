import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxController {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  var posts = [].obs; // Observable untuk menyimpan data post
  var isLoading = false.obs; // Observable untuk indikator loading

  // Fungsi untuk GET data
  Future<void> fetchPosts() async {
    isLoading.value = true; // Mulai loading
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        posts.value = json.decode(response.body);
        Get.snackbar("Sukses", "Data berhasil diambil!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Akhiri loading
    }
  }

  // Fungsi untuk DELETE data
  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
      if (response.statusCode == 200) {
        posts.removeWhere((post) => post['id'] == id);
        Get.snackbar("Sukses", "Data berhasil dihapus!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk POST data
  Future<void> createPost() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'Flutter Post',
          'body': 'Ini contoh POST.',
          'userId': 1,
        }),
      );
      if (response.statusCode == 201) {
        posts.add(json.decode(response.body));
        Get.snackbar("Sukses", "Data berhasil ditambahkan!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  // Fungsi untuk UPDATE data
  Future<void> updatePost(int id) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'Updated Title',
          'body': 'Updated Body',
          'userId': 1,
        }),
      );
      if (response.statusCode == 200) {
        final updatedPost = posts.firstWhere((post) => post['id'] == id);
        updatedPost['title'] = 'Updated Title';
        updatedPost['body'] = 'Updated Body';
        Get.snackbar("Sukses", "Data berhasil diperbarui!",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
