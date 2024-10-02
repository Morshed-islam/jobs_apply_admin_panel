import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_slider_provider/add_slider_provider.dart';

class AddSliderPage extends StatelessWidget {
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<SliderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Slider Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_imageController.text.isNotEmpty) {
                  sliderProvider.addSliderImage(_imageController.text);
                  _imageController.clear(); // Clear the text field after adding
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter an image URL.')));
                }
              },
              child: const Text('Add Slider Image'),
            ),
            const SizedBox(height: 20),
            sliderProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: sliderProvider.sliderImages.length,
                itemBuilder: (context, index) {
                  final slider = sliderProvider.sliderImages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(slider['img_url']),
                      title: Text('Slider ${index + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditDialog(context, slider['id'], slider['img_url']);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              sliderProvider.deleteSliderImage(slider['id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show a dialog to edit the slider image URL
  void _showEditDialog(BuildContext context, String id, String currentUrl) {
    final TextEditingController _editController = TextEditingController(text: currentUrl);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Slider Image'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_editController.text.isNotEmpty) {
                  Provider.of<SliderProvider>(context, listen: false)
                      .updateSliderImage(id, _editController.text);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
