import 'package:flutter/material.dart';

enum AppAlertType { success, error, warning }

Future<void> showAppAlert(
  BuildContext context, {
  required AppAlertType type,
  required String title,
  required String message,
}) async {
  if (!context.mounted) return;

  final config = switch (type) {
    AppAlertType.success => (
        color: const Color(0xFF2EC4B6),
        icon: Icons.check_circle_rounded,
      ),
    AppAlertType.error => (
        color: const Color(0xFFEF476F),
        icon: Icons.error_rounded,
      ),
    AppAlertType.warning => (
        color: const Color(0xFFFFB703),
        icon: Icons.warning_amber_rounded,
      ),
  };

  await showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: config.color.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(config.icon, color: config.color, size: 34),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C2541),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF46516C),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: config.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Entendido"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
