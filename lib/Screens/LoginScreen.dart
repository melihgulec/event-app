import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Services/APIAuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences _preferences;
  double pagePadding = 36;
  bool showPassword = false;
  bool rememberMe = false;

  TextEditingController emailController = TextEditingController(text: "a");
  TextEditingController passwordController = TextEditingController(text: "1");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  getPrefs()async{
    _preferences =await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: pagePadding),
            child: Column(
              children: [
                Column(
                  children: CreateLogoItems(),
                ),
                WhiteSpaceVertical(),
                SizedBox(
                  width: double.infinity,
                  height: SizeConfig.blockSizeVertical * 8,
                  child: Text(
                    Texts.loginHeadText,
                    style: Theme.of(context).textTheme.headline5
                  ),
                ),
                CreateTextBoxGroup(),
                WhiteSpaceVertical(),
                ButtonWithIcon(
                  title: Texts.loginHeadText,
                  onPressed: (){
                    if(emailController.text.isEmpty || passwordController.text.isEmpty){
                      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
                    }else{
                      UserLogin(emailController.text, passwordController.text).then((value){

                        _preferences.setString("apiToken", value.message);

                        if(value.success && value.message.isNotEmpty){
                          Navigator.popAndPushNamed(context, homeRoute, arguments: value.data.first);
                        }
                      });
                    }
                  },
                ),
                WhiteSpaceVertical(),
                TextButton(
                  child: Text(
                    Texts.dontHaveAnAccountSignUpText,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, signUpRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> CreateLogoItems(){
    String logoPath = "assets/images/logos/logo.png";
    double sizeConfigHeightFactor = 18;

    return <Widget>[
      Image(
        image: AssetImage(logoPath),
        height: SizeConfig.blockSizeVertical * sizeConfigHeightFactor,
      ),
      Text(Texts.appName,
        style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500
        ),
      ),
    ];
  }

  Column CreateTextBoxGroup(){
    return Column(
      children: [
        TextFieldWithIcon(
          controller: emailController,
          placeholder: Texts.mailPlaceholder,
          prefixIcon: FontAwesomeIcons.envelope,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        TextFieldWithIcon(
          controller: passwordController,
          placeholder: Texts.passwordPlaceholder,
          prefixIcon: FontAwesomeIcons.lock,
          suffixIcon: showPassword == false ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
          obscureText: showPassword == false ? true : false,
          suffixIconOnPressed: (){
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FlutterSwitch(
                  width: 40.0,
                  height: 25.0,
                  toggleSize: 15,
                  activeColor: Theme.of(context).primaryColor,
                  activeToggleColor: Colors.black,

                  value: rememberMe,
                  onToggle: (bool value){
                    setState(() {
                      rememberMe = !rememberMe;
                    });
                  },
                ),
                SizedBox(width: 7,),
                Text(Texts.rememberMe),
              ],
            ),
            TextButton(
              child: Text(
                Texts.forgotPassword,
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.w400,
                  letterSpacing: 0
                ),
              ),
              onPressed: (){

              },
            ),
          ],
        ),
      ],
    );
  }

  SizedBox WhiteSpaceVertical(){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 4,
    );
  }
}
