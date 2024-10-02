import 'package:flutter/material.dart';

class AddVillaProvider with ChangeNotifier {
  int maxGuests = 1;
  double dailyRent = 0.0;
  double cleaningFees = 0.0;
  double serviceFees = 0.0;
  String extraOptions = '';
  double airportPickupFee = 0.0;
  double extraBedsFee = 0.0;

  int bedrooms = 5;
  int livingRooms = 3;
  int kitchens = 2;
  int bathrooms = 1;
  int gyms = 2;

  List<String> selectedAmenities = [];

  void updateGuests(int value) {
    maxGuests = value;
    notifyListeners();
  }

  void updateDailyRent(double value) {
    dailyRent = value;
    notifyListeners();
  }

  void updateCleaningFees(double value) {
    cleaningFees = value;
    notifyListeners();
  }

  void updateServiceFees(double value) {
    serviceFees = value;
    notifyListeners();
  }

  void updateExtraOptions(String value) {
    extraOptions = value;
    notifyListeners();
  }

  void updateAirportPickupFee(double value) {
    airportPickupFee = value;
    notifyListeners();
  }

  void updateExtraBedsFee(double value) {
    extraBedsFee = value;
    notifyListeners();
  }

  void incrementBedrooms() {
    bedrooms++;
    notifyListeners();
  }

  void decrementBedrooms() {
    if (bedrooms > 0) bedrooms--;
    notifyListeners();
  }

  void incrementLivingRooms() {
    livingRooms++;
    notifyListeners();
  }

  void decrementLivingRooms() {
    if (livingRooms > 0) livingRooms--;
    notifyListeners();
  }

  void incrementKitchens() {
    kitchens++;
    notifyListeners();
  }

  void decrementKitchens() {
    if (kitchens > 0) kitchens--;
    notifyListeners();
  }

  void incrementBathrooms() {
    bathrooms++;
    notifyListeners();
  }

  void decrementBathrooms() {
    if (bathrooms > 0) bathrooms--;
    notifyListeners();
  }

  void incrementGyms() {
    gyms++;
    notifyListeners();
  }

  void decrementGyms() {
    if (gyms > 0) gyms--;
    notifyListeners();
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
    notifyListeners();
  }
}
