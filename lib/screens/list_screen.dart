import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import 'package:trial_app/widgets/navigation_bar.dart'; 
import 'package:trial_app/services/nav_service.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> _users = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
  }

  Future<void> _fetchCompanies() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=100'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _users = (data['results'] as List)
            .map((user) =>
                '${user['name']['first']} ${user['name']['last']}' as String)
            .toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load users');
    }
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
        title: Text('List \'em all!'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://i.pinimg.com/564x/90/9a/d2/909ad238365dbdd7ee088110a24edb39.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(
                                0), 
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _users[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
