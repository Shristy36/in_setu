part of 'man_power_bloc.dart';

abstract class ManPowerEvet{
  ManPowerEvet();
}

class ManPowerItemFetch extends ManPowerEvet{
  dynamic siteId;
  String? currentDate;
  ManPowerItemFetch({required this.siteId, this.currentDate});
}

// New event: ONLY fetch manpower for selected date
class ManPowerFetchByDate extends ManPowerEvet {
  final dynamic siteId;
  final String selectedDate;

  ManPowerFetchByDate({required this.siteId, required this.selectedDate});
}

class CreateManPowerItemFetch extends ManPowerEvet{
  dynamic siteId;
  String agencyName;
  List<Map<String, String>> staffs;
  List<Map<String, String>> manPowers;
  List<Map<String, String>> tasks;
  CreateManPowerItemFetch({required this.siteId, required this.agencyName, required this.staffs, required this.manPowers, required this.tasks});
}

class DeleteManPowerItemFetch extends ManPowerEvet{
  dynamic id;
  DeleteManPowerItemFetch({required this.id});
}

class UpdateManPowerItemFetch extends ManPowerEvet{
  dynamic id;
  dynamic siteId;
  String agencyName;
  List<Map<String, String>> staffs;
  List<Map<String, String>> manPowers;
  List<Map<String, String>> tasks;
  UpdateManPowerItemFetch({required this.id, required this.siteId, required this.agencyName, required this.staffs, required this.manPowers, required this.tasks});

}