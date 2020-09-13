import 'package:flutter/material.dart';

import 'ProductDataFetch.dart';
import 'controller/productDetailController.dart';
import 'model/productDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String Id = "home";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i310 ProductDetail',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {FeedbackListScreen.Id: (context) => FeedbackListScreen()},
      home: MyHomePage(title: 'i310 ProductDetail'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      ProductDetail feedbackForm = ProductDetail(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text);

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  void _nextScreen() {
    Navigator.pushNamed(context, FeedbackListScreen.Id);
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return 'Enter Valid Variant';
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: 'Variant'),
                      ),
                      TextFormField(
                        controller: mobileNoController,
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return 'Enter Valid Quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                        ),
                      ),
                      TextFormField(
                        controller: feedbackController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid price';
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: 'Price'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: _nextScreen,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
