import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),

            Center(
              child: Image.asset(
                'assets/imgs/bibliotheque.jpg',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Bienvenue sur notre app de gestion de médias !',
              textAlign: TextAlign.center,
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
                'Baladez-vous parmi des dizaines de séries, livres et films',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 60),

            Text(
              'Notre équipe de développeurs :',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

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
            _buildContactInfo(Icons.phone, 'Contact: +33 06 36 30 36 30 '),
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
          Icon(icon, color: Color.fromARGB(255, 14, 81, 227)),
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
