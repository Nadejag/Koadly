import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Contact support.',
      subtitle: 'Send your message and our team will respond.',
      children: [
        const KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 12),
              _ContactLine(
                icon: Icons.phone_outlined,
                title: 'Phone',
                detail: '+92 300 0000000',
              ),
              _ContactLine(
                icon: Icons.mail_outline,
                title: 'Email',
                detail: 'support@koadly.com',
              ),
              _ContactLine(
                icon: Icons.location_on_outlined,
                title: 'Address',
                detail: 'Airport Road, Transport Office',
              ),
              SizedBox(height: 8),
              Text(
                'This information is editable from Admin settings.',
                style: TextStyle(color: KoadlyColors.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send Message',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.contactNameController,
                label: 'Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.contactEmailController,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.contactPhoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.contactSubjectController,
                label: 'Subject',
                icon: Icons.subject_outlined,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.contactMessageController,
                label: 'Message',
                icon: Icons.message_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.submitContactMessage,
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: KoadlyColors.orange),
          const SizedBox(width: 10),
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.w900)),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(color: KoadlyColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}
