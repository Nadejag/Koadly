import 'package:flutter/material.dart';

import '../../viewmodels/app_view_model.dart';
import '../widgets/koadly_widgets.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return PageScaffold(
      title: 'Customer reviews.',
      subtitle: 'Read customer feedback and submit your own review.',
      children: [
        for (final review in viewModel.reviews) ...[
          ReviewCard(review: review),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 8),
        KoadlyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Write a Review',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              TextFieldBlock(
                controller: viewModel.reviewNameController,
                label: 'Your Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.reviewEmailController,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: viewModel.reviewRating,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  prefixIcon: Icon(Icons.star_outline),
                ),
                items: [5, 4, 3, 2, 1]
                    .map(
                      (rating) => DropdownMenuItem(
                        value: rating,
                        child: Text('$rating Stars'),
                      ),
                    )
                    .toList(),
                onChanged: (rating) {
                  if (rating != null) {
                    viewModel.setReviewRating(rating);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFieldBlock(
                controller: viewModel.reviewCommentController,
                label: 'Comment',
                icon: Icons.rate_review_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.submitReview,
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
