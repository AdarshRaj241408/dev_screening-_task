import 'package:flutter/material.dart';
import 'package:trial_app/widgets/navigation_bar.dart';
import 'package:trial_app/services/nav_service.dart';

class ImageSwitcherScreen extends StatefulWidget {
  @override
  _ImageSwitcherScreenState createState() => _ImageSwitcherScreenState();
}

class _ImageSwitcherScreenState extends State<ImageSwitcherScreen> {
  String imageUrl1 = 'https://i.imgur.com/Gi9cwgR.gif';
  String imageUrl2 = 'https://media1.tenor.com/m/rTohwIgEl5QAAAAd/racoon.gif';
  late String currentImageUrl;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    currentImageUrl = imageUrl1;
  }

  void _switchImage() {
    setState(() {
      currentImageUrl = (currentImageUrl == imageUrl1) ? imageUrl2 : imageUrl1;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        NavService.navigateTo('/list');
        break;
      case 1:
        NavService.navigateTo('/imageSwitcher');
        break;
      case 2:
        NavService.navigateTo('/crypto');
        break;
      case 3:
        NavService.navigateTo('/notifications');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Image Switcher'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://i.pinimg.com/564x/90/9a/d2/909ad238365dbdd7ee088110a24edb39.jpg',
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4), // Elevation effect
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      currentImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _switchImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(204, 35, 165, 216),
                    foregroundColor: Colors.grey,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Switch Image',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
