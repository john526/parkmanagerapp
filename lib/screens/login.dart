import 'package:flutter/material.dart';
import 'package:parkmanagercorp/screens/dashboard.dart';
import 'package:parkmanagercorp/storage/sharedPreferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class LoginAppPage extends StatefulWidget {
  const LoginAppPage({Key? key}) : super(key: key);

  @override
  State<LoginAppPage> createState() => _LoginAppPageState();
}

class _LoginAppPageState extends State<LoginAppPage> {

  deleteSharedPref() async{
    await SharedPreferenceClass.takeSharedValueToNullable();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print("deleteSharedPref()");
      deleteSharedPref();
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool _validate = false;

  bool _obscureText = true;

  bool _isLoading = false;

  String _idEnter="";
  String _passwordEnter="";

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return "Good";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Cliquer deux fois pour sortir de l'application"),
        ),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child:FormeUi() ,
          ),
        ),
      ),
    );
  }

  Widget FormeUi(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50,bottom: 0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height:MediaQuery.of(context).size.height/4,
              child: Column(
                children: [
                  Image.asset('images/park.png'),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
              enableInteractiveSelection: false,
              keyboardType: TextInputType.name,
              onSaved: (String? val){
                _idEnter=val as String;
                print(_idEnter);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Entrer un username valide',
                suffixIcon: IconButton(
                  onPressed: (){
                    print("votre identifiant");
                  },
                  icon: Icon(Icons.account_circle),
                ),

              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "* Obligatoire"),
              ])),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
              enableInteractiveSelection: false, // disable paste operation
              obscureText:_obscureText,
              keyboardType: TextInputType.text,
              onSaved: (String? val){
                _passwordEnter=val as String;
                print(_passwordEnter);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mot de Passe',
                hintText: 'Entrer un mot de passe sécurisé',
                suffixIcon: IconButton(
                  onPressed: _toggle,
                  icon: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "*Obligatoire"),

              ])
            //validatePassword,        //Function to check validation
          ),
        ),
        GestureDetector(
          onTap: (){
            print("onTap password forget");

          },
          child: Padding(
            padding:  EdgeInsets.only(left: 150.0,top: 2, bottom: 0),
            child: Text("Mot de passe oublié ?", style: TextStyle(color: Colors.red),),
          ),
        ),
        SizedBox(height: 10,),
        if (_isLoading) CircularProgressIndicator() else Padding(
          padding: EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(27, 77, 144, 1)),
                borderRadius: BorderRadius.circular(20)),

            child: TextButton(
              onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DashboardPage()));
              },
              child: Text(
                'Connexion',
                style: TextStyle(color: Color.fromRGBO(27, 77, 144, 1), fontSize: 25),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
