import "dart:convert";

import "package:get_it/get_it.dart";

import "../../utils/params.dart";
import "../model/holiday_model.dart";
import "../service/holidays_service.dart";
import "repository.dart";

class HolidaysRepository implements Repository<HolidayModel, FeriadosNacionaisParams>{
  final HolidayServiceApi service = GetIt.I.get<HolidayServiceApi>();

  @override
  Future<List<HolidayModel>> fetchData(FeriadosNacionaisParams params) async{
    final response = await service.getAll(params);
    List<dynamic> jsonList = jsonDecode(response.body);

    return [for (final item in jsonList) HolidayModel.fromJson(item)];
  }
}