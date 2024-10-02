import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  final CollectionReference _sliderCollection =
  FirebaseFirestore.instance.collection('slider_images');

  List<Map<String, dynamic>> _sliderImages = [];
  bool isLoading = true;

  List<Map<String, dynamic>> get sliderImages => _sliderImages;

  SliderProvider() {
    fetchSliderImages();
  }

  // Fetch slider images from Firestore
  Future<void> fetchSliderImages() async {
    try {
      isLoading = true;
      notifyListeners();
      QuerySnapshot snapshot = await _sliderCollection.get();
      _sliderImages = snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();
    } catch (e) {
      log('Error fetching slider images: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add a new slider image
  Future<void> addSliderImage(String imageUrl) async {
    try {
      await _sliderCollection.add({'img_url': imageUrl});
      fetchSliderImages(); // Refresh the list after adding
    } catch (e) {
      log('Error adding slider image: $e');
    }
  }

  // Delete a slider image
  Future<void> deleteSliderImage(String id) async {
    try {
      await _sliderCollection.doc(id).delete();
      fetchSliderImages(); // Refresh the list after deletion
    } catch (e) {
      log('Error deleting slider image: $e');
    }
  }

  // Update an existing slider image
  Future<void> updateSliderImage(String id, String newImageUrl) async {
    try {
      await _sliderCollection.doc(id).update({'img_url': newImageUrl});
      fetchSliderImages(); // Refresh the list after updating
    } catch (e) {
      log('Error updating slider image: $e');
    }
  }
}
