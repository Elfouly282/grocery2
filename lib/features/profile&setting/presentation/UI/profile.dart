import 'package:flutter/material.dart';
import 'package:grocery2/core/constants/app_color.dart';
import 'package:grocery2/features/profile&setting/presentation/UI/settings.dart';
import 'package:grocery2/features/profile&setting/presentation/widgets/custom_list_tile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avatarBgColor =
        isDark ? Colors.grey.shade800 : const Color(0xFFEBEBF2);
    final textColor = isDark ? Colors.white : AppColor.text;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: avatarBgColor,
                child: Icon(Icons.person_outline_sharp,
                    size: 60, color: textColor),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Edit Profile Photo',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              ),
            ),
            customListTile(
                context: context,
                icon: const Icon(Icons.person_outline_outlined),
                title: const Text('Personal details'),
                onTap: () {}),
            const SizedBox(height: 10),
            customListTile(
                context: context,
                icon: const Icon(Icons.location_on_outlined),
                title: const Text('Delivery Address'),
                onTap: () {}),
            const SizedBox(height: 10),
            customListTile(
                context: context,
                icon: const Icon(Icons.notifications_none),
                title: const Text('Notifications Allowed'),
                onTap: () {}),
            const SizedBox(height: 10),
            customListTile(
                context: context,
                icon: const Icon(Icons.wallet),
                title: const Text('Payment Methods'),
                onTap: () {}),
            const SizedBox(height: 10),
            customListTile(
                context: context,
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                }),
            const SizedBox(height: 10),
            customListTile(
                context: context,
                icon: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                onTap: () {}),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: suffixIcon(context: context, icon: const Icon(Icons.logout)),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

