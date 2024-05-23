import 'package:flutter/material.dart';

class UpdateNewProductItemScreen extends StatefulWidget {
  const UpdateNewProductItemScreen({super.key});

  @override
  State<UpdateNewProductItemScreen> createState() =>
      _UpdateNewProductItemScreenState();
}

class _UpdateNewProductItemScreenState extends State<UpdateNewProductItemScreen> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
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
                      }
                    }, child: Text('Add'),),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
