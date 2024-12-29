import 'dart:developer';
import 'package:Workify/features/posts/data/datasource/post_datasource.dart';
import 'package:Workify/features/posts/data/models/locations_model.dart';
import 'package:Workify/features/posts/data/models/post_model.dart';

class PostRepository {
  PostRepository({
    required this.postDatasource,
  });

  final PostDatasource postDatasource;

  Future<bool> createPost(postData) async {
    try {
      final response = await postDatasource.createPost(postData);
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<PostModel>?> getPosts() async {
    try {
      final response = await postDatasource.getPosts();

      if (response != null) {
        final List<PostModel> posts = (response as List)
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return posts;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<PostModel?> getPostsById(id) async {
    try {

      final response = await postDatasource.getPostsById(id);

      if (response != null) {
        return PostModel.fromJson(response);
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<LocationsModel>?> getLocations() async {
    try {
      final response = await postDatasource.getLocations();

      if (response != null) {
        return response
            .map((region) =>
                LocationsModel.fromJson(region as Map<String, dynamic>))
            .toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
