import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;
  bool showPasswordConfirm = false;
  double pagePadding = 26;

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController surnameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController countryController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController passwordConfirmationController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: CreateAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  Texts.signUp,
                  style: Theme.of(context).textTheme.headline5
                ),
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: nameController,
                prefixIcon: FontAwesomeIcons.user,
                placeholder: Texts.namePlaceholder,
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: surnameController,
                prefixIcon: FontAwesomeIcons.user,
                placeholder: Texts.surnamePlaceholder,
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: emailController,
                prefixIcon: FontAwesomeIcons.envelope,
                placeholder: Texts.mailPlaceholder,
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: countryController,
                prefixIcon: FontAwesomeIcons.globe,
                placeholder: Texts.countryPlaceholder,
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: passwordController,
                prefixIcon: FontAwesomeIcons.lock,
                placeholder: Texts.passwordPlaceholder,
                obscureText: showPassword == true ? false : true,
                suffixIcon: showPassword == true ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                suffixIconOnPressed: (){
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: passwordConfirmationController,
                prefixIcon: FontAwesomeIcons.lock,
                placeholder: Texts.passwordConfirmationPlaceholder,
                obscureText: showPasswordConfirm == true ? false : true,
                suffixIcon: showPasswordConfirm == true ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                suffixIconOnPressed: (){
                  setState(() {
                    showPasswordConfirm = !showPasswordConfirm;
                  });
                },
              ),
              WhiteSpaceVertical(),
              ButtonWithIcon(
                title: Texts.signUp,
                onPressed: SignUp
              ),
            ],
          ),
        ),
      ),
    );
  }

  Function SignUp(){
    if(nameController.text.isEmpty || surnameController.text.isEmpty || emailController.text.isEmpty || countryController.text.isEmpty || passwordController.text.isEmpty || passwordConfirmationController.text.isEmpty){
      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
    }else{
      // api signup
    }
  }

  SizedBox WhiteSpaceVertical(){
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 2,
    );
  }

  AppBar CreateAppBar() {
    return AppBar(
    );
  }

}


