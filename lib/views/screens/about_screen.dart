import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../widgets/koadly_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Premium transport built around reliability.',
      subtitle:
          'Koadly Associates provides airport transfers, city rides, business travel and hourly bookings with a focus on punctuality.',
      children: const [
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who We Are',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              Text(
                'We connect customers with professional transport services for personal, corporate and airport travel. Every booking is stored so admin can confirm rides, assign drivers and track trip status.',
                style: TextStyle(color: KoadlyColors.muted, height: 1.45),
              ),
              SizedBox(height: 14),
              MiniBadge(label: 'Instant ride request'),
              SizedBox(height: 8),
              MiniBadge(label: 'Admin confirmation'),
              SizedBox(height: 8),
              MiniBadge(label: 'Driver assignment'),
            ],
          ),
        ),
        SizedBox(height: 14),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why Customers Choose Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 14),
              _InfoLine(
                title: 'Verified Drivers',
                detail:
                    'Driver applications can be reviewed and approved before assignment.',
              ),
              _InfoLine(
                title: 'Clear Status Tracking',
                detail:
                    'Bookings move through pending, confirmed, completed and cancelled statuses.',
              ),
              _InfoLine(
                title: 'Support Ready',
                detail: 'Contact messages are stored for admin follow-up.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: KoadlyColors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(detail, style: const TextStyle(color: KoadlyColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
