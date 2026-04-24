import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  HelpAndSupport({super.key});

  final List<String> helpAndSupportOptions = [
    "FAQs",
    "Contact Custoemer Support",
    "Terms and Conditions",
    "Privacy Policy",
    "About Grocery Plus",
    "App Version: 1.0.5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          child: ListView(
            children: [
              ListTile(
                title: const Text("FAQs"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: const Text("Contact Customer Support"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: const Text("Terms and Conditions"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: const Text("Privacy Policy"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: const Text("About Grocery Plus"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: const Text("App Version: 1.0.5"),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
