import "dart:convert";

import "package:get_it/get_it.dart";

import "../model/holiday_model.dart";
import "../service/holidays_service.dart";

class HolidaysRepository {
  final HolidayServiceApi service = GetIt.I.get<HolidayServiceApi>();

  Future<List<HolidayModel>> fetchData({required int year, String state = ""}) async{
    final response = await service.getHolidays(year: year, state: state);
    List<dynamic> jsonList = jsonDecode(response.body);

    return [for (final item in jsonList) HolidayModel.fromJson(item)];
  }
}