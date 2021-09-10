
import 'package:Dalas/Networking/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _obscureText = true;
  bool loading = false;
  String username = "";
  String email = "";
  String password = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool textCheck = false;
  bool wordCheck = false;


  void toggle(){

    setState(() {
      if(_obscureText){
        _obscureText = false;
      }
      else{
        _obscureText = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: loading,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Text("Create an Account!",
                            style: TextStyle(
                                fontSize: 18.0
                            ),),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Username is Required";
                            }
                            return null;
                          },
                          onSaved: (value){
                            username = value!;
                          },
                          decoration: InputDecoration(
                              labelText: "Username",
                              filled: true,
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Email is required";
                            }

                            if(!Authentication().checkEmail(value)){
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (value){
                            email = value!;
                          },
                          decoration: InputDecoration(
                              labelText: "Email Address",
                              filled: true,
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              prefixIcon: Icon(Icons.mail_outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password is Required";
                            }
                            if(value.length<6){
                              return "Password should be at least six characters";
                            }
                            return null;
                          },
                          onSaved: (value){
                            password = value!;
                          },
                          decoration: InputDecoration(
                              labelText: "Password",
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              fillColor: Colors.grey[300],
                              filled: true,
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: toggle,
                                icon: Icon(_obscureText == true? Icons.visibility_off:Icons.visibility),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: (){
                            createUser(username, email, password);
                          },
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                          child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          color: Color(0xFF00c9c8),

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("I've already an account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ));
  }

  createUser(String username,email,password)async{
    if(!_formkey.currentState!.validate()){
      print("xfgcf");
      return;
    }

    _formkey.currentState!.save();
    setState(() {
      loading = true;
    });
      await Authentication().createUser(username, email, password).then((value){
      setState(() {
        loading = false;
      });
    });
  }


}