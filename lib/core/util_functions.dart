import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Vgap(double height) {
  return SizedBox(
    height: height,
  );
}

Hgap(double width) {
  return SizedBox(
    width: width,
  );
}

String serviceType(String? serviceType) {
  return serviceType == 'offeredService'
      ? 'Servicio Ofrecido'
      : 'Servicio Solicitado';
}

String priceFormatted(String? price) {
  double priceValue = double.parse(price ?? '0');

  final formatter = NumberFormat('#,##0', 'es_CL');

  return formatter.format(priceValue);
}
