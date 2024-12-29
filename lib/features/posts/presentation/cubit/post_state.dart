part of 'post_cubit.dart';

class PostState extends Equatable {
  const PostState({
    this.status = Status.initial,
    this.locations = const [],
    this.posts = const [],
    this.selectedPost,
    this.selectedRegion,
    this.selectedCommunes = const [],
    this.selectedComuna,
  });

  final Status status;
  final List<LocationsModel> locations;
  final List<PostModel> posts;
  final PostModel? selectedPost;
  final LocationsModel? selectedRegion;
  final List<String> selectedCommunes;
  final String? selectedComuna;

  PostState copyWith({
    Status? status,
    List<LocationsModel>? locations,
    List<PostModel>? posts,
    PostModel? selectedPost,
    LocationsModel? selectedRegion,
    List<String>? selectedCommunes,
    String? selectedComuna,
  }) {
    return PostState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      posts: posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedCommunes: selectedCommunes ?? this.selectedCommunes,
      selectedComuna: selectedComuna,
    );
  }

  @override
  List<Object?> get props => [
        status,
        locations,
        posts,
        selectedPost,
        selectedRegion,
        selectedCommunes,
        selectedComuna,
      ];
}
