import 'package:flutter/material.dart';
import 'package:ui/theme/radius.dart';
import 'package:ui/theme/spacing.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isLoading,
    super.key,
  });

  final Widget icon;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  List<Widget> _getContent(BuildContext context) => isLoading
      ? [
          const Expanded(
            child: Center(
              child: SizedBox(
                width: AppSpacing.p20,
                height: AppSpacing.p20,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ]
      : [
          AppSpacing.gapW16,
          icon,
          AppSpacing.gapW16,
          Text(
            text,
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.c16,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: AppRadius.c32,
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getContent(context),
            ),
          ),
        ),
      ),
    );
  }
}
