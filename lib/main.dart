import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ideal/core/app.dart';
import 'core/di.dart';

void main() {
  setupDependencies();
  runApp(const ProviderScope(child: IdealApp()));
}
