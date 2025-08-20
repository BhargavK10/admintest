import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _techInfoController = TextEditingController();

  String? _selectedCategory; // NEW: category state
  final List<String> _categories = ['performance', 'aesthetic', 'oem', 'bodykits'];

  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  bool _loading = false;

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        _selectedImages = picked.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    final urls = <String>[];
    final storage = Supabase.instance.client.storage.from('product-images'); // bucket name

    for (var img in _selectedImages) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${img.path.split('/').last}';

      await storage.upload(fileName, img);

      // get public URL
      final publicUrl = storage.getPublicUrl(fileName);
      urls.add(publicUrl);
    }
    return urls;
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 0.0;

      // Parse JSONB
      Map<String, dynamic>? techInfo;
      if (_techInfoController.text.trim().isNotEmpty) {
        techInfo = jsonDecode(_techInfoController.text.trim());
      }

      final imageUrls = await _uploadImages();

      await Supabase.instance.client.from('products').insert({
        'name': name,
        'description': description,
        'price': price,
        'image_urls': imageUrls, // array of strings
        'technical_info': techInfo, // jsonb
        'category':_selectedCategory
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Product Name"),
                  validator: (v) => v!.isEmpty ? "Enter product name" : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 3,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(labelText: "Category"),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _techInfoController,
                  decoration: const InputDecoration(
                      labelText: "Technical Info (JSON format)"),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.image),
                  label: const Text("Pick Images"),
                ),
                const SizedBox(height: 10),
                if (_selectedImages.isNotEmpty)
                  Wrap(
                    children: _selectedImages
                        .map((img) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.file(img, width: 80, height: 80),
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 20),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _saveProduct,
                        child: const Text("Save Product"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
