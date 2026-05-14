import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Track your booking.',
      subtitle:
          'Enter booking number and phone number to check current status.',
      children: [
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Track Booking',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.trackIdController,
                label: 'Booking ID',
                icon: Icons.tag_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.trackPhoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.trackBooking,
                  icon: const Icon(Icons.manage_search_outlined),
                  label: const Text('Check Status'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (viewModel.trackedBooking == null)
          const KoadlyCard(
            child: Text(
              'Your booking status will appear here after searching.',
              style: TextStyle(color: KoadlyColors.muted),
            ),
          )
        else
          BookingTile(booking: viewModel.trackedBooking!),
      ],
    );
  }
}
