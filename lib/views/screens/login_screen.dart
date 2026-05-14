import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../models/app_page.dart';
import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Profile.',
      subtitle: 'Access your profile, saved trips, support and account tools.',
      children: [
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.loginEmailController,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.loginPasswordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.login,
                  icon: const Icon(Icons.login),
                  label: const Text('Login'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Default admin after SQL import: admin@koadly.com / admin123',
                style: TextStyle(color: KoadlyColors.muted, fontSize: 12),
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
                'Create Customer Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.registerNameController,
                label: 'Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.registerEmailController,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.registerPhoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.registerPasswordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.register,
                  icon: const Icon(Icons.person_add_alt),
                  label: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        KoadlyCard(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ActionChip(
                avatar: const Icon(
                  Icons.route_outlined,
                  color: KoadlyColors.orange,
                ),
                label: const Text('Track booking'),
                onPressed: () => viewModel.goTo(AppPage.track),
              ),
              ActionChip(
                avatar: const Icon(
                  Icons.privacy_tip_outlined,
                  color: KoadlyColors.orange,
                ),
                label: const Text('Privacy & Terms'),
                onPressed: () => viewModel.goTo(AppPage.legal),
              ),
              ActionChip(
                avatar: const Icon(
                  Icons.help_outline,
                  color: KoadlyColors.orange,
                ),
                label: const Text('FAQ'),
                onPressed: () => viewModel.goTo(AppPage.faq),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
