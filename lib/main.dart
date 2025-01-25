import 'dart:developer';

import 'package:flutter/material.dart';

import 'auto_complete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: const FreightRateSearch(),
    );
  }
}

class FreightRateSearch extends StatefulWidget {
  const FreightRateSearch({super.key});

  @override
  State<FreightRateSearch> createState() => _FreightRateSearchState();
}

class _FreightRateSearchState extends State<FreightRateSearch> {
  bool includeNearbyOriginPorts = false;
  bool includeNearbyDestinationPorts = false;
  bool isFCL = true;
  String containerSize = '40\' Standard';
  String commodityDefault = 'Option1';
  List<DropdownMenuItem<String>>? options = [
    DropdownMenuItem(value: 'Option1',child: Text('Option1'),),
    DropdownMenuItem(value: 'Option2',child: Text('Option2'),),
    DropdownMenuItem(value: 'Option3',child: Text('Option3'),),
  ];
  String? selectedValue;

  List<String> suggestions = [];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 234, 248, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
        scrolledUnderElevation: 0.0,
        title: const Text('Search the best Freight Rates',style: TextStyle( fontWeight: FontWeight.w900),),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextButton(
            onPressed: () {},
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(230, 235, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                       side: const BorderSide(
                       color: Color.fromRGBO(1, 57, 255, 1),
                       width: 1.0,
                    ),
                  ),

                  child: const Text(
                    'History',
                    style: TextStyle(
            color: Color.fromRGBO(1, 57, 255, 1),
            fontSize: 16.0,
                    ),
                  ),
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: size.height * .07,
                          child: Autocomplete(
                              optionsBuilder: (TextEditingValue textEditingValue) async {
                                if(textEditingValue.text.isEmpty)
                                  {
                                    return Iterable<String>.empty();
                                  }
                                return await AutoComplete.fetchSuggestions(textEditingValue.text);
                              },
                            onSelected: (String selection){
                                log('selected text: $selection');
                            },
                            fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted){
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Origin',
                                  prefixIcon: ImageIcon(
                                      AssetImage("assets/location.png")
                                  ),
                                ),
                              );
                            },
                            optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options){
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                    width: size.width * .3,
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children: options.map((String option) {
                                        return ListTile(
                                          title: Text(option),
                                          onTap: () {
                                            onSelected(option);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                          /*const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Origin',
                              prefixIcon: ImageIcon(
                                AssetImage("assets/location.png")
                              ),
                            ),
                          ),*/
                        ),
                      ),
                      SizedBox(width: size.width * .02),
                      Flexible(
                        child: SizedBox(
                          height: size.height * .07,
                          child: Autocomplete(
                            optionsBuilder: (TextEditingValue textEditingValue) async {
                      if(textEditingValue.text.isEmpty)
                      {
                      return Iterable<String>.empty();
                      }
                      return await AutoComplete.fetchSuggestions(textEditingValue.text);
                      },
                        onSelected: (String selection){
                          log('selected text: $selection');
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted){
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Destination',
                              prefixIcon: ImageIcon(
                                  AssetImage("assets/location.png")
                              ),
                            ),
                          );
                        },
                        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options){
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                width: size.width * .3,
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: options.map((String option) {
                                    return ListTile(
                                      title: Text(option),
                                      onTap: () {
                                        onSelected(option);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: size.height * .005 ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: includeNearbyOriginPorts,
                              activeColor: Color.fromRGBO(21, 94, 239, 1),
                              onChanged: (value) {
                                setState(() {
                                  includeNearbyOriginPorts = value!;
                                });
                              },
                            ),
                            const Text('Include nearby origin ports'),
                          ],
                        ),
                      ),
                      //SizedBox(width: size.width * .353),
                      SizedBox(width: size.width * .015),

                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: includeNearbyDestinationPorts,
                              activeColor: Color.fromRGBO(21, 94, 239, 1),
                              onChanged: (value) {
                                setState(() {
                                  includeNearbyDestinationPorts = value!;
                                });
                              },
                            ),
                            Flexible(child: const Text('Include nearby destination ports')),
                          ],
                        ),
                      ),
                    ],
                  ),





                   SizedBox(height: size.height * .03),
                  Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: size.height * .07,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Commodity'
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: ImageIcon(
                                  AssetImage("assets/AdornmentEnd(1).png"),
                                ),
                                value: null,
                                items: options,
                                onChanged: (String? input){
                                  setState(() {
                                    commodityDefault = input!;
                                  });
                                },
                                hint: Text('Commodity'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * .022),
                      Flexible(
                          child: GestureDetector(
                            onTap: (){
                              showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(3000),
                              );
                            },
                            child: AbsorbPointer(
                              child: SizedBox(
                                height: size.height * .07,
                                child: TextField(
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset("assets/calendar-2.png") ,
                                      ),
                                      hintText: "Cut Off Date",
                                      border: OutlineInputBorder()
                                    )
                                ),
                              ),
                            ),
                          ),
                      ),

                    ],
                  ),

                   SizedBox(height: size.height * .02),
                  const Text('Shipment Type :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: size.height * .02),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isFCL,
                            activeColor: Color.fromRGBO(21, 94, 239, 1),
                            onChanged: (value) {
                              setState(() {
                                isFCL = value!;
                              });
                            },
                          ),
                          const Text('FCL'),
                        ],
                      ),
                      SizedBox(width: size.width * .01),
                      Row(
                        children: [
                          Checkbox(
                            value: !isFCL,
                            activeColor: Color.fromRGBO(21, 94, 239, 1),
                            onChanged: (value) {
                              setState(() {
                                isFCL = !value!;
                              });
                            },
                          ),
                          const Text('LCL'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .03 ),
                  Row(
                    children: [
                      SizedBox(
                        height: size.height * .068,
                        width: size.width * 0.47,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Container Size',
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: ImageIcon(
                                AssetImage("assets/AdornmentEnd(1).png")
                              ),
                              value: containerSize,
                              items: [
                                DropdownMenuItem(
                                  value: '40\' Standard',
                                  child: Text('40\' Standard'),
                                ),
                                DropdownMenuItem(
                                  value: 'option 2',
                                  child: Text('option 2'),
                                ),
                              ],
                              onChanged: (String? input){
                                setState(() {
                                  containerSize = input!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * .019),
                      Flexible(
                        child: SizedBox(
                          height: size.height * .07,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'No of Boxes',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * .02),
                      Flexible(
                        child: SizedBox(
                          height: size.height * .07,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Weight (Kg)',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                   SizedBox(height: size.height * .01),
                  Row(
                    children: [
                      Image.asset('assets/info-circle.png'),
                      SizedBox(width: size.width * .005,),
                      Flexible(
                        child: const Text(
                          'To obtain accurate rate for spot rate with guaranteed space and booking, please ensure your container count and weight per container is accurate.',
                          style: TextStyle(fontSize: 16,color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: const Text('Container Internal Dimensions :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Length '),
                              SizedBox(width: size.width * .01),
                              Text("39.46ft",style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                            ],
                          ),
                           SizedBox(height: size.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Width'),
                              SizedBox(width: size.width * .01),
                              Text("   7.70ft",style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Height'),
                              SizedBox(width: size.width * .01),
                              Text("  7.84 ft",style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .045),
                        child: Image.asset(
                          'assets/container image 1.png',
                          width: 255,
                          height: 96,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 8),

                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(230, 235, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          side: const BorderSide(
                            color: Color.fromRGBO(1, 57, 255, 1),
                            width: 1.0,
                          ),
                        ),

                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: size.width * .003,top: size.height * .004),
                              child: ImageIcon(
                                AssetImage("assets/search-normal.png"),
                                size: size.height * .03,
                              ),
                            ),
                            const Text(
                              'Search',
                              style: TextStyle(
                                color: Color.fromRGBO(1, 57, 255, 1),
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
