import 'package:flutter/material.dart';
class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}
class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'choose delivery';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['choose delivery', 'TradeHub delivery', 'Sinzu delivery', 'Bq delivery']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            );
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   'Selected Value: $dropdownValue',
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // )
          
        
      
  
  }
}