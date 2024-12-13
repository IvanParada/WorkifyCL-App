import 'dart:math' as math;
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.name,
    required this.items,
    this.hintText,
    this.initialValue,
    this.borderRadius = 10.0,
    this.itemHeight = 50.0,
    this.onChanged,
  });

  final String name;
  final List<String> items;
  final String? hintText;
  final String? initialValue;
  final double borderRadius;
  final double itemHeight;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final double calculatedHeight = math.min(
          items.length * itemHeight,
          MediaQuery.of(context).size.height * 0.5,
        );

        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          builder: (BuildContext context) {
            return Container(
              height: calculatedHeight,
              padding: const EdgeInsets.all(16),
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                      onTap: () {
                        if (onChanged != null) {
                          onChanged!(items[index]);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: hintText ?? 'Selecciona una opción',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
        child: Text(
          initialValue ?? hintText ?? 'Selecciona una opción',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
