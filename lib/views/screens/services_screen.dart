import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../../data/mock_data.dart';
import '../../models/app_page.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    final responsive = context.responsive;
    return PageScaffold(
      title: 'Transport services for every schedule.',
      subtitle:
          'Select airport transfer, business travel, city rides or hourly booking.',
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rideServices.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: responsive.isTablet ? 360 : 330,
            childAspectRatio: responsive.isTablet
                ? 0.78
                : responsive.isCompact
                ? 0.76
                : 0.86,
            crossAxisSpacing: responsive.gap(12),
            mainAxisSpacing: responsive.gap(12),
          ),
          itemBuilder: (context, index) {
            final service = rideServices[index];
            return ServiceCard(
              service: service,
              onTap: () {
                viewModel.setService(service);
                viewModel.goTo(AppPage.book);
              },
            );
          },
        ),
        SizedBox(height: responsive.gap(18)),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KoadlyPill(
                icon: Icons.workspace_premium_outlined,
                label: 'Premium transport',
              ),
              SizedBox(height: responsive.gap(12)),
              Text(
                'Built for airport transfers, corporate travel, city rides and hourly bookings.',
                style: TextStyle(
                  fontSize: responsive.font(24, min: 20, max: 28),
                  height: 1.14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: responsive.gap(10)),
              Text(
                'Customers can search locations, submit details, receive an estimated quote and wait for admin confirmation.',
                style: TextStyle(
                  color: KoadlyColors.muted,
                  fontSize: responsive.font(14, min: 12, max: 16),
                ),
              ),
              SizedBox(height: responsive.gap(16)),
              FilledButton.icon(
                onPressed: () => viewModel.goTo(AppPage.book),
                icon: const Icon(Icons.local_taxi_outlined),
                label: const Text('Open Booking Page'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
