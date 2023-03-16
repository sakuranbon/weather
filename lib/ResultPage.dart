import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final asyncValue = ref.watch(dataProvider);
    final cityName = ref.watch(cityNameProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('${cityName.state}の天気'),
      ),
      body: Column(
        children: [
          asyncValue.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text(e.toString()),
              data: (data) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${cityName.state.toString()}'),

                  const SizedBox(
                    height: 10,
                  ),
                  
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                               '気温''${data.main!.temp}°'),
                          Text(
                            '体感気温'
                            '${data.main!.feels_like}°',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                             '湿度'
                            '${data.main!.humidity}%',
                          ),
                          Text(
                             '気圧'
                            '${data.main!.pressure}hPa',
                          ),
                        ],
                      ),
                  const SizedBox(height: 30.0,),
                  TextButton(onPressed: ()async{ref.watch(dataProvider);},
                      child: Text('更新'))
                ],
              ),
             ],
    ))
    ]
    )
    );
  }
}
