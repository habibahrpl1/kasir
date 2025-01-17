import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to the "Produk" tab
  final List<Map<String, String>> _products = []; // List to store products
  final List<Map<String, String>> _customers = []; // List to store customers

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addProduct(String name, String price, String stock) {
    setState(() {
      _products.add({"name": name, "price": price, "stock": stock});
    });
  }

  void _addCustomer(String name, String address, String phone) {
    setState(() {
      _customers.add({"name": name, "address": address, "phone": phone});
    });
  }

  void _editProduct(int index, String name, String price, String stock) {
    setState(() {
      _products[index] = {"name": name, "price": price, "stock": stock};
    });
  }

  void _editCustomer(int index, String name, String address, String phone) {
    setState(() {
      _customers[index] = {"name": name, "address": address, "phone": phone};
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _deleteCustomer(int index) {
    setState(() {
      _customers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Kasir'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(143, 148, 251, 1), // Ganti warna AppBar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(143, 148, 251, 1), // Ganti warna DrawerHeader
              ),
              child: Text(
                'Pengaturan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                // Log out action
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Registrasi'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Registration page
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => _buildAddCustomerDialog(),
                      );
                    },
                    child: Text('Tambah Pelanggan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                    ),
                  ),
                  SizedBox(height: 20),
                  _customers.isEmpty
                      ? Text(
                          'Belum ada pelanggan',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _customers.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_customers[index]['name'] ?? ''),
                                subtitle: Text(
                                  'Alamat: ${_customers[index]['address'] ?? ''}\No Telepon: ${_customers[index]['phone'] ?? ''}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildEditCustomerDialog(index),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteCustomer(index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              )
            : _selectedIndex == 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildAddProductDialog(),
                          );
                        },
                        child: Text('Tambah Produk'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      SizedBox(height: 20),
                      _products.isEmpty
                          ? Text(
                              'Belum ada produk',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _products.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_products[index]['name'] ?? ''),
                                    subtitle: Text(
                                        'Harga: ${_products[index]['price']} | Stok: ${_products[index]['stock']}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _buildEditProductDialog(index),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteProduct(index);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  )
                : Text('Halaman Penjualan'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Penjualan',
          ),
        ],
        selectedItemColor: Color.fromRGBO(143, 148, 251, 1),
      ),
    );
  }

  Widget _buildAddProductDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();

    return AlertDialog(
      title: Text('Tambah Produk'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Produk'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Harga Produk'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(labelText: 'Stok Produk'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty &&
                stockController.text.isNotEmpty) {
              _addProduct(nameController.text, priceController.text, stockController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Tambah'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomerDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return AlertDialog(
      title: Text('Tambah Pelanggan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Pelanggan'),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Alamat Pelanggan'),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'No Tlp Pelanggan'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                addressController.text.isNotEmpty &&
                phoneController.text.isNotEmpty) {
              _addCustomer(nameController.text, addressController.text, phoneController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Tambah'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildEditProductDialog(int index) {
    final TextEditingController nameController = TextEditingController(text: _products[index]['name']);
    final TextEditingController priceController = TextEditingController(text: _products[index]['price']);
    final TextEditingController stockController = TextEditingController(text: _products[index]['stock']);

    return AlertDialog(
      title: Text('Edit Produk'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Produk'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Harga Produk'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(labelText: 'Stok Produk'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty &&
                stockController.text.isNotEmpty) {
              _editProduct(index, nameController.text, priceController.text, stockController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Simpan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildEditCustomerDialog(int index) {
    final TextEditingController nameController = TextEditingController(text: _customers[index]['name']);
    final TextEditingController addressController = TextEditingController(text: _customers[index]['address']);
    final TextEditingController phoneController = TextEditingController(text: _customers[index]['phone']);

    return AlertDialog(
      title: Text('Edit Pelanggan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Pelanggan'),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Alamat Pelanggan'),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'No Tlp Pelanggan'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                addressController.text.isNotEmpty &&
                phoneController.text.isNotEmpty) {
              _editCustomer(index, nameController.text, addressController.text, phoneController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Simpan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          ),
        ),
      ],
    );
  }
}