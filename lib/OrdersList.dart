import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:rt/login.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  Timer? _timer;
  bool showNew = false;
  bool showOthers = false;
  List<dynamic> newOrders = [];
  List<dynamic> otherOrders = [];

  void showLanguageDialog(BuildContext context) {
    String selectedLanguage = 'English';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedLanguage = 'Arabic';
                  });
                  Navigator.of(context).pop();
                },
                child: Text('لغة عربية'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedLanguage = 'English';
                  });
                  Navigator.of(context).pop();
                },
                child: Text('English'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                print('Selected Language: $selectedLanguage');
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(Duration(minutes: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  Future<void> fetchOrders(String type) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.example.com/orders?type=$type'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (type == 'new') {
          setState(() {
            newOrders = data;
          });
        } else if (type == 'others') {
          setState(() {
            otherOrders = data;
          });
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders List'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              showLanguageDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _resetTimer();
                  fetchOrders('new');
                  setState(() {
                    showNew = true;
                    showOthers = false;
                  });
                },
                child: Text('New Orders'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resetTimer();
                  fetchOrders('others');
                  setState(() {
                    showNew = false;
                    showOthers = true;
                  });
                },
                child: Text('Other Orders'),
              ),
            ],
          ),
          Expanded(
            child: showNew
                ? ListView.builder(
                    itemCount: newOrders.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Order #${newOrders[index]['id']}'),
                        subtitle: Text('Status: ${newOrders[index]['status']}'),
                      );
                    },
                  )
                : showOthers
                    ? ListView.builder(
                        itemCount: otherOrders.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Order #${otherOrders[index]['id']}'),
                            subtitle:
                                Text('Status: ${otherOrders[index]['status']}'),
                          );
                        },
                      )
                    : Center(
                        child: Text('No orders to display'),
                      ),
          ),
        ],
      ),
    );
  }
}
