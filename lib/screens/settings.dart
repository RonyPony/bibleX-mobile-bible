import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bottomMenu.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/SettingScreen";

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  static const String _readerTextColorKey = "reader_text_color";
  static const String _readerFontSizeKey = "reader_font_size";

  final List<Color> _availableColors = const [
    Color(0xFF1C2541),
    Color(0xFF2B2D42),
    Color(0xFF0F766E),
    Color(0xFF3A0CA3),
    Color(0xFF9D0208),
  ];

  Color _selectedColor = const Color(0xFF1C2541);
  double _fontSize = 25;
  bool _loadingPrefs = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          0,
          MediaQuery.of(context).size.width * 0.05,
          8,
        ),
        child: BottomMenu(currentIndex: 2),
      ),
      appBar: AppBar(
        title: const Text("Configuración"),
      ),
      body: _loadingPrefs
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _buildCard(
                  title: "Personalización de lectura",
                  icon: Icons.palette_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Color del texto",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _availableColors.map((color) {
                          final selected = color.value == _selectedColor.value;
                          return GestureDetector(
                            onTap: () => _saveColor(color),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: selected
                                  ? const Icon(Icons.check,
                                      size: 18, color: Colors.white)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Tamaño del texto: ${_fontSize.toStringAsFixed(0)}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Slider(
                        min: 16,
                        max: 38,
                        divisions: 11,
                        value: _fontSize,
                        onChanged: (value) {
                          setState(() => _fontSize = value);
                        },
                        onChangeEnd: _saveFontSize,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Vista previa de lectura bíblica",
                          style: TextStyle(
                            color: _selectedColor,
                            fontSize: _fontSize,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  title: "Cuenta",
                  icon: Icons.manage_accounts_outlined,
                  child: FutureBuilder<Widget>(
                    future: _buildLogoutBtn(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text("Err");
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) return snapshot.data!;
                      return const Text("No Data");
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E9FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4F46E5)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_readerTextColorKey);
    final fontValue = prefs.getDouble(_readerFontSizeKey);
    if (!mounted) return;
    setState(() {
      if (colorValue != null) {
        _selectedColor = Color(colorValue);
      }
      _fontSize = fontValue ?? 25;
      _loadingPrefs = false;
    });
  }

  Future<void> _saveColor(Color color) async {
    setState(() {
      _selectedColor = color;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_readerTextColorKey, color.value);
  }

  Future<void> _saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_readerFontSizeKey, size);
  }

  Future<Widget> _buildLogoutBtn() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool isAuthenticated = await authProvider.isUserAuthenticated();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: isAuthenticated
          ? GestureDetector(
              onTap: () async {
                final pro = Provider.of<AuthProvider>(context, listen: false);
                await pro.signout();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cerrar Sesion",
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    ),
                  ],
                ),
              ),
            )
          : GestureDetector(
              onTap: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Iniciar Sesion",
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
