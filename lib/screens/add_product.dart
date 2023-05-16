import 'package:flutter/material.dart';
import 'package:viva_store/config/color_palette.dart';

import '../models/product.dart';

class AddProductPage extends StatefulWidget {
  final Function addProduct;

  const AddProductPage(this.addProduct, {Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? _dropdownValue;
  List<String> formValues = [];
  final _formKey = GlobalKey<FormState>();
  final Product _product = Product(
    name: '',
    description: '',
    price: 0,
    imageUrl: '',
    categoryId: '',
  );
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlImageController = TextEditingController();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.addProduct(_product);
      Navigator.of(context).pop();
      formValues.add(_nameController.text);
      formValues.add(_descriptionController.text);
      formValues.add(_priceController.text);
      formValues.add(_urlImageController.text);
      formValues.add(_dropdownValue!);
      for (String value in formValues) {
        debugPrint('value => $value');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
        backgroundColor: ColorPalette.primaryColor,
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
                  onSaved: (value) {
                    _product.name = value!;
                  },
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
                  onSaved: (value) {
                    _product.description = value!;
                  },
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
                  onSaved: (value) {
                    _product.price = double.parse(value!);
                  },
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
                  decoration: const InputDecoration(labelText: 'URL da Imagem'),
                  textInputAction: TextInputAction.next,
                  controller: _urlImageController,
                  keyboardType: TextInputType.url,
                  onSaved: (value) {
                    _product.imageUrl = value!;
                  },
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
                      value: _dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'vestuário',
                        'decoração',
                        'beleza',
                        'cama',
                        'mesa',
                        'banho',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorPalette.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
