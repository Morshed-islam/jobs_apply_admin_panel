import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_villa_provider/add_villa_provider.dart';

class AddJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addPostProvider = Provider.of<AddVillaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Jobs'),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3,vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            // addPostProvider.addVilla();
          },
          child: const Text('Add Jobs', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Max Guests Input
            _buildNumberInputSection(
              title: 'Max Guests',
              value: addPostProvider.maxGuests.toString(),
              onIncrement: () => addPostProvider.updateGuests(addPostProvider.maxGuests + 1),
              onDecrement: () => addPostProvider.updateGuests(addPostProvider.maxGuests - 1),
            ),

            // Daily Rent Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildTextInputField(
                    context: context,
                    title: 'Daily Rent',
                    value: addPostProvider.dailyRent.toString(),
                    onChanged: (val) => addPostProvider.updateDailyRent(double.parse(val)),
                  ),

                  // Cleaning Fees
                  _buildTextInputField(
                    context: context,
                    title: 'Cleaning Fees',
                    value: addPostProvider.cleaningFees.toString(),
                    onChanged: (val) => addPostProvider.updateCleaningFees(double.parse(val)),
                  ),

                  // Service Fees
                  _buildTextInputField(
                    context: context,
                    title: 'Service Fees',
                    value: addPostProvider.serviceFees.toString(),
                    onChanged: (val) => addPostProvider.updateServiceFees(double.parse(val)),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // Divider
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            // Top Amenities Checkboxes
            const Text("Extra Options", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Airport Pickup Fee
                  _buildTextInputField(
                    context: context,
                    title: 'Airport Pickup Fee',
                    value: addPostProvider.airportPickupFee.toString(),
                    onChanged: (val) => addPostProvider.updateAirportPickupFee(double.parse(val)),
                  ),

                  // Extra Beds Fee
                  _buildTextInputField(
                    context: context,
                    title: 'Extra Beds Fee',
                    value: addPostProvider.extraBedsFee.toString(),
                    onChanged: (val) => addPostProvider.updateExtraBedsFee(double.parse(val)),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // Divider
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            // Room Counters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildNumberInputSection(
                    title: 'Bedrooms',
                    value: addPostProvider.bedrooms.toString(),
                    onIncrement: addPostProvider.incrementBedrooms,
                    onDecrement: addPostProvider.decrementBedrooms,
                  ),
                  _buildNumberInputSection(
                    title: 'Living Rooms',
                    value: addPostProvider.livingRooms.toString(),
                    onIncrement: addPostProvider.incrementLivingRooms,
                    onDecrement: addPostProvider.decrementLivingRooms,
                  ),
                  _buildNumberInputSection(
                    title: 'Kitchens',
                    value: addPostProvider.kitchens.toString(),
                    onIncrement: addPostProvider.incrementKitchens,
                    onDecrement: addPostProvider.decrementKitchens,
                  ),
                  _buildNumberInputSection(
                    title: 'Bathrooms',
                    value: addPostProvider.bathrooms.toString(),
                    onIncrement: addPostProvider.incrementBathrooms,
                    onDecrement: addPostProvider.decrementBathrooms,
                  ),
                  _buildNumberInputSection(
                    title: 'Gyms',
                    value: addPostProvider.gyms.toString(),
                    onIncrement: addPostProvider.incrementGyms,
                    onDecrement: addPostProvider.decrementGyms,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // Divider
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            // Top Amenities Checkboxes
            const Text("Top Amenities", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            _buildAmenityCheckbox(context, 'Kitchen', addPostProvider),
            _buildAmenityCheckbox(context, 'Wifi', addPostProvider),
            _buildAmenityCheckbox(context, 'Dedicated workspace', addPostProvider),
            _buildAmenityCheckbox(context, 'Free parking on premises', addPostProvider),
            _buildAmenityCheckbox(context, 'Pool', addPostProvider),
            _buildAmenityCheckbox(context, 'Private hot tub', addPostProvider),
            _buildAmenityCheckbox(context, 'Pets allowed', addPostProvider),
            _buildAmenityCheckbox(context, 'TV', addPostProvider),
            _buildAmenityCheckbox(context, 'Washer', addPostProvider),
            _buildAmenityCheckbox(context, 'Dryer', addPostProvider),
          ],
        ),
      ),
    );
  }

  // Increment/Decrement Section
  Widget _buildNumberInputSection({required String title, required String value, required Function onIncrement, required Function onDecrement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => onDecrement(),
            ),
            Text(value, style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onIncrement(),
            ),
          ],
        ),
      ],
    );
  }

  // Text Input Section
  Widget _buildTextInputField({required BuildContext context, required String title, required String value, required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Amenity Checkbox Section
  Widget _buildAmenityCheckbox(BuildContext context, String amenity, AddVillaProvider provider) {
    return CheckboxListTile(
      title: Text(amenity),
      value: provider.selectedAmenities.contains(amenity),
      onChanged: (bool? value) {
        provider.toggleAmenity(amenity);
      },
    );
  }
}
