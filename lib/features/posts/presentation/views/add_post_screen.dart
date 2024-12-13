import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/core/themes/icon_theme.dart';
import 'package:workify_cl_app/core/themes/texts_theme.dart';
import 'package:workify_cl_app/core/validators.dart';
import 'package:workify_cl_app/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:workify_cl_app/features/posts/presentation/cubit/post_cubit.dart';
import 'package:workify_cl_app/features/posts/presentation/widgets/chip_selector_widget.dart';
import 'package:workify_cl_app/features/posts/presentation/widgets/dropdown_widget.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            width: double.infinity,
            height: 140,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: SvgPicture.asset(
                    SvgAssets.logoApp,
                    height: 80,
                    color: AppColors.textSecondary.withOpacity(0.1),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Publicar',
                      style: appTextTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<PostCubit, PostState>(
            builder: (contextCubit, stateCubit) {
              return FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: SizedBox(
                    height: size.height * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const TextFieldWidget(
                            name: 'title',
                            labelText: 'Nombre del trabajo',
                            keyboardType: TextInputType.name,
                            validator: validateTitlePost,
                          ),
                          const SizedBox(height: 20),
                          const TextFieldWidget(
                            name: 'price',
                            labelText: 'Precio',
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 20),
                          const TextFieldWidget(
                            name: 'description',
                            labelText: 'Descripción',
                            maxLines: 4,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tipo de Servicio',
                            style: appTextTheme.bodyMedium,
                          ),
                          const SizedBox(height: 5),
                          const ChipSelectorWidget(
                            name: 'category',
                            options: ['Ofrecer Servicio', 'Solicitar Servicio'],
                            initialValue: 'Ofrecer Servicio',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Región',
                            style: appTextTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          DropdownWidget(
                            name: 'region',
                            hintText: 'Selecciona una región',
                            items: stateCubit.locations
                                .map((loc) => loc.name)
                                .toList(),
                            initialValue: stateCubit.selectedRegion?.name,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<PostCubit>().selectRegion(value);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Comuna',
                            style: appTextTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          DropdownWidget(
                            name: 'comuna',
                            hintText: 'Selecciona una comuna',
                            items: stateCubit.selectedCommunes,
                            initialValue: stateCubit.selectedComuna,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<PostCubit>().selectComuna(value);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                final formState = _formKey.currentState;
                                if (formState != null) {
                                  formState.reset();
                                  context.read<PostCubit>().resetSelections();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Publicar',
                                    style: appTextTheme.bodyMedium!.copyWith(
                                        color: AppColors.textSecondary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
