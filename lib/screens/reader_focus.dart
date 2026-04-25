import 'package:flutter/material.dart';

enum ReaderAction { previous, next }

class ReaderFocusScreen extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;

  const ReaderFocusScreen({
    super.key,
    required this.text,
    required this.textColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10131F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10131F),
        foregroundColor: Colors.white,
        title: const Text("Modo lectura"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context, ReaderAction.previous);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text("Anterior"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context, ReaderAction.next);
                      },
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text("Siguiente"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
