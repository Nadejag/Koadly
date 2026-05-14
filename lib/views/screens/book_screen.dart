import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../data/mock_data.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Book your ride.',
      subtitle:
          'Search pickup and drop-off locations, choose your service type and submit your request.',
      children: [
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ride Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              TextFieldBlock(
                controller: viewModel.nameController,
                label: 'Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.phoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.pickupController,
                label: 'Pickup Location',
                hint: 'Search pickup location on map',
                icon: Icons.my_location,
                onChanged: (_) => viewModel.refreshQuote(),
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.dropoffController,
                label: 'Drop-off Location',
                hint: 'Search drop-off location on map',
                icon: Icons.location_on_outlined,
                onChanged: (_) => viewModel.refreshQuote(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _DateButton(viewModel: viewModel)),
                  const SizedBox(width: 10),
                  Expanded(child: _TimeButton(viewModel: viewModel)),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                initialValue: viewModel.selectedService,
                decoration: const InputDecoration(
                  labelText: 'Ride Type',
                  prefixIcon: Icon(Icons.directions_car_outlined),
                ),
                items: rideServices
                    .map(
                      (service) => DropdownMenuItem(
                        value: service,
                        child: Text(service.name),
                      ),
                    )
                    .toList(),
                onChanged: (service) {
                  if (service != null) {
                    viewModel.setService(service);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.noteController,
                label: 'Special Note',
                hint: 'Flight number, luggage, stopover, etc.',
                icon: Icons.notes_outlined,
              ),
              const SizedBox(height: 16),
              RoutePreview(
                distance: viewModel.distanceKm,
                quote: viewModel.quote,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.submitBooking,
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Submit Booking'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Route Preview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 8),
              Text(
                'Google location search can be connected after the Maps API key is added in Admin settings.',
                style: TextStyle(color: KoadlyColors.muted, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({required this.viewModel});

  final KoadlyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: viewModel.pickupDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          viewModel.setPickupDate(date);
        }
      },
      icon: const Icon(Icons.calendar_month_outlined),
      label: Text(
        '${viewModel.pickupDate.month}/${viewModel.pickupDate.day}/${viewModel.pickupDate.year}',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({required this.viewModel});

  final KoadlyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: viewModel.pickupTime,
        );
        if (time != null) {
          viewModel.setPickupTime(time);
        }
      },
      icon: const Icon(Icons.access_time),
      label: Text(viewModel.pickupTimeLabel, overflow: TextOverflow.ellipsis),
    );
  }
}
