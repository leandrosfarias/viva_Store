import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viva_store/models/product.dart';
import 'package:viva_store/screens/product_management.dart';
import 'package:viva_store/services/firestore_product_service.dart';

import '../config/color_palette.dart';
import '../services/firestore_categories_service.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  const UpdateProductScreen({required this.product}) : super();

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final FirestoreProductService _productService = FirestoreProductService();
  final FirestoreCategoriesService _categoriesService =
  FirestoreCategoriesService();
  late List<String> _categories = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlImageController = TextEditingController();
  final TextEditingController _stockQuantityController =
      TextEditingController();
  String? _selectedCategory = '';
  // final List<String> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _urlImageController.text = widget.product.imageUrl;
    _stockQuantityController.text = widget.product.stockQuantity.toString();
    // print('widget.product.category => ${widget.product.category}');
    _selectedCategory = widget.product.category;
    print('_selectedCategory => $_selectedCategory');
    _fetchCategories();
  }

  void _saveForm() {
    // print('_saveForm ESTÁ SENDO CHAMADO !');
    // print('_formKey.currentState => ${_formKey.currentState}');
    if (_formKey.currentState!.validate()) {
      // print('_saveForm ENTROU NO IF !');
      _formKey.currentState!.save();

      widget.product.name = _nameController.text;
      widget.product.description = _descriptionController.text;
      widget.product.price = double.parse(_priceController.text);
      widget.product.imageUrl = _urlImageController.text;
      widget.product.category = _selectedCategory!;
      widget.product.stockQuantity = int.parse(_stockQuantityController.text);
      // atualiza produto
      _productService.updateProduct(widget.product);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProductManagement()));
    } else {
      // print('_saveForm TA CAINDO NO ELSE !');
    }
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obter a lista de categorias do Firestore

      // Limpar a lista de categorias antes de preenchê-la
      // _categories.clear();

      var categories = await _categoriesService.getCategories();
      _categories =
          categories.map((category) => category).cast<String>().toList();

      // Configurar a primeira categoria como selecionada por padrão
      if (_categories.isNotEmpty) {
        print('_categories não está vazia');
        print('_categories[0] ${_categories[0]}');
        setState(() {
          _selectedCategory = widget.product.category;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        appBar: AppBar(
          title: const Text("Atualizar produto"),
        ),
        body: Container(
          color: ColorPalette.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    // onSaved: (value) {
                    //   _product.name = value!;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um nome.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    textInputAction: TextInputAction.next,
                    controller: _descriptionController,
                    // onSaved: (value) {
                    //   _product.description = value!;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira uma descrição.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                      prefixText: 'R\$ ',
                    ),
                    textInputAction: TextInputAction.next,
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    // onSaved: (value) {
                    //   _product.price = double.parse(value!);
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um preço.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Por favor, insira um número maior que zero.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'URL da Imagem'),
                    textInputAction: TextInputAction.next,
                    controller: _urlImageController,
                    keyboardType: TextInputType.url,
                    // onSaved: (value) {
                    //   _product.imageUrl = value!;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira uma URL de imagem.';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Por favor, insira uma URL válida.';
                      }
                      return null;
                    },
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        items: _categories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Quantidade em estoque',
                      // prefixText: 'R\$ ',
                    ),
                    textInputAction: TextInputAction.next,
                    controller: _stockQuantityController,
                    keyboardType: TextInputType.number,
                    // onSaved: (value) {
                    //   _product.stockQuantity = int.parse(value!);
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um valor de quantidade em estoque.';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Por favor, insira um número válido.';
                      }
                      if (int.parse(value) <= 0) {
                        return 'Por favor, insira um número maior que zero.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveForm,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.secondaryColor),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      if (_isLoading) const Center(child: CircularProgressIndicator()),
    ]);
  }
}
