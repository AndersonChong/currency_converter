import 'package:currency_converter/services/currency_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Body(),
    ),
  ));
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Currency currency;
  var baseDropDownValue = 'EUR';
  var targetDropDownValue = 'USD';
  double targetValue;

  void createInstance() async {
    currency = Currency();
    await currency.getCurrencyRate();
    currency.convertCurrency();
  }

  @override
  void initState() {
    super.initState();
    createInstance();
    targetValue = currency.targetValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 13,
                child: TextField(
                  onChanged: (value) {
                    currency.baseValue = double.parse(value);
                    currency.convertCurrency();
                    setState(() {
                      targetValue = currency.targetValue;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0.0',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: baseDropDownValue,
                      icon: Icon(
                        Icons.arrow_right,
                      ),
                      onChanged: (value) {
                        currency.base = value;
                        currency.convertCurrency();
                        setState(() {
                          baseDropDownValue = value;
                          targetValue = currency.targetValue;
                        });
                      },
                      items: <String>[
                        'MYR',
                        'USD',
                        'EUR',
                      ]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 13,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: targetValue.toString(),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: targetDropDownValue,
                      icon: Icon(
                        Icons.arrow_right,
                      ),
                      onChanged: (value) {
                        currency.target = value;
                        currency.convertCurrency();
                        setState(() {
                          targetDropDownValue = value;
                          targetValue = currency.targetValue;
                        });
                      },
                      items: <String>[
                        'MYR',
                        'USD',
                        'EUR',
                      ]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
