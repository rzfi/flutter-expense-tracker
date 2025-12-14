import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import '../widgets/app_drawer.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      drawer: const AppDrawer(currentRoute: AppRoutes.reports),
      body: const Center(child: Text('Reports UI will be added in Phase 4.')),
    );
  }
}
