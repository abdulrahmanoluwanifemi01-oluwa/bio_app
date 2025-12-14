import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const PersonalBioApp());

class PersonalBioApp extends StatelessWidget {
  const PersonalBioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Bio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const PersonalBioPage(),
    );
  }
}

class PersonalBioPage extends StatefulWidget {
  const PersonalBioPage({super.key});

  @override
  _PersonalBioPageState createState() => _PersonalBioPageState();
}

class _PersonalBioPageState extends State<PersonalBioPage> {
  String _name = 'Ajibola Shakiruh Busari';
  String _role = 'Owner';
  String _bio = 'The Exalted loaf of Bread';
  String _email = 'AjibolaBusarishakirullahi@gmail.com';
  String _no = '07069256674';
  String _imageAsset = "assets/profile.png";

  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  // picked image from gallery
  void _showEditDialog() {
    final nameController = TextEditingController(text: _name);
    final bioController = TextEditingController(text: _bio);
    final roleController = TextEditingController(text: _role);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // save  to shared preferences
            TextField(
              controller: roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
          ],
        ),
        // Edit dialog
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _name = nameController.text;
                _role = roleController.text;
                _bio = bioController.text;
              });
              // load saved data
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Bio'), centerTitle: true),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(137, 0, 0, 0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.green[100],
                backgroundImage: _pickedImage != null
                    ? FileImage(_pickedImage!)
                    : AssetImage(_imageAsset) as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(_name, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_bio),
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(_email),
                  ),
                  ListTile(leading: const Icon(Icons.phone), title: Text(_no)),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showEditDialog,
              icon: const Icon(Icons.edit),
              label: const Text('Edit profile'),
            ),
          ],
        ),
      ),
    );
  }
}
