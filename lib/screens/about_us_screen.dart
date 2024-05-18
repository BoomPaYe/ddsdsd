import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<Map<String, String>> cardData = [
    {
      'name': 'Meach Pichmonireach',
      'role': 'Developer',
    },
    {
      'name': 'Ramong Leng',
      'role': 'Developer',
    },
    {
      'name': 'Lim Sonata',
      'role': 'Developer',
    },
    {
      'name': 'Khim EangChhay',
      'role': 'Developer',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Color.fromARGB(255, 237, 26, 86),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Center(
              child: Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color.fromARGB(255, 237, 26, 86)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cardData[index]['name'] ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Role: ${cardData[index]['role'] ?? ''}',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
