
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:weather_app/weather.dart';


final cityNameProvider = StateProvider((ref) => 'Tokyo');
final repositoryProvider = Provider((ref) => Repository());
final dataProvider= FutureProvider.autoDispose((ref) async{
  final repository = ref.read(repositoryProvider);
  final cityName = ref.watch(cityNameProvider.notifier);
  return await repository.fetchWeather(cityName.state);
});



late final WeatherMain weatherMain;


class WeatherApiClient {
  Future<Weather?> fetchWeather(String? location) async {
    final dio = Dio();
    const appId = '4b0e4756a7f3015c0d08c2f0263c224a&units=metric';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$appId';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        return Weather.fromJson(response.data);
      } catch (e) {
        print(e);
        throw e;
      }
    }
  }
}

class Repository{
  final _api = WeatherApiClient();
  dynamic fetchWeather(String? location) async{
    return _api.fetchWeather(location);
  }
}