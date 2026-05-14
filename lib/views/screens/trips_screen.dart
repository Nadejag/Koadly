import 'package:flutter/material.dart';

import '../../models/app_page.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Trips.',
      subtitle:
          'Track booking requests, confirmations, completed rides and cancellations.',
      children: [
        SectionTitle(
          title: 'Your bookings',
          action: TextButton(
            onPressed: () => viewModel.goTo(AppPage.track),
            child: const Text('Track'),
          ),
        ),
        const SizedBox(height: 12),
        for (final booking in viewModel.bookings) ...[
          BookingTile(booking: booking),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
