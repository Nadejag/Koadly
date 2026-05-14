import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/app_shell.dart';

void main() {
  runApp(const KoadlyApp());
}

class KoadlyApp extends StatefulWidget {
  const KoadlyApp({super.key});

  @override
  State<KoadlyApp> createState() => _KoadlyAppState();
}

class _KoadlyAppState extends State<KoadlyApp> {
  late final KoadlyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = KoadlyViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KoadlyViewModelScope(
      notifier: viewModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koadly Associates',
        theme: KoadlyTheme.light(),
        home: const AppShell(),
      ),
    );
  }
}
