import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductItemScreen extends StatefulWidget {
  const AddNewProductItemScreen({super.key});

  @override
  State<AddNewProductItemScreen> createState() =>
      _AddNewProductItemScreenState();
}

class _AddNewProductItemScreenState extends State<AddNewProductItemScreen> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameTEController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'Write Your Produce Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _unitTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Unit Price',
                      labelText: 'Unit Price'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'Write Your Produce Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Product Code',
                      labelText: 'Product Code'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'Write Your Product Code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Quantity',
                      labelText: 'Quantity'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'Write Your Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Total Price',
                      labelText: 'Total Price'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'Write Your total price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),

                TextFormField(
                  controller: _imageTEController,
                  decoration: InputDecoration(
                      hintText: 'image',
                      labelText: 'image'
                  ),
                  validator: (String? value){
                    if(value==null || value.trim().isEmpty){
                      return 'please input an image';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                    onPressed: () {
                      if(_formkey.currentState!.validate()){
                        _addProduct();
                      }
                    }, child: Text('Add'),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    //step 1 : set url
    const String addNewProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    //step 2 : set data
    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitTEController.text,
    };
    //step 3 : parse
    Uri uri = Uri.parse(addNewProductUrl);
    //step 4 : Send Request
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'content-type': 'application/json'},
    );
    print(response.statusCode);
    print(response.body);
    print(response.headers);
  }

  //TODO : From clear after add
  //TODO : AddButton should be in progress after click (loading)
  //TODO : Toast / SnackBar


  @override
  void dispose() {
    _nameTEController.dispose();
    _unitTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
