import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../../data/mock_data.dart';
import '../../models/app_page.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    final responsive = context.responsive;
    return PageScaffold(
      title: 'Reliable rides, every time.',
      subtitle:
          'Premium taxi and transport services designed around your schedule.',
      hero: const HeroPanel(),
      children: [
        _QuickBookingCard(viewModel: viewModel),
        SizedBox(height: responsive.gap(24)),
        SectionTitle(
          title: 'Premium ride options',
          action: TextButton(
            onPressed: () => viewModel.goTo(AppPage.services),
            child: const Text('View all'),
          ),
        ),
        SizedBox(height: responsive.gap(12)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rideServices.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: responsive.isTablet ? 340 : 280,
            childAspectRatio: responsive.isTablet
                ? 0.76
                : responsive.isCompact
                ? 0.74
                : 0.82,
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
        SizedBox(height: responsive.gap(24)),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KoadlyPill(
                icon: Icons.verified_outlined,
                label: 'Why choose us',
              ),
              SizedBox(height: responsive.gap(12)),
              Text(
                'Fast online booking, verified drivers and admin-controlled operations.',
                style: TextStyle(
                  fontSize: responsive.font(24, min: 20, max: 28),
                  height: 1.12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: responsive.gap(12)),
              Text(
                'Customers can submit ride requests, track trips, send reviews, contact support and apply as drivers. Admin can manage bookings, drivers, services, reviews, messages and map settings.',
                style: TextStyle(
                  color: KoadlyColors.muted,
                  fontSize: responsive.font(14, min: 12, max: 16),
                  height: 1.45,
                ),
              ),
              SizedBox(height: responsive.gap(16)),
              Wrap(
                spacing: responsive.gap(10),
                runSpacing: responsive.gap(10),
                children: const [
                  MiniBadge(label: 'Location search ready'),
                  MiniBadge(label: 'Status tracking'),
                  MiniBadge(label: 'Driver assignment'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickBookingCard extends StatelessWidget {
  const _QuickBookingCard({required this.viewModel});

  final KoadlyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return KoadlyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleIcon(icon: Icons.local_taxi_outlined),
              SizedBox(width: responsive.gap(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book your ride',
                      style: TextStyle(
                        fontSize: responsive.font(22, min: 19, max: 26),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Get an instant quote in seconds',
                      style: TextStyle(
                        color: KoadlyColors.muted,
                        fontSize: responsive.font(14, min: 12, max: 16),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => viewModel.goTo(AppPage.book),
                child: const Text('Full form'),
              ),
            ],
          ),
          SizedBox(height: responsive.gap(18)),
          TextFieldBlock(
            controller: viewModel.pickupController,
            label: 'Pick Up Location',
            hint: 'Search pickup location',
            icon: Icons.my_location,
            onChanged: (_) => viewModel.refreshQuote(),
          ),
          SizedBox(height: responsive.gap(12)),
          TextFieldBlock(
            controller: viewModel.dropoffController,
            label: 'Drop Off Location',
            hint: 'Search drop-off location',
            icon: Icons.location_on_outlined,
            onChanged: (_) => viewModel.refreshQuote(),
          ),
          SizedBox(height: responsive.gap(14)),
          RoutePreview(distance: viewModel.distanceKm, quote: viewModel.quote),
          SizedBox(height: responsive.gap(14)),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => viewModel.goTo(AppPage.book),
              icon: const Icon(Icons.receipt_long_outlined),
              label: const Text('Continue Booking'),
            ),
          ),
        ],
      ),
    );
  }
}
