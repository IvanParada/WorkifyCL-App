import 'package:Workify/features/posts/data/models/create_post_model.dart';
import 'package:Workify/features/posts/data/models/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/features/posts/data/models/locations_model.dart';
import 'package:Workify/features/posts/data/repository/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepository}) : super(const PostState());

  final PostRepository postRepository;

  Future<bool> createPost(CreatePostModel postData) async {
    emit(state.copyWith(status: Status.loading));

    final res = await postRepository.createPost(postData);

    if (res) {
      emit(state.copyWith(status: Status.success));

      return true;
    }

    emit(state.copyWith(status: Status.failure));
    return false;
  }

  Future<void> getRegions() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final res = await postRepository.getLocations();

      if (res != null) {
        emit(state.copyWith(
          status: Status.success,
          locations: res,
        ));
      } else {
        emit(state.copyWith(status: Status.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> getPosts() async {
    emit(state.copyWith(status: Status.loadingRequest));
    try {
      final res = await postRepository.getPosts();

      if (res != null) {
        res.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        emit(state.copyWith(
          status: Status.successRequest,
          posts: res,
        ));
      } else {
        emit(state.copyWith(status: Status.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> getPostsById(id) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final res = await postRepository.getPostsById(id);
      if (res != null) {
        emit(state.copyWith(
          status: Status.success,
          selectedPost: res,
        ));
      } else {
        emit(state.copyWith(status: Status.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void resetSelections() {
    emit(state.copyWith(selectedRegion: null, selectedComuna: null));
  }

  void selectRegion(String regionName) {
    final selectedRegion = state.locations.firstWhere(
      (location) => location.name == regionName,
      orElse: () => LocationsModel(name: '', communes: []),
    );

    emit(state.copyWith(
      selectedRegion: selectedRegion,
      selectedCommunes: selectedRegion.communes,
      selectedComuna: null,
    ));
  }

  void selectComuna(String comunaName) {
    emit(state.copyWith(selectedComuna: comunaName));
  }
}
