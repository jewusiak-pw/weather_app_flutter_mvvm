import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_app_flutter_mvvm/model/autocomplete_item.dart';
import 'package:weather_app_flutter_mvvm/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _uuidGenerator = Uuid();
  String? _requestDelayKey;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Weather app",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("What's the weather like in...?"),
                Container(
                  width: 300,
                  child: Autocomplete<AutocompleteItem>(
                    optionsBuilder: (value) async {
                      await homeViewModel.setAutocompleteBoxValue(value.text);
                      return homeViewModel.hints;
                    },
                    displayStringForOption: (option) {
                      return option.localizedName??"";
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          // size works, when placed here below the Material widget
                          child: Container(
                            width: 300,
                            height: 500,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              separatorBuilder: (context, i) => Divider(),
                              itemBuilder: (BuildContext context, int index) {
                                var option = options.elementAt(index);
                                return ListTile(
                                    onTap: () => onSelected(option),
                                    title: Text(option.localizedName ?? ""),
                                    subtitle: Text(
                                      "${option.administrativeArea?.localizedName ?? ''}, ${option.country?.localizedName ?? ''}",
                                      softWrap: true,
                                    ));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    onSelected: (option) {
                      homeViewModel.selectedOption = option;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: Text("Go!"),
                  onPressed: () async => await homeViewModel.goPressedCommand(),
                ),
                SizedBox(
                  height: 350,
                ),
                ElevatedButton(
                  child: Text("Todo ->"),
                  onPressed: () async => await homeViewModel.todoPressedCommand(),
                ),
              ],
            )),
      ),
    );
  }
}
