import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loan_application_admin/API/service/get_location.dart';
import 'package:loan_application_admin/widgets/History/dropdownfilter.dart';

class ControllerHistory extends GetxController {
  // Date filtering
  RxString selectedDate = ''.obs;
  RxString selectedDateText = ''.obs;
  Rx<DateTime> startDate = DateTime.now().obs;

  // Location filtering
  var provinces = [].obs;
  var regencies = [].obs;
  var districts = [].obs;
  var villages = [].obs;

  var selectedProvinceId = ''.obs;
  var selectedRegencyId = ''.obs;
  var selectedDistrictId = ''.obs;
  var selectedVillageId = ''.obs;
  RxString selectedLocation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    fetchProvinces();
  }

  // DATE LOGIC
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate.value = picked;
      selectedDateText.value = DateFormat('d MMMM y', 'id_ID').format(picked);
      selectedDate.value = '';
    }
  }

  void selectQuickDate(String value) {
    if (selectedDate.value == value) {
      selectedDate.value = '';
      selectedDateText.value = '';
    } else {
      selectedDate.value = value;
      selectedDateText.value = '';
    }
  }

  void resetFilter() {
    selectedDate.value = '';
    selectedDateText.value = '';
    startDate.value = DateTime.now();

    selectedProvinceId.value = '';
    selectedRegencyId.value = '';
    selectedDistrictId.value = '';
    selectedVillageId.value = '';
    selectedLocation.value = '';

    regencies.clear();
    districts.clear();
    villages.clear();
    fetchProvinces();
  }

  void submitFilterFromUI(Function(String) onFilterSelected, BuildContext context) {
    final filters = applyFilter(selectedVillageId.value);
    if (filters.isNotEmpty) {
      onFilterSelected(filters.join(';'));
    }
    Navigator.pop(context);
  }

  List<String> applyFilter(String villageId) {
    List<String> filters = [];

    if (selectedDate.value.isNotEmpty) {
      filters.add('DATE:${selectedDate.value}');
    } else if (selectedDateText.value.isNotEmpty) {
      filters.add('DATE_CUSTOM:${selectedDateText.value}');
    }

    if (villageId.isNotEmpty) {
      selectedLocation.value = villageId;
      filters.add('LOCATION:$villageId');
    }

    return filters;
  }

  // LOCATION LOGIC
  void fetchProvinces() async {
    try {
      final data = await ApiService.fetchProvinces();
      provinces.value = data;
    } catch (e) {
      print('Error fetching provinces: $e');
    }
  }

  void onSelectProvince(String val) async {
    selectedProvinceId.value = val;
    selectedRegencyId.value = '';
    selectedDistrictId.value = '';
    selectedVillageId.value = '';
    regencies.value = await ApiService.fetchRegencies(val);
    districts.clear();
    villages.clear();
  }

  void onSelectRegency(String val) async {
    selectedRegencyId.value = val;
    selectedDistrictId.value = '';
    selectedVillageId.value = '';
    districts.value = await ApiService.fetchDistricts(val);
    villages.clear();
  }

  void onSelectDistrict(String val) async {
    selectedDistrictId.value = val;
    selectedVillageId.value = '';
    villages.value = await ApiService.fetchVillages(val);
  }

  void onSelectVillage(String val) {
    selectedVillageId.value = val;
  }

  List<Widget> getDropdowns() {
    final List<Widget> widgets = [];

    widgets.add(DropdownFilter(
      title: "Provinsi",
      items: provinces,
      value: selectedProvinceId.value.isEmpty ? null : selectedProvinceId.value,
      labelKey: 'province',
      idKey: 'pro_idn',
      onChanged: (val) => onSelectProvince(val!),
    ));

    if (regencies.isNotEmpty) {
      widgets.add(DropdownFilter(
        title: "Kabupaten",
        items: regencies,
        value: selectedRegencyId.value.isEmpty ? null : selectedRegencyId.value,
        labelKey: 'region',
        idKey: 'reg_idn',
        onChanged: (val) => onSelectRegency(val!),
      ));
    }

    if (districts.isNotEmpty) {
      widgets.add(DropdownFilter(
        title: "Kecamatan",
        items: districts,
        value: selectedDistrictId.value.isEmpty ? null : selectedDistrictId.value,
        labelKey: 'sector',
        idKey: 'sec_idn',
        onChanged: (val) => onSelectDistrict(val!),
      ));
    }

    if (villages.isNotEmpty) {
      widgets.add(DropdownFilter(
        title: "Desa",
        items: villages,
        value: selectedVillageId.value.isEmpty ? null : selectedVillageId.value,
        labelKey: 'village',
        idKey: 'vil_idn',
        onChanged: (val) => onSelectVillage(val!),
      ));
    }

    return widgets;
  }

  void resetAll() {
    selectedDate.value = '';
    selectedDateText.value = '';
    startDate.value = DateTime.now();

    selectedProvinceId.value = '';
    selectedRegencyId.value = '';
    selectedDistrictId.value = '';
    selectedVillageId.value = '';

    regencies.clear();
    districts.clear();
    villages.clear();
  }
}
