part of 'post_cubit.dart';

class PostState extends Equatable {
  const PostState({
    this.status = Status.initial,
    this.locations = const [],
    this.selectedRegion,
    this.selectedCommunes = const [],
    this.selectedComuna,
  });

  final Status status;
  final List<LocationsModel> locations;
  final LocationsModel? selectedRegion;
  final List<String> selectedCommunes;
  final String? selectedComuna;

  PostState copyWith({
    Status? status,
    List<LocationsModel>? locations,
    LocationsModel? selectedRegion,
    List<String>? selectedCommunes,
    String? selectedComuna,
  }) {
    return PostState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedCommunes: selectedCommunes ?? this.selectedCommunes,
      selectedComuna: selectedComuna,
    );
  }

  @override
  List<Object?> get props => [
        status,
        locations,
        selectedRegion,
        selectedCommunes,
        selectedComuna,
      ];
}
