import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class DriveScreen extends StatelessWidget {
  const DriveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Drive with Koadly Associates.',
      subtitle:
          'Apply as a driver. Admin will review your application and can approve, reject or assign you to bookings.',
      children: [
        const KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Driver requirements',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 12),
              _Requirement(
                text:
                    'Valid driving license and CNIC/passport where applicable.',
              ),
              _Requirement(text: 'Clean, comfortable and roadworthy vehicle.'),
              _Requirement(text: 'Professional behavior and punctuality.'),
              _Requirement(
                text: 'Active phone number for dispatch communication.',
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
                'Driver Application',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.driverNameController,
                label: 'Full Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.driverEmailController,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.driverPhoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.vehicleTypeController,
                label: 'Vehicle Type',
                hint: 'Sedan, SUV, Hiace',
                icon: Icons.directions_car_outlined,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.vehicleNumberController,
                label: 'Vehicle Number',
                icon: Icons.confirmation_number_outlined,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.licenseController,
                label: 'License Number',
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.driverMessageController,
                label: 'Message',
                hint: 'Tell us about your driving experience',
                icon: Icons.message_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.submitDriverApplication,
                  icon: const Icon(Icons.assignment_turned_in_outlined),
                  label: const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: KoadlyColors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: KoadlyColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}
