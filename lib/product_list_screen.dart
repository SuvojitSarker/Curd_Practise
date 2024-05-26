import 'dart:async';
import 'dart:convert';
import 'package:crud_assignment_oam12/add_new_item_screen.dart';
import 'package:crud_assignment_oam12/product.dart';
import 'package:crud_assignment_oam12/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Visibility(
        visible: _getProductListInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return _buildProdcutItem(productList[index]);
          },
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewProductItemScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    const String ProductListUrl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(ProductListUrl);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);

    if (response == 200) {
      // data decode
      final decodeData = jsonDecode(response.body);
      //get the list
      final JsonProductList = decodeData['data'];
      //loop over the list
      for (Map<String, dynamic> p in JsonProductList) {
        Product product = Product(
            id: p['_id'] ?? '',
            productName: p['ProductName'] ?? 'Unknown',
            productCode: p['ProductCode'] ?? '',
            image: p['Img'] ?? '',
            unitPrice: p['UnitPrice'] ?? '',
            quantity: p['Qty'] ?? '',
            totalPrice: p['TotalPrice'] ?? '');
        productList.add(product);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Product List Failed , Try Again.'),
        ),
      );
    }

    _getProductListInProgress = false;
    setState(() {});
  }

  Widget _buildProdcutItem(Product product) {
    return ListTile(
      leading: Image.network(
        'https://picsum.photos/200/300?grayscale',
        height: 60,
      ),
      title: Text(product.productName),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unit Price : ${product.unitPrice}'),
          Text('Quantity : ${product.quantity}'),
          Text('Total Price : ${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateNewProductItemScreen(),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialogue();
            },
            icon: Icon(Icons.delete_rounded),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are You Sure Want to Delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
