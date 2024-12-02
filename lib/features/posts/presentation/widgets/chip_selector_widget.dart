import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';

class ChipSelectorWidget extends StatelessWidget {
  const ChipSelectorWidget({
    super.key,
    required this.name,
    required this.options,
    this.initialValue,
    this.borderRadius = 20.0,
    this.onChanged,
  });

  final String name;
  final List<String> options;
  final String? initialValue;
  final double borderRadius;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      initialValue: initialValue,
      validator: (value) =>
          value == null ? 'Por favor selecciona una opción' : null,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              children: options.map((option) {
                final isSelected = field.value == option;
                final selectedColor = option == 'Ofrecer Servicio'
                    ? AppColors.success.withOpacity(.5)
                    : AppColors.info.withOpacity(.5);
                return ChoiceChip(
                  label: Text(
                    option,
                    style: TextStyle(
                      color: isSelected
                          ? option == 'Ofrecer Servicio'
                              ? AppColors.success
                              : AppColors.info
                          : AppColors.textPrimary,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    final newValue = selected ? option : null;
                    field.didChange(newValue);
                    onChanged?.call(newValue);
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: selectedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
