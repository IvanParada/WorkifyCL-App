import 'dart:developer';
import 'package:workify_cl_app/features/posts/data/datasource/post_datasource.dart';
import 'package:workify_cl_app/features/posts/data/models/locations_model.dart';

class PostRepository {
  PostRepository({
    required this.postDatasource,
  });

  final PostDatasource postDatasource;

  Future<List<LocationsModel>?> getLocations() async {
    try {
      final response = await postDatasource.getLocations();

      if (response != null) {
        return response
            .map((region) => LocationsModel.fromJson(region as Map<String, dynamic>))
            .toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
