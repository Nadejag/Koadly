import 'package:flutter/material.dart';

import '../widgets/koadly_widgets.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Frequently asked questions.',
      subtitle:
          'Quick answers about booking, payments, drivers, cancellations and support.',
      children: const [
        _FaqGroup(
          title: 'Booking',
          items: [
            (
              'How do customers book a ride?',
              'Use Home or Book, search pickup and drop-off locations, select date and time, then submit the request.',
            ),
            (
              'Does map location search work?',
              'The app is ready for Google Places. Connect the Maps API key/backend endpoint when available.',
            ),
            (
              'Can admin confirm or cancel bookings?',
              'Yes. Admin can update booking status, assign drivers, edit quote amount and add notes.',
            ),
          ],
        ),
        SizedBox(height: 14),
        _FaqGroup(
          title: 'Drivers and support',
          items: [
            (
              'Can drivers apply online?',
              'Yes. Drivers can submit applications from Drive With Us for admin review.',
            ),
            (
              'How do customers contact support?',
              'Customers can submit the support form. Admin can view and manage messages.',
            ),
          ],
        ),
      ],
    );
  }
}

class _FaqGroup extends StatelessWidget {
  const _FaqGroup({required this.title, required this.items});

  final String title;
  final List<(String, String)> items;

  @override
  Widget build(BuildContext context) {
    return KoadlyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          for (final item in items)
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                item.$1,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(item.$2),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
