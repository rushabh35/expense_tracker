import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({Key? key, @required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  late String email;

  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(email),
    );
  }
}
