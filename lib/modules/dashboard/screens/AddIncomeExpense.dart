import 'dart:convert';

import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../config/config.dart';
import '../../../controller/AddIncomeExpesneController.dart';
import '../../../utils/ui/CurvedRectangle.dart';
import '../../../utils/ui/CurvedRectangleDropdown.dart';
import '../../../utils/ui/CustomButton.dart';
import 'package:http/http.dart' as http;

import '../../../utils/ui/DropDownWidget.dart';

class AddIncomeExpense extends StatefulWidget {
  final token;

  const AddIncomeExpense({Key? key,
    @required this.token
  }) : super(key: key);

  @override
  State<AddIncomeExpense> createState() => _AddIncomeExpenseState();
}

class _AddIncomeExpenseState extends State<AddIncomeExpense>
    with TickerProviderStateMixin {
  final AddIncomeExpenseController controller = Get.find();

  final TextEditingController _payment_methodEx  = TextEditingController();
  final TextEditingController _transactionIn = TextEditingController();
  final TextEditingController _categoryIn = TextEditingController();
  final TextEditingController _amountIn = TextEditingController();
  final TextEditingController _currencyIn = TextEditingController();
  final TextEditingController _payment_methodIn = TextEditingController();
  final TextEditingController _transactionEx = TextEditingController();
  final TextEditingController _categoryEx = TextEditingController();
  final TextEditingController _amountEx = TextEditingController();
  final TextEditingController _currencyEx = TextEditingController();

  int _selectedIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);
  @override
  late String userId;

  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];

  }

  void addExpense() async {
    String transaction = _transactionEx.text;
    String category = _categoryEx.text;
    String currency = _currencyEx.text;
    String paymentMethod = _payment_methodEx.text;

    // Parse amount as an integer
    int amount;
    try {
      amount = int.parse(_amountEx.text);
    } catch (e) {
      // Handle invalid input (e.g., non-integer input)
      print("Invalid amount input");
      return;
    }

    if (paymentMethod.isNotEmpty && transaction.isNotEmpty && category.isNotEmpty
        && currency.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "transaction": transaction,
        "category": category,
        "expense": amount, // Use the parsed integer value here
        "currency": currency,
        "payment_method": paymentMethod
      };

      var response = await http.post(Uri.parse(createExpense),
        headers : {"Content-type" : "application/json"},
        body : jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        _transactionEx.clear();
        _categoryEx.clear();
        _currencyEx.clear();
        _amountEx.clear();
        _payment_methodEx.clear();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Expense Added Successfully"),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        print("Something went wrong");
      }
    }
  }

  void addIncome() async {
    String transaction = _transactionIn.text;
    String category = _categoryIn.text;
    String currency = _currencyIn.text;
    String paymentMethod = _payment_methodIn.text;

    // Parse amount as an integer
    int amount;
    try {
      amount = int.parse(_amountIn.text);
    } catch (e) {
      // Handle invalid input (e.g., non-integer input)
      print("Invalid amount input");
      return;
    }

    if (paymentMethod.isNotEmpty && transaction.isNotEmpty && category.isNotEmpty
        && currency.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "transaction": transaction,
        "category": category,
        "income": amount, // Use the parsed integer value here
        "currency": currency,
        "payment_method": paymentMethod
      };

      var response = await http.post(Uri.parse(createIncome),
        headers : {"Content-type" : "application/json"},
        body : jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        _transactionIn.clear();
        _categoryIn.clear();
        _currencyIn.clear();
        _amountIn.clear();
        _payment_methodIn.clear();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Income Added Successfully"),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        print("Something went wrong");
      }
    }
  }

  Widget build(BuildContext context) {
    Get.put(AddIncomeExpenseController()); // Assuming AddIncomeExpenseController is the correct name

    var size = MediaQuery.of(context).size;
    var sizeHeight = size.height;
    var sizeWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black, // Custom app bar color
        title: const Text(
          'Income and Expense',
          style: TextStyle(color: Colors.white), // App bar text color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14,10,14,10),
        child: Column(
          children: [
            // TabBar for navigation
            TabBar(
              tabs: const [
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
              controller: TabController(
                length: 2,
                vsync: this,
                initialIndex: _selectedIndex,
              ),
              onTap: (index) {
                // Handle tab selection
                setState(() {
                  _selectedIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              labelColor: Colors.deepPurple, // Active tab text color
              indicatorColor: Colors.deepPurple, // Active tab underline color
              unselectedLabelColor: Colors.grey, // Inactive tab text color
            ),
            // PageView for content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  // Handle page change
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // Income page content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Use CurvedRectangleTextField with custom colors
                        CurvedRectangleTextField(
                          controller : _transactionIn,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Transaction',
                          backgroundColor: AppConstantsColors.incomeTextfield, // Custom text field background color with transparency
                          textColor: Colors.white, // Text color
                        ),
                        // CurvedRectangleTextField(
                        //     controller : _categoryIn,
                        //     width: sizeWidth * 0.92,
                        //     height: sizeHeight * 0.06,
                        //   text: 'Category',
                        //   backgroundColor: AppConstantsColors.incomeTextfield,
                        //   textColor: Colors.white,
                        //     // keyboardType: TextInputType.number
                        // ),
                        Container(
                              width: sizeWidth * 0.92,
                              height: sizeHeight * 0.06,
                              // height : 100,

                              child: DropDownWidget(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ),
                                  BoxShadow(
                                    color: AppConstantsColors.whiteColor,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                controller: controller,
                                dropdownList: controller.categoryIncomeList,
                                isValueSelected: controller
                                    .isSelectedCatIncomeType.value,
                                selectedValue: controller
                                    .selectedCatIncomeType.value,
                                onValueChanged:
                                controller.onValueChanged,

                              ),

                            ),
                        CurvedRectangleTextField(
                          controller : _amountIn,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Amount',
                          keyboardType: TextInputType.number,
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CurvedRectangleTextField(
                          controller : _currencyIn,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Currency',
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CurvedRectangleTextField(
                          controller : _payment_methodIn,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Payment method',
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CustomButton(
                          text: 'Add Income',
                          onPressed: ()=> {
                            // registerUser(),
                            addIncome(),
                          },
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                        ),
                      ],
                    ),
                  ),
                  // Expense page content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Use CurvedRectangleTextField with custom colors
                        CurvedRectangleTextField(
                          controller : _transactionEx,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Transaction',
                          backgroundColor: AppConstantsColors.incomeTextfield, // Custom text field background color with transparency
                          textColor: Colors.white, // Text color
                        ),
                        SizedBox(
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          // height : 100,
                          child: DropDownWidget(
                            boxShadow: const [
                              BoxShadow(
                                // color: Colors.black26,
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                              BoxShadow(
                                color: AppConstantsColors.whiteColor,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                            controller: controller,
                            dropdownList: controller.categoryExpenseList,
                            isValueSelected: controller
                                .isSelectedCatExpenseType.value,
                            selectedValue: controller
                                .selectedExpenseType.value,
                            onValueChanged:
                            controller.onValueChanged,
                          ),
                        ),

                        CurvedRectangleTextField(
                          controller : _amountEx,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Amount',
                          keyboardType: TextInputType.number,
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CurvedRectangleTextField(
                          controller : _currencyEx,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Currency',
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CurvedRectangleTextField(
                          controller : _payment_methodEx,
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                          text: 'Payment method',
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                        ),
                        CustomButton(
                          text: 'Add Expense',
                          onPressed: ()=> {
                            // registerUser(),
                            addExpense(),

                          },
                          width: sizeWidth * 0.92,
                          height: sizeHeight * 0.06,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

