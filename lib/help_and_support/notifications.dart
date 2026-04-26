import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Notifications extends StatefulWidget {
  Notifications({super.key});

  bool orderconfirmationIsOn = false;
  bool orderShippedIsOn = false;
  bool deliveryUpdatesIsOn = false;
  bool outOfStockAlertsIsOn = false;
  bool weeklyDiscountsIsOn = false;
  bool exclusiveDealsIsOn = false;
  bool seasonalCampaignsIsOn = false;
  bool cartRemindersIsOn = false;
  bool paymentBillingUpdatesIsOn = false;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Order & Delivery Updates",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SwitchListTile(
              title: Text("Order Confirmation"),
              value: widget.orderconfirmationIsOn,
              onChanged: (value) {
                setState(() {
                  widget.orderconfirmationIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Order Shipped"),
              value: widget.orderShippedIsOn,
              onChanged: (value) {
                setState(() {
                  widget.orderShippedIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Delivery Updates"),
              value: widget.deliveryUpdatesIsOn,
              onChanged: (value) {
                setState(() {
                  widget.deliveryUpdatesIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Out of Stock Alerts"),
              value: widget.outOfStockAlertsIsOn,
              onChanged: (value) {
                setState(() {
                  widget.outOfStockAlertsIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Deals & Promotions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SwitchListTile(
              title: Text("Weekly Discounts"),
              value: widget.weeklyDiscountsIsOn,
              onChanged: (value) {
                setState(() {
                  widget.weeklyDiscountsIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Exclusive Member Offers"),
              value: widget.exclusiveDealsIsOn,
              onChanged: (value) {
                setState(() {
                  widget.exclusiveDealsIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Seasonal Campaigns"),
              value: widget.seasonalCampaignsIsOn,
              onChanged: (value) {
                setState(() {
                  widget.seasonalCampaignsIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Account & Reminders",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SwitchListTile(
              title: Text("Cart Reminders"),
              value: widget.cartRemindersIsOn,
              onChanged: (value) {
                setState(() {
                  widget.cartRemindersIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
            SwitchListTile(
              title: Text("Payment & Billing Updates"),
              value: widget.paymentBillingUpdatesIsOn,
              onChanged: (value) {
                setState(() {
                  widget.paymentBillingUpdatesIsOn = value;
                });
              },
              activeTrackColor: Color(0xff014162),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
