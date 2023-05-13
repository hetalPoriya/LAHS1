import 'package:flutter/material.dart';
import 'package:little_angels/utils/colors.dart';

class CustomDropDown extends StatelessWidget {
  var items;
  final selectedValue;
  final String hintText;
  final Function(dynamic)? onChanged;

  CustomDropDown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hintText = '',
  }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration:const BoxDecoration(gradient: LinearGradient(colors: [])),
      child: DropdownButtonFormField(
        items: items,
        hint: Text(hintText),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: ColorConstants.kBlackColor,
        ),
        decoration: InputDecoration(
          focusColor: Colors.white,
          contentPadding: const EdgeInsets.all(12.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        value: selectedValue,
        onChanged: onChanged,
      ),
    );
  }
}