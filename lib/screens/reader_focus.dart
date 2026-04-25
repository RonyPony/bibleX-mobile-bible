import 'package:flutter/material.dart';

enum ReaderAction { previous, next }
typedef ReaderNavigate = Future<String?> Function(ReaderAction action);

class ReaderFocusScreen extends StatefulWidget {
  final String initialText;
  final Color textColor;
  final double fontSize;
  final ReaderNavigate onNavigate;

  const ReaderFocusScreen({
    super.key,
    required this.initialText,
    required this.textColor,
    required this.fontSize,
    required this.onNavigate,
  });

  @override
  State<ReaderFocusScreen> createState() => _ReaderFocusScreenState();
}

class _ReaderFocusScreenState extends State<ReaderFocusScreen> {
  late String _currentText;
  bool _moving = false;

  @override
  void initState() {
    super.initState();
    _currentText = widget.initialText;
  }

  Future<void> _navigate(ReaderAction action) async {
    if (_moving) return;
    setState(() {
      _moving = true;
    });
    final newText = await widget.onNavigate(action);
    if (!mounted) return;
    setState(() {
      if (newText != null) {
        _currentText = newText;
      }
      _moving = false;
    });
  }

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
                  _currentText,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize,
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
                      onPressed: _moving ? null : () => _navigate(ReaderAction.previous),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text("Anterior"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _moving ? null : () => _navigate(ReaderAction.next),
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
