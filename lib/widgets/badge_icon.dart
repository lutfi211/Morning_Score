import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    super.key,
    required this.assetPath,
    required this.fallbackText,
    this.size = 36,
  });

  final String? assetPath;
  final String fallbackText;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initials = fallbackText
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join()
        .toUpperCase();

    return SizedBox.square(
      dimension: size,
      child: ClipOval(
        child: assetPath == null
            ? ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontSize: size * 0.32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
            : Image.asset(
                assetPath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: size * 0.32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
