import 'package:flutter/material.dart';
import 'package:main/model/signUpForm.dart';

class SignUp extends StatefulWidget {
  final SignUpForm signUpForm;
  final state = SignUpState();
  const SignUp({Key key, this.signUpForm}) : super(key: key);


  @override
  SignUpState createState() {
    return SignUpState();
  }
}


class SignUpState extends State<SignUp> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('User Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.signUpForm.firstName,
                  onSaved: (val) => widget.signUpForm.firstName = val,
                  validator: (val) =>
                  val.length > 3 ? null : 'Full name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.user.email,
                  onSaved: (val) => widget.user.email = val,
                  validator: (val) =>
                  val.contains('@') ? null : 'Email is invalid',
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    icon: Icon(Icons.email),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}