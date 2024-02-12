import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_1/main.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            // Image
            Center(
              child: Image.asset(
                'assets/imgs/bibliotheque.jpg',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Home page content
            Text(
              'Bienvenu sur notre app de gestion de médias !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 14, 81, 227),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Baladez-vous parmis des dizaines de séries, livres et films',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 40),
            // Developers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDeveloperInfo(
                  'Martin Delsart',
                  'assets/imgs/martin_delsart.jpg',
                ),
                SizedBox(width: 40),
                _buildDeveloperInfo(
                  'Géry Bellanger',
                  'assets/imgs/gery_bellanger.jpeg',
                ),
              ],
            ),
            SizedBox(height: 40),
            // Contact information
            _buildContactInfo(Icons.phone, 'Contact us: +33 06 36 30 36 30 '),
            _buildContactInfo(Icons.mail, 'Email: gery_et_martin@gmail.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperInfo(String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
