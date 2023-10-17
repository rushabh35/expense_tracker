import 'package:expense_tracker/models/categoryIncomeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/categoryExpenseModel.dart';
class CategoryModel {
  final int id;
  final String name;

  CategoryModel(this.id, this.name);
}
class AddIncomeExpenseController extends GetxController {

  RxList<CatExpenseModel?> categoryExpenseList = <CatExpenseModel>[
    CatExpenseModel(id: 1, name: "Foods and groceries"),
    CatExpenseModel(id: 2, name: "Medicines"),
    CatExpenseModel(id: 3, name: "Lifestyle"),
    CatExpenseModel(id: 4, name: "Rents"),
    CatExpenseModel(id: 5, name: "Others"),
  ].obs;
  Rx<String> selectedExpenseType = 'Select Category'.obs;
  Rx<bool> isSelectedCatExpenseType = true.obs;
  int selectedCatExpenseTypeId = 0;


  RxList<CatIncomeModel?> categoryIncomeList = <CatIncomeModel>[
    CatIncomeModel(id: 1, name: "Job"),
    CatIncomeModel(id: 2, name: "Business"),
    CatIncomeModel(id: 3, name: "Freelancing"),
    CatIncomeModel(id: 4, name: "Rental Incomes"),
    CatIncomeModel(id: 5, name: "Others"),

  ].obs;
  Rx<String> selectedCatIncomeType = 'Select Category'.obs;
  Rx<bool> isSelectedCatIncomeType = true.obs;
  int selectedCatIncomeTypeId = 0;

  void onValueChanged(RxList<CategoryModel?> list, String value) {
    int index = list.indexWhere((x) => x?.name == value);
    if (index >= 0) {
      if (list is RxList<CatIncomeModel?>) {
        selectedCatIncomeTypeId = list[index]?.id ?? 0;
        selectedCatIncomeType.value = value;
      } else if (list is RxList<CatExpenseModel?>) {
        selectedCatExpenseTypeId = list[index]?.id ?? 0;
        selectedExpenseType.value = value;
      }
    }
  }
  // void onValueChanged(dynamic list, dynamic value) {
  //   switch (list.runtimeType) {
  //     case   const (RxList<CatIncomeModel>):
  //       {
  //         int Index = categoryIncomeList.indexWhere((x) => x?.name == value);
  //         selectedCatIncomeTypeId = categoryIncomeList[Index]?.id ?? 0;
  //         selectedCatIncomeType.value = value;
  //       }
  //       break;
  //       // case   const (RxList<CatExpenseModel>):
  //       //   {
  //       //     int Index = categoryExpenseList.indexWhere((x) => x?.name == value);
  //       //     selectedCatExpenseTypeId = categoryExpenseList[Index]?.id ?? 0;
  //       //     selectedExpenseType.value = value;
  //       //   }
  //       //   break;
  //     default:
  //       {
  //         //statements;
  //       }
  //       break;
  //   }
  // }

}