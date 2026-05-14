import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../widgets/koadly_widgets.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Privacy and terms.',
      subtitle:
          'How customer, driver and booking information is collected, used and governed.',
      children: const [
        _LegalCard(
          title: 'Privacy Policy',
          sections: [
            (
              'Information we collect',
              'Booking details such as name, phone, pickup location, drop-off location, ride date, ride time and optional notes. Driver applications may include vehicle and license details.',
            ),
            (
              'How information is used',
              'Information is used to process bookings, assign drivers, respond to messages, manage applications and improve service experience.',
            ),
            (
              'Location data',
              'When maps search is enabled, selected coordinates may be saved with the booking to help review routes and estimates.',
            ),
          ],
        ),
        SizedBox(height: 14),
        _LegalCard(
          title: 'Terms and Conditions',
          sections: [
            (
              'Booking requests',
              'Online submissions are booking requests until confirmed by admin.',
            ),
            (
              'Quotes',
              'Website quotes are estimates and may change due to waiting time, tolls, route changes or additional stops.',
            ),
            (
              'Driver applications',
              'Submission does not guarantee approval. Admin reviews every application.',
            ),
          ],
        ),
      ],
    );
  }
}

class _LegalCard extends StatelessWidget {
  const _LegalCard({required this.title, required this.sections});

  final String title;
  final List<(String, String)> sections;

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
          const SizedBox(height: 12),
          for (final section in sections) ...[
            Text(
              section.$1,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              section.$2,
              style: const TextStyle(color: KoadlyColors.muted, height: 1.45),
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
