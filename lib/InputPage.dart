import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ResultPage.dart';
import 'package:flutter/material.dart';
import 'provider.dart';



class InputPage extends ConsumerWidget {
   InputPage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final cityName = ref.watch(cityNameProvider.notifier);

    return Scaffold(
      body:Column(
        children:[
          const SizedBox(
            height: 30,
          ),
          Center(
            child:
            Container(
              height: 100,
              width: 300,
              child:
              TextFormField(
                controller: controller,
                onChanged: (value){
                  cityName.state= value;
                  },
                decoration: InputDecoration(
                  helperText: '都市名を入力してください',
                  fillColor: Colors.white,
                  filled: true,
                ),
              )
          ),),
          const SizedBox(height: 20.0),
          TextButton(onPressed: (){
            Repository repository = Repository();
            repository.fetchWeather(cityName.state);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResultPage()));
          },
              child: Text('検索'))
        ],
      )
    );
  }
}
