import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/views/History/controller_location.dart';
import 'package:loan_application_admin/widgets/custom_text.dart';
import 'package:loan_application_admin/widgets/dropdownfilter.dart';
import 'package:loan_application_admin/widgets/filtersection.dart';

void showFilterBottomSheet(
    BuildContext context, Function(String) onFilterSelected) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        String selectedDate = '';
        String selectedLocation = '';
        final locationController = Get.put(LocationController());

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
                    offset: Offset(0, -3),
                  )
                ],
              ),
              child: Column(
                children: [
                  // Drag Indicator
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.black),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Filter Data',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48), // Untuk mengimbangi posisi ikon close
                    ],
                  ),

                  Divider(height: 20),

                  // Content
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Date Picker
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate =
                                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDate.isEmpty
                                      ? "Pilih Tanggal"
                                      : selectedDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: selectedDate.isEmpty
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                Icon(Icons.calendar_today_rounded,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        // Opsi tanggal cepat
                        FilterSection(
                          title: 'Opsi Tanggal',
                          options: [
                            'Hari ini',
                            'Kemarin',
                            'Minggu ini',
                            'Bulan ini',
                          ],
                          selectedOption: selectedDate,
                          onOptionSelected: (value) {
                            setState(() => selectedDate = value);
                          },
                        ),
                        SizedBox(height: 24),
                        // Dropdown lokasi berjenjang
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownFilter(
                                  title: "Provinsi",
                                  items: locationController.provinces,
                                  value: locationController
                                          .selectedProvinceId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedProvinceId.value,
                                  labelKey: 'province',
                                  idKey: 'pro_idn',
                                  onChanged: (val) {
                                    locationController.selectedProvinceId.value =
                                        val!;
                                    locationController.fetchRegencies(val);
                                  }),
                              if (locationController.regencies.isNotEmpty)
                                DropdownFilter(
                                    title: "Kabupaten",
                                    items: locationController.regencies,
                                    value: locationController
                                            .selectedRegencyId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedRegencyId.value,
                                    labelKey: 'region',
                                    idKey: 'reg_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedRegencyId.value = val!;
                                      locationController.fetchDistricts(val);
                                    }),
                              if (locationController.districts.isNotEmpty)
                                DropdownFilter(
                                    title: "Kecamatan",
                                    items: locationController.districts,
                                    value: locationController
                                            .selectedDistrictId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedDistrictId.value,
                                    labelKey: 'sector',
                                    idKey: 'sec_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedDistrictId.value = val!;
                                      locationController.fetchVillages(val);
                                    }),
                              if (locationController.villages.isNotEmpty)
                                DropdownFilter(
                                    title: "Desa",
                                    items: locationController.villages,
                                    value: locationController
                                            .selectedVillageId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedVillageId.value,
                                    labelKey: 'village',
                                    idKey: 'vil_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedVillageId.value = val!;
                                    }),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = '';
                                selectedLocation = '';
                                locationController.resetAll();
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.lightBlue),
                              foregroundColor: AppColors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('Atur Ulang'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedDate.isNotEmpty) {
                                onFilterSelected('DATE:$selectedDate');
                              }
                              if (locationController.selectedVillageId.value
                                  .isNotEmpty) {
                                selectedLocation = locationController
                                    .selectedVillageId.value;
                                onFilterSelected(
                                    'LOCATION:$selectedLocation');
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('Terapkan'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}

