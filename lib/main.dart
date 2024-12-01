import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workify_cl_app/app/app.dart';

void main() async {
await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
