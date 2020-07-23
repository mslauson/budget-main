import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main/models/global/activeUser.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/screens/splash.dart';
import 'package:main/service/registrationService.dart';
import 'package:scoped_model/scoped_model.dart';

class NewUserFullName extends StatelessWidget {
  final String phone;

  NewUserFullName(this.phone);

  @override
  Widget build(BuildContext context) {
    TextEditingController _fullNameController = new TextEditingController();
    bool validForm;
    return Scaffold(
      body: ScopedModelDescendant<ActiveUser>(
          builder: (BuildContext context, Widget child, ActiveUser model) {
        return new Container(
            padding: const EdgeInsets.all(30.0),
            color: Colors.white,
            child: new Container(
              child: new Center(
                  child: new Column(children: [
                new Padding(padding: EdgeInsets.only(top: 140.0)),
                new Text(
                  'Please Provide Blossom With Your Name',
                  style: new TextStyle(color: Colors.blue, fontSize: 25.0),
                ),
                new Padding(padding: EdgeInsets.only(top: 50.0)),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Full Name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _fullNameController,
                  validator: (val) {
                    if (val.length == 0) {
                      validForm = false;
                      return "Name cannot be empty";
                    } else if (val.indexOf(" ") != 1) {
                      validForm = false;
                      return "Please provide full name";
                    } else {
                      validForm = true;
                      return null;
                    }
                  },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Splash()),
                            );
                          },
                          child: ClipOval(
                            child: Container(
                                color: Colors.blue,
                                height: 60.0, // height of the button
                                width: 60.0, // width of the button
                                child: new Icon(Icons.arrow_back)),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            if (validForm) {
                              List<String> nameList =
                              splitName(_fullNameController.text);
                              RegistrationService registrationService =
                              new RegistrationService();
                              registrationService
                                  .addCustomer(new SignUpForm(
                                  firstName: nameList[0],
                                  lastName: nameList[1],
                                  phone: phone))
                                  .whenComplete(() =>
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Splash()),
                                )
                              })
                                  .catchError((Object error) =>
                              {Fluttertoast.showToast(msg: error)});
                            }
                          },
                          child: ClipOval(
                            child: Container(
                                color: Colors.blue,
                                height: 60.0, // height of the button
                                width: 60.0, // width of the button
                                child: new Icon(Icons.arrow_forward)),
                          ),
                        )
                      ])),
                ));
          }),
    );
  }

  List<String> splitName(String fullName) {
    return fullName.split(" ");
  }
}
