import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workify_cl_app/core/enums/enums_state.dart';
import 'package:workify_cl_app/features/posts/data/models/locations_model.dart';
import 'package:workify_cl_app/features/posts/data/repository/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepository}) : super(const PostState());

  final PostRepository postRepository;

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

  void resetSelections(){
    emit(state.copyWith(
      selectedRegion: null,
      selectedComuna: null
    ));
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
