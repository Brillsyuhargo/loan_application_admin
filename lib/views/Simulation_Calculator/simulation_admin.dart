import 'package:flutter/material.dart';
import 'package:loan_application_admin/core/theme/color.dart';
class SimulationAdmin extends StatelessWidget {
  const SimulationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Center(
        child: Text('Calculator'),
      ),
    );
  }
}