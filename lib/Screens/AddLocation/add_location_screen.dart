import 'package:flutter/material.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                hintText: 'Enter your Name',
                hintStyle: TextStyle(color: Colors.teal))),
        const SizedBox(height: 16),
      ],
    );
  }
}
