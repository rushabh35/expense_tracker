import 'package:expense_tracker/modules/dashboard/screens/AddIncomeExpense.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../constants/app_constants_colors.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text('Hello, Flutter!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator
              .of(context).push(MaterialPageRoute(
              builder: (context) => const AddIncomeExpense()));
        },
        backgroundColor: AppConstantsColors.brightWhiteColor,

        child: const Icon(
          Icons.add,
          color: Colors.black, // Set the color to white
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );

  }
}
