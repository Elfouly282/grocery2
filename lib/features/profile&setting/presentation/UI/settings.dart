import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/features/profile&setting/data/logic/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedValue = 'en';

  List<DropdownMenuItem<String>> items() {
    return [
      const DropdownMenuItem(child: Text('English (US)'), value: 'en'),
      const DropdownMenuItem(child: Text('Arabic'), value: 'ar'),
    ];
  }

  void onchange(String? value) {
    if (value != null) {
      setState(() {
        selectedValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey.shade900 : Colors.white;
    final borderColor =
        isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- قسم اللغة ---
            Text('Language',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferred Language',
                      style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey)),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: items(),
                      onChanged: onchange,
                      value: selectedValue,
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: textColor),
                      dropdownColor: cardColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- قسم المظهر (Appearance) ---
            Text('Appearance',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 10),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDarkMode = themeMode == ThemeMode.dark;
                return Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: SwitchListTile(
                    title: Text('Dark Mode', style: TextStyle(color: textColor)),
                    secondary:
                        Icon(Icons.wb_sunny_outlined, color: textColor),
                    value: isDarkMode,
                    activeColor: const Color(0xFF003358),
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // --- قسم إدارة البيانات (Data Management) ---
            Text('Data Management',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  // بطاقة تحميل البيانات
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    tileColor: isDark
                        ? Colors.grey.shade800
                        : Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: Text('Download Your Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor)),
                    subtitle: Text(
                        'Get a copy of your account information',
                        style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey)),
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.red.shade900
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.red.shade100),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline,
                              color: Colors.red),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: const [
                              Text('Delete Account',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              FittedBox(
                                child: Text(
                                    'Permanently delete \nyour account and data',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 11)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}