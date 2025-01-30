import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    this.isEnabled = true,
  });

  final String name;
  final List<String> items;
  final String? hintText;
  final String? initialValue;
  final double borderRadius;
  final double itemHeight;
  final Function(String?)? onChanged;
  final bool isEnabled; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled
          ? () {
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
                              context.pop();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          : null, 
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
          style: TextStyle(
            fontSize: 16,
            color: isEnabled ? Colors.black : Colors.grey, 
          ),
        ),
      ),
    );
  }
}
