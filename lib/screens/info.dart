import 'package:bibleando3/constants/app_constants.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  static String routeName = "/InfoScreen";

  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _infoTile(
            icon: Icons.support_agent_rounded,
            title: "Correo de soporte",
            value: AppConstants.supportEmail,
          ),
          const SizedBox(height: 12),
          _infoTile(
            icon: Icons.phone_in_talk_rounded,
            title: "Teléfono de soporte",
            value: AppConstants.supportPhone,
          ),
          const SizedBox(height: 12),
          _infoTile(
            icon: Icons.verified_rounded,
            title: "Versión de la app",
            value: AppConstants.appVersion,
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E9FF)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4F46E5)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
