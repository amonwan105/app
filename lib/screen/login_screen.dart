import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> checkLogin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    Navigator.of(context).popAndPushNamed("/home");
  }

  Future<void> login() async {
    final resonse = await http.post(
      Uri.parse('${API_URL}/api/auth/login'),
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        'email': _email.text,
        'password': _password.text,
      }),
    );

    print(resonse.body);

    if (resonse.statusCode == 200) {
      // final prefs = await _prefs;
      // await prefs.setString('token', jsonDecode(resonse.body)['token']);
      Navigator.of(context).popAndPushNamed("/home");
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // checkLogin();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('โปรดเข้าสู่ระบบ'),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'อีเมล'),
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text('เข้าสู่ระบบ')),
          ],
        ),
      ),
    );
  }
}

class _password {}
