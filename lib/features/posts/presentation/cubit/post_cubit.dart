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
          filteredList: res,
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

  void selectPaymentType(String timePay){
    emit(state.copyWith(
      paymentType: timePay,

    ));
    print('state: ${state.paymentType} & value: ${timePay}');
  }

  void selectComuna(String comunaName) {
    emit(state.copyWith(selectedComuna: comunaName));
  }

  void updateFilteredRegion(LocationsModel? region) {
    emit(state.copyWith(
      filteredRegion: region,
      filteredComuna: null,
    ));
  }

  void updateFilteredComuna(String? comuna) {
    emit(state.copyWith(filteredComuna: comuna));
  }

  void updateFilteredService(String? service) {
    emit(state.copyWith(filteredService: service));
  }

void getFilteredPosts() {
  final filteredPosts = state.posts.where((post) {
    final matchesService = state.filteredService == null ||
        post.serviceType == state.filteredService;

    final matchesRegion = state.filteredRegion == null ||
        post.regions.toLowerCase().trim() ==
            state.filteredRegion!.name.toLowerCase().trim();

    final matchesComuna = state.filteredComuna == null ||
        post.comuna.toLowerCase().trim() ==
            state.filteredComuna!.toLowerCase().trim();

    final matchesSearchQuery = state.searchQuery.isEmpty ||
        post.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
        post.description.toLowerCase().contains(state.searchQuery.toLowerCase());

    return matchesService && matchesRegion && matchesComuna && matchesSearchQuery;
  }).toList();

  emit(state.copyWith(
    filteredList: filteredPosts,
    status: Status.successRequest,
  ));
}

void updateSearchQuery(String query) {
  emit(state.copyWith(searchQuery: query));
  getFilteredPosts();
}


  void resetFilters() {
    emit(state.copyWith(
      filteredList: state.posts,
      filteredRegion: null,
      filteredComuna: null,
      filteredService: null,
    ));
  }
}
