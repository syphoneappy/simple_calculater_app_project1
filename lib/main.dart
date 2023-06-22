import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    title: "Simple App Calculater",
    theme: ThemeData(
      appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
          titleTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
          )),
      brightness: Brightness.dark,
      // scaffoldBackgroundColor: Colors.black12,
    ),
    debugShowCheckedModeBanner: false,
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  List<String> _currency = ["Rupee", "Dollor", "Pounds", "Others"];
  String _currencyDefault = "Rupee";

  // @override
  // void initState() {
  //   super.initState();
  //   String _currencyDefault = _currency[0];
  // }

  final _minimumPadding = 5.0;

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String DisplayText = "";

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Simple Calculater",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "the input is empty";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "Enter a Principal Amount",
                      hintStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    validator:(String? value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      final n = num.tryParse(value);
                      //In the code snippet I provided earlier, final n = num.tryParse(value)
                      // assigns the parsed number to a new variable named n.
                      // The final keyword is used to declare a variable that can be assigned a value only once,
                      // and then its value cannot be changed.
                      //The num class is a built-in class in Dart that represents numbers. The tryParse method is a static method of the num class, which means that you can call it without creating an instance of the class. The tryParse method takes a string value as an argument and tries to parse it into a number. If the parsing is successful, it returns the parsed number, otherwise it returns null.
                      if (n == null) {
                        return 'Input value should be numeric';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Intrest",
                      labelStyle: textStyle,
                      hintText: "Rate of Intrest",
                      hintStyle: textStyle,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 10.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: termController,
                            validator:(String? value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              final n = num.tryParse(value);
                              //In the code snippet I provided earlier, final n = num.tryParse(value)
                              // assigns the parsed number to a new variable named n.
                              // The final keyword is used to declare a variable that can be assigned a value only once,
                              // and then its value cannot be changed.
                              //The num class is a built-in class in Dart that represents numbers. The tryParse method is a static method of the num class, which means that you can call it without creating an instance of the class. The tryParse method takes a string value as an argument and tries to parse it into a number. If the parsing is successful, it returns the parsed number, otherwise it returns null.
                              if (n == null) {
                                return 'Input value should be numeric';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Term",
                              labelStyle: textStyle,
                              hintText: "No. of Year",
                              hintStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: DropdownButton<String>(
                            items: _currency.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              _onDropItem(newValue!);
                            },
                            value: _currencyDefault,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //External Padding ( Term & Money)
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton.icon(
                            label: Text('Calculate', style: textStyle),
                            icon: Icon(Icons.calculate),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState?.validate() == true) {
                                  DisplayText = _calculateTotalReturns();
                                }
                              } );
                            },
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.5, right: 2.5),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            label: Text(
                              'Reset',
                              style: textStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black12,
                            ),
                            icon: Icon(Icons.lock_reset),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.DisplayText,
                    style: TextStyle(
                      fontSize: 25.5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding),
    );
  }

  // ignore: non_constant_identifier_names
  void _onDropItem(String? NewValue) {
    setState(() {
      _currencyDefault = NewValue!;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalamountpayble = principal + (principal * roi * term) / 100;

    String result =
        "After the $term your investment will be $totalamountpayble  $_currencyDefault";

    return result;
  }

  void _reset() {
    principalController.text = "";
    termController.text = "";
    roiController.text = "";
    _currencyDefault = _currency[0];
    DisplayText = "";
  }
}
