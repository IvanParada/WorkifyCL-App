part of 'post_cubit.dart';

class PostState extends Equatable {
  const PostState({
    this.status = Status.initial,
    this.locations = const [],
    this.posts = const [],
    this.paymentType,
    this.selectedPost,
    this.selectedRegion,
    this.selectedCommunes = const [],
    this.selectedComuna,
    this.filteredRegion,
    this.filteredComuna,
    this.filteredService,
    this.filteredList = const [],
    this.searchQuery = '',
  });

  final Status status;
  final List<LocationsModel> locations;
  final List<PostModel> posts;
  final String? paymentType;
  final PostModel? selectedPost;
  final LocationsModel? selectedRegion;
  final List<String> selectedCommunes;
  final String? selectedComuna;

  final LocationsModel? filteredRegion;
  final String? filteredComuna;
  final String? filteredService;

  final String searchQuery;

  final List<PostModel> filteredList;

  PostState copyWith({
    Status? status,
    List<LocationsModel>? locations,
    List<PostModel>? posts,
    List<PostModel>? filteredList,
    String? paymentType,
    PostModel? selectedPost,
    LocationsModel? selectedRegion,
    List<String>? selectedCommunes,
    String? selectedComuna,
    LocationsModel? filteredRegion,
    String? filteredComuna,
    String? filteredService,
    String? searchQuery,
  }) {
    return PostState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      posts: posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
      paymentType: paymentType ?? this.paymentType,
      filteredList: filteredList ?? this.filteredList,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedCommunes: selectedCommunes ?? this.selectedCommunes,
      selectedComuna: selectedComuna,
      filteredRegion: filteredRegion,
      filteredComuna: filteredComuna,
      filteredService: filteredService,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        locations,
        posts,
        filteredList,
        paymentType,
        selectedPost,
        selectedRegion,
        selectedCommunes,
        selectedComuna,
        filteredRegion,
        filteredComuna,
        filteredService,
        searchQuery,
      ];
}
