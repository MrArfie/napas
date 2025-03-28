import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Noah’s Ark Shelter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Page Title
            Text(
              'Help Support Noah’s Ark Dog and Cat Shelter',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            // Description
            Text(
              'Your donation helps provide food, medical care, and shelter for our rescued animals. Every contribution, big or small, makes a difference!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Donation Image (optional)
            Image.asset(
              'assets/images/donation_banner.jpg', // Replace with actual image for donation banner
              height: 180,
            ),
            SizedBox(height: 20),
            // Donation Button
            ElevatedButton(
              onPressed: () {
                _showDonationMethods(context);
              },
              child: Text('Donate Now'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            // Bank and Online Payment Methods Information
            Text(
              'For direct donations, you can also send via:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.green),
              title: Text('Bank Transfer - ABC Bank'),
              subtitle: Text('Account Number: 1234-5678-9012'),
            ),
            ListTile(
              leading: Icon(Icons.mobile_friendly, color: Colors.blue),
              title: Text('Gcash & PayPal'),
              subtitle: Text('Account: noahsarkdonations@gmail.com'),
            ),
          ],
        ),
      ),
    );
  }

  // Show available donation methods as a modal bottom sheet
  void _showDonationMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Donation Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text('Bank Transfer'),
                subtitle: Text('ABC Bank - 1234-5678-9012'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement Bank Transfer action (e.g., redirect user to bank website)
                },
              ),
              ListTile(
                leading: Icon(Icons.mobile_friendly),
                title: Text('Gcash / PayPal'),
                subtitle: Text('noahsarkdonations@gmail.com'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement GCash/PayPal action (e.g., redirect to PayPal website or open GCash app)
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
