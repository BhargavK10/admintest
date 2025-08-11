import 'package:admintest/topbar.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context, 'Products'),
      body: Text('data'),
    );
  }
}