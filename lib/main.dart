import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Interst Calculator',
    home: SIFORM(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

// Initialize SIFORM class

class SIFORM extends StatefulWidget {
  SIFORM({Key key}) : super(key: key);

  @override
  _SIFORMState createState() => _SIFORMState();
}

class _SIFORMState extends State<SIFORM> {
// to manage all the text inputs
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  // calc total returns
  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentSelectedItem';
    return result;
  }

  // reset func

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }

// overide the previous state of current item being selected
  @override
  void initState() {
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  // drop down func to select and display items
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/bag.png');
    Image image = Image(image: assetImage, width: 100, height: 100);
    return Container(
      child: image,
      padding: EdgeInsets.all(_minimunPadding * 5),
    );
  }

  var _currencies = ['Cedi', 'Pounds', 'Dollars', 'Rupees'];

  final _minimunPadding = 5.0;

  var _currentSelectedItem = '';

  String displayResult = '';

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Container(
      margin: EdgeInsets.all(_minimunPadding * 2),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            "Simple Interest Calculator",
            style: textStyle,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimunPadding * 2),
            child: ListView(
              children: <Widget>[
                getImage(),
                TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please Enter the principal amount";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        labelStyle: textStyle,
                        hintText: "Enter Principal e.g 1000",
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                SizedBox(height: 10.0),
                TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Enter Interest Rate!";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Interest Rate",
                        labelStyle: textStyle,
                        hintText: "In Percent e.g 10%",
                        errorStyle: TextStyle(color:Colors.yellowAccent, fontSize:16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimunPadding, bottom: _minimunPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (String value) {
                          if (value.isEmpty) {
                          return "Enter Years!";
                           }
                          },
                         
                          decoration: InputDecoration(
                            labelText: "Terms",
                            labelStyle: textStyle,
                             errorStyle: TextStyle(color:Colors.yellowAccent, fontSize:16),
                            hintText: "Time in years e.g 10",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50.0),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentSelectedItem,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimunPadding, bottom: _minimunPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          textColor: Theme.of(context).primaryColorDark,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                          child: Text('Reset', textScaleFactor: 1.5),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(_minimunPadding * 2),
                    child: Text(
                      this.displayResult,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
