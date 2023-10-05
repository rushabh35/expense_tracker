import 'package:expense_tracker/constants/app_constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../utils/ui/CurvedRectangle.dart';
import '../../../utils/ui/CurvedRectangleDropdown.dart';
import '../../../utils/ui/CustomButton.dart';

class AddIncomeExpense extends StatefulWidget {
  final token;

  const AddIncomeExpense({Key? key, this.token}) : super(key: key);

  @override
  State<AddIncomeExpense> createState() => _AddIncomeExpenseState();
}

class _AddIncomeExpenseState extends State<AddIncomeExpense>
    with TickerProviderStateMixin {


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
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  }

  void addExpense() async {

  }
  Widget build(BuildContext context) {

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
                        CurvedRectangleTextField(
                            controller : _categoryIn,
                            width: sizeWidth * 0.92,
                            height: sizeHeight * 0.06,
                          text: 'Category',
                          backgroundColor: AppConstantsColors.incomeTextfield,
                          textColor: Colors.white,
                            keyboardType: TextInputType.number
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
                        CurvedRectangleTextField(
                            controller : _categoryEx,
                            width: sizeWidth * 0.92,
                            height: sizeHeight * 0.06,
                            text: 'Category',
                            backgroundColor: AppConstantsColors.incomeTextfield,
                            textColor: Colors.white,
                            keyboardType: TextInputType.number
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

