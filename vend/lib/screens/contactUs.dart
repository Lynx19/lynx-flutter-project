import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import '../widget/app_drawer.dart';
class ContactUsPage extends StatelessWidget {
  static const routeName = '/contactUs';
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        backgroundColor:Colors.purple,
      ),
      drawer:
      AppDrawer(),
      backgroundColor: Colors.white,
      body: ContactUs(
        textColor: Colors.white,
        logo: AssetImage('images/crop.jpg'),
        email: 'adoshi26.ad@gmail.com',
        companyName: 'VendorApp',
        phoneNumber: '09065587984',
        dividerThickness: 2,
        website: 'https://abhishekdoshi.godaddysites.com',
        githubUserName: 'AbhishekDoshi26',
        linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
        tagLine: 'Here to help',
        twitterHandle: 'AbhishekDoshi26', 
        cardColor: Colors.purple,
        companyColor: Colors.purple.shade300, 
        taglineColor: Colors.purple.shade200,
        // instagramUserName: '_abhishek_doshi',
      ),
    );
  }
}
