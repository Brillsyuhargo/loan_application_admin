import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/views/History/controller_history.dart';
import 'package:loan_application_admin/widgets/History/OptionChips.dart';

void showFilterBottomSheet(
    BuildContext context, Function(String) onFilterSelected) async {
  final controllerHistory = Get.put(ControllerHistory());

  await initializeDateFormatting('id_ID', null);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, -3))
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Filter Data',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                  Divider(height: 20),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Obx(() => ListTile(
                              title: Text('Calendar'),
                              subtitle: Text(
                                controllerHistory.selectedDateText.value.isNotEmpty
                                    ? controllerHistory.selectedDateText.value
                                    : DateFormat.yMMMMd('id_ID').format(
                                        controllerHistory.startDate.value),
                              ),
                              trailing: Icon(Icons.calendar_today),
                              onTap: () => controllerHistory.pickDate(context),
                            )),
                        SizedBox(height: 16),
                        Obx(() => OptionChips(
                              title: 'Opsi Tanggal',
                              options: [
                                'Hari ini',
                                'Kemarin',
                                'Minggu ini',
                                'Bulan ini'
                              ],
                              selectedOption:
                                  controllerHistory.selectedDate.value,
                              onOptionSelected:
                                  controllerHistory.selectQuickDate,
                            )),
                        SizedBox(height: 24),
                        Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controllerHistory.getDropdowns(),
                            )),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  controllerHistory.resetFilter();
                                  controllerHistory.resetAll();
                                },
                                icon: Icon(Icons.restart_alt),
                                label: Text('Atur Ulang'),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: AppColors.lightBlue),
                                  foregroundColor: AppColors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  controllerHistory.submitFilterFromUI(
                                      onFilterSelected, context);
                                },
                                icon: Icon(Icons.check),
                                label: Text('Terapkan'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lightBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
