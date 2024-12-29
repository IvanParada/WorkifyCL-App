import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/features/authentication/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Workify/features/posts/data/models/create_post_model.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/core/validators.dart';
import 'package:Workify/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:Workify/features/posts/presentation/widgets/chip_selector_widget.dart';
import 'package:Workify/features/posts/presentation/widgets/dropdown_widget.dart';
import 'package:go_router/go_router.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            showCustomAnimatedDialog(
              context: context,
              title: 'Publicación Creada',
              message: 'La publicación ha sido creada con éxito.',
              colorTypeDialog: AppColors.success,
              icon: SvgAssets.check,
              onTap: () {
                context.pop();
                context.go('/home');
              },
            );
          }
          if (state.status == Status.failure) {
            showCustomAnimatedDialog(
              context: context,
              title: 'Ups',
              message: 'Ha ocurrido un problema al crear la publicación.',
              colorTypeDialog: AppColors.warning,
              icon: SvgAssets.logoApp,
              onTap: () {
                context.pop();
                context.go('/home');
              },
            );
          }
        },
        child: Column(
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
                  key: formKey,
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
                              validator: validatePricePost,
                            ),
                            const SizedBox(height: 20),
                            const TextFieldWidget(
                              name: 'description',
                              labelText: 'Descripción',
                              maxLines: 4,
                              keyboardType: TextInputType.name,
                              validator: validateTextLength,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Tipo de Servicio',
                              style: appTextTheme.bodyMedium,
                            ),
                            const SizedBox(height: 5),
                            const ChipSelectorWidget(
                              name: 'category',
                              options: [
                                'Ofrecer Servicio',
                                'Solicitar Servicio'
                              ],
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
                              isEnabled: stateCubit.selectedRegion != null,
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
                                  final formState = formKey.currentState;
                                  if (formState != null &&
                                      formState.saveAndValidate()) {
                                    final title = formState
                                        .fields['title']?.value as String;
                                    final price = double.tryParse(
                                            formState.fields['price']?.value) ??
                                        0.0;
                                    final description = formState
                                        .fields['description']?.value as String;
                                    final category = formState
                                        .fields['category']?.value as String;

                                    final createPostModel = CreatePostModel(
                                      title: title,
                                      price: price,
                                      description: description,
                                      serviceType:
                                          category == 'Ofrecer Servicio'
                                              ? 'offeredService'
                                              : 'requestService',
                                      regions: stateCubit.selectedRegion!.name,
                                      comuna: stateCubit.selectedComuna!,
                                    );

                                    context
                                        .read<PostCubit>()
                                        .createPost(createPostModel);

                                    formState.reset();
                                    context.read<PostCubit>().resetSelections();
                                    // if (stateCubit.status == Status.success) {
                                    //   showCustomAnimatedDialog(
                                    //     context: context,
                                    //     title: 'Publicación Creada',
                                    //     message:
                                    //         'La publicación ha sido creada con éxito.',
                                    //     colorTypeDialog: AppColors.success,
                                    //     icon: SvgAssets.check,
                                    //     onTap: () {
                                    //       context.pop();
                                    //       context.go('/home');
                                    //     },
                                    //   );
                                    // }
                                    // if (stateCubit.status == Status.failure) {
                                    //   showCustomAnimatedDialog(
                                    //     context: context,
                                    //     title: 'Ups',
                                    //     message:
                                    //         'Ha ocurrido un problema al crear la publicación.',
                                    //     colorTypeDialog: AppColors.warning,
                                    //     icon: SvgAssets.logoApp,
                                    //     onTap: () {
                                    //       context.pop();
                                    //       context.go('/home');
                                    //     },
                                    //   );
                                    // }
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
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
      ),
    );
  }
}
