import 'package:crud_assignment_oam12/add_new_item_screen.dart';
import 'package:crud_assignment_oam12/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildProdcutItem();
        },
        separatorBuilder: (_, __) => Divider(),
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

  Widget _buildProdcutItem() {
    return ListTile(
      leading: Image.network(
        'https://picsum.photos/200/300?grayscale',
        height: 60,
      ),
      title: Text('Product Name'),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unit Price : 100'),
          Text('Quantity : 100'),
          Text('Total Price : 200'),
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
