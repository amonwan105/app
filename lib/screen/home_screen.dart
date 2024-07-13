import 'dart:convert';

import 'package:app/config/app.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> banners = [];
  Future<void> Fecthbanner() async {
    try {
      final respond = await http.get(Uri.parse('${API_URL}/api/banners'));
      final banners = jsonDecode(respond.body);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    Fecthbanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Swiper(
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Image.network(
                    "${API_URL}/${banners[index]['imageUrl']}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
