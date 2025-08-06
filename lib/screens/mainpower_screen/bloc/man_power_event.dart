part of 'main_power_bloc.dart';

abstract class MainPowerEvet{
  MainPowerEvet();
}

class MainPowerItemFetch extends MainPowerEvet{
  String siteId;
  String? currentDate;
  MainPowerItemFetch({required this.siteId, this.currentDate});
}
