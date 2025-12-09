import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/features/posts/data/models/locations_model.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:Workify/features/posts/presentation/widgets/chip_selector_widget.dart';
import 'package:Workify/features/posts/presentation/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              height: size.height * .05,
              width: size.width * .7,
              child: SearchBar(
                elevation: WidgetStateProperty.resolveWith((states) => 0),
                backgroundColor: WidgetStateColor.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.focused)) {
                      return AppColors.textSecondary;
                    }
                    return AppColors.textSecondary.withOpacity(0.3);
                  },
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                    SvgAssets.search,
                    color: AppColors.primary,
                  ),
                ),
                hintText: 'Buscar...',
                onChanged: (value) {
                  context.read<PostCubit>().updateSearchQuery(value);
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  builder: (BuildContext context) {
                    final postCubit = context.read<PostCubit>();

                    // Valores iniciales del filtro (estado actual del cubit)
                    String? selectedService = postCubit.state.filteredService ==
                            'offeredService'
                        ? 'Servicio Ofrecido'
                        : postCubit.state.filteredService == 'requestService'
                            ? 'Servicio Solicitado'
                            : null;

                    String? selectedRegion =
                        postCubit.state.filteredRegion?.name;
                    String? selectedComuna = postCubit.state.filteredComuna;

                    return StatefulBuilder(
                      builder: (context, setState) {
                        final size = MediaQuery.of(context).size;

                        return Container(
                          height: 500,
                          width: size.width,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Filtros',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text('Tipo de Servicio'),
                              const SizedBox(height: 10),
                              ChipSelectorWidget(
                                name: 'category',
                                options: const [
                                  'Servicio Ofrecido',
                                  'Servicio Solicitado',
                                ],
                                initialValue: selectedService,
                                onChanged: (value) {
                                  setState(() {
                                    selectedService = value;
                                  });

                                  postCubit.updateFilteredService(
                                    value == 'Servicio Ofrecido'
                                        ? 'offeredService'
                                        : value == 'Servicio Solicitado'
                                            ? 'requestService'
                                            : null,
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // Región
                              const Text('Región'),
                              const SizedBox(height: 10),
                              DropdownWidget(
                                name: 'region',
                                hintText: 'Selecciona una región',
                                items: postCubit.state.locations
                                    .map((loc) => loc.name)
                                    .toList(),
                                initialValue: selectedRegion,
                                onChanged: (value) {
                                  final region = postCubit.state.locations
                                      .firstWhere((loc) => loc.name == value);

                                  setState(() {
                                    selectedRegion = region.name;
                                    selectedComuna = null;
                                  });

                                  postCubit.updateFilteredRegion(region);
                                },
                              ),

                              const SizedBox(height: 20),

                              const Text('Comuna'),
                              const SizedBox(height: 10),
                              DropdownWidget(
                                name: 'comuna',
                                hintText: 'Selecciona una comuna',
                                items: selectedRegion != null
                                    ? postCubit.state.locations
                                        .firstWhere(
                                            (loc) => loc.name == selectedRegion)
                                        .communes
                                    : [],
                                initialValue: selectedComuna,
                                isEnabled: selectedRegion != null,
                                onChanged: (value) {
                                  setState(() {
                                    selectedComuna = value;
                                  });

                                  postCubit.updateFilteredComuna(value);
                                },
                              ),

                              const Spacer(),

                              Row(
                                children: [
                                  // Reset
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      postCubit.resetFilters();
                                    },
                                    child: Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: AppColors.error,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Restablecer',
                                          style:
                                              appTextTheme.bodyMedium!.copyWith(
                                            color: AppColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      postCubit.getFilteredPosts();
                                    },
                                    child: Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Aplicar',
                                          style:
                                              appTextTheme.bodyMedium!.copyWith(
                                            color: AppColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    SvgAssets.filter,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
