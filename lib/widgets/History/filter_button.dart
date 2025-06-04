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
        // Bagian tombol scrollable horizontal
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8), // Padding awal
                _buildButton(
                  'All',
                  backgroundColor: AppColors.royalBlue,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'APPROVED',
                  backgroundColor: AppColors.greenstatus,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'PROGRESS',
                  backgroundColor: AppColors.orangestatus,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'DECLINED',
                  backgroundColor: AppColors.redstatus,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),

        // Tombol filter icon
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => showFilterBottomSheet(context, onFilterSelected),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pureWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Icon(Icons.filter_list_alt,
              size: 25, color: AppColors.blackLight),
        ),
      ],
    );
  }

  Widget _buildButton(String text,
      {Color? backgroundColor, Color? foregroundColor}) {
    return ElevatedButton(
      onPressed: () => onFilterSelected(text),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? AppColors.pureWhite, // Fallback ke pureWhite
        foregroundColor:
            foregroundColor ?? AppColors.pureWhite, // Fallback ke black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
