import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String title;
  final List items;
  final String? value;
  final String labelKey;
  final String idKey;
  final Function(String?) onChanged;

  const DropdownFilter({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.labelKey,
    required this.idKey,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildDropdown(
      title: title,
      items: items,
      value: value,
      labelKey: labelKey,
      idKey: idKey,
      onChanged: onChanged,
    );
  }

  static Widget buildDropdown({
    required String title,
    required List items,
    required String? value,
    required String labelKey,
    required String idKey,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: items.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item[idKey].toString(),
                child: Text(item[labelKey]),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
