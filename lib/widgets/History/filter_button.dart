import 'package:flutter/material.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/widgets/History/showfilterbuttom.dart';

class FilterButtons extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({required this.onFilterSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 5),
                _buildButton('ALL'),
                const SizedBox(width: 5),
                _buildButton('ACCEPTED'),
                const SizedBox(width: 5),
                _buildButton('DECLINED'),
                const SizedBox(width: 5),
                _buildButton('UNREAD'),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
            onPressed: () => showFilterBottomSheet(context, onFilterSelected),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pureWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12), // biar tombol nggak terlalu kecil
            ),
            child: Icon(
              Icons.filter_list_alt,
              size: 25,
              color: AppColors.blackLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 109,
      child: ElevatedButton(
        onPressed: () => onFilterSelected(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pureWhite,
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
