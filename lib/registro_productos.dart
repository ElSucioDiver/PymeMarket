import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRegistrationPage extends StatefulWidget {
  @override
  _ProductRegistrationPageState createState() =>
      _ProductRegistrationPageState();
}

class _ProductRegistrationPageState extends State<ProductRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController(); // Nuevo controlador para la descripción
  File? _selectedImage;
  String? _uploadedImageUrl;

  // Método para seleccionar una imagen
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Método para subir la imagen a Firebase Storage
  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child('imagenesProductos/$fileName');

    try {
      TaskSnapshot snapshot = await storageRef.putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error al subir la imagen: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(picked); // Formatear la fecha
      });
    }
  }

  // Método para enviar el formulario
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_selectedImage != null) {
          _uploadedImageUrl = await _uploadImage(_selectedImage!);
        }

        // Crear un nuevo producto con la descripción agregada
        final product = {
          'fecha': Timestamp.fromDate(DateTime.parse(_dateController.text)),
          'nombre': _nameController.text,
          'tipo': _typeController.text,
          'sku': _skuController.text,
          'stock': int.tryParse(_stockController.text) ?? 0,
          'precio': double.tryParse(_priceController.text) ?? 0.0,
          'descripcion': _descriptionController.text, // Agregar la descripción
          'imagen': _uploadedImageUrl,
        };

        // Guardar el producto en Firebase
        await guardarProducto(product);

        // Limpiar los controladores
        _dateController.clear();
        _nameController.clear();
        _typeController.clear();
        _skuController.clear();
        _stockController.clear();
        _priceController.clear();
        _descriptionController
            .clear(); // Limpiar el controlador de la descripción
        setState(() {
          _selectedImage = null;
          _uploadedImageUrl = null;
        });

        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto registrado exitosamente')),
        );
      } catch (e) {
        // Manejar errores al guardar el producto
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar el producto: $e')),
        );
      }
    }
  }

  // Función que guarda productos en Firebase
  Future<void> guardarProducto(Map<String, dynamic> producto) async {
    CollectionReference collectionReferenceProductos =
        FirebaseFirestore.instance.collection('productos');
    await collectionReferenceProductos.add(producto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Fecha'),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la fecha de ingreso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el tipo del producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _skuController,
                  decoration: InputDecoration(labelText: 'Código SKU'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el código SKU';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el stock del producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el precio del producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una descripción del producto';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    height: 100,
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Registrar Producto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
