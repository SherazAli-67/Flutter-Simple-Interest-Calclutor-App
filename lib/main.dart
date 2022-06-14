import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(SimpleInterestApp());
}

class SimpleInterestApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestAppState();
  }
}

class _SimpleInterestAppState extends State<SimpleInterestApp> {
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  String? selectedItem = "";
  String valueOfInterest = "";
  TextEditingController principalController = TextEditingController();
  TextEditingController roI = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest App",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Simple Interest App"),
        ),
        body: Container(
          child: Column(
            children: [
              GetImageWidget(),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Principal",
                      hintText: "Enter principle Amount"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: roI,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Rate",
                      hintText: "Enter interest per rate"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Term",
                          hintText: "Enter terms"),
                    ),
                  ),
                  Container(
                    width: 25.0,
                  ),
                  Expanded(
                    child: DropdownButton(
                        value: selectedItem,
                        items: _currencies.map((String iteretor) {
                          return DropdownMenuItem(
                              value: iteretor, child: Text(iteretor));
                        }).toList(),
                        onChanged: (String? currentItem) {
                          setState(() {
                            this.selectedItem = currentItem;
                          });
                        }),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: Text("Calculate Interest"),
                      onPressed: () {
                        setState(() {
                          this.valueOfInterest = calculateInterest();
                        });
                      },
                    )),
                    Container(
                      width: 25.0,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      child: Text("Reset"),
                      onPressed: () {
                        resetFields();
                      },
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  valueOfInterest,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String calculateInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(roI.text);
    double term = double.parse(termController.text);

    double result = principal + (principal * rate * term);
    String value =
        "Total Investment worth after $term of years will be $result $selectedItem";
    return value;
  }

  resetFields() {
    principalController.text = "";
    roI.text = "";
    termController.text = "";
    selectedItem = _currencies[0];
  }
}

class GetImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("images/calculator.png");
    Image image = Image(image: assetImage);
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      width: 150,
      child: image,
    );
  }
}
