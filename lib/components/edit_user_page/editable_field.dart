import 'package:finance_tracker/helper/color.dart';
import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String title;
  final String? currentValue;
  final bool isPassword;
  final VoidCallback onEdit;

  const EditableField({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onEdit,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit ${title.toLowerCase()}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Current ${title.toLowerCase()}: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                  currentValue != null
                      ? Text(
                          currentValue!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const Icon(Icons.visibility_off),
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(
            Icons.edit,
            size: 28,
            color: AppColors.darkAccentColor,
          ),
        ),
      ],
    );
  }
}
