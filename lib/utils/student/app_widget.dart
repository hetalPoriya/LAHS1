import 'package:flutter/material.dart';
import 'package:little_angels/Controller/todaysWorkController.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:intl/intl.dart';

class AppWidgets {
  static Widget todaysWorkContainer(
          {required String subjectName, required String description}) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${subjectName}",
                style: TextStyle(
                    color: Colors.grey.shade600, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                // "(${todaysWorkController.todayWork[i].})",
                "(Sunita mam)",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                // "(${todaysWorkController.todayWork[i].})",
                "5h ago",
                style: TextStyle(color: Colors.grey, fontSize: 8.0),
              ),
            ],
          ),
          smallSizedBox,
          Text(
            "${description}",
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            textAlign: TextAlign.start,
          )
        ]),
      );

  static Widget elevatedButtonForCalender({required DateTime selectedDay}) =>
      CustomElevatedButton(
        endColor: Colors.blue,
        beginColor: Colors.blue,
        height: 45.0,
        width: double.infinity,
        onPressed: () {},
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('EEEE').format(selectedDay).toString()),
            Text(DateFormat('dd MMM yyyy').format(selectedDay).toString()),
          ],
        ),
      );
}
