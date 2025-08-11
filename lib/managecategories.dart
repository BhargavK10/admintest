import 'package:admintest/topbar.dart';
import 'package:flutter/material.dart';

class ManageCategories extends StatelessWidget {
  const ManageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context, 'Categories'),
      body: Text('data'),
    );
  }
}