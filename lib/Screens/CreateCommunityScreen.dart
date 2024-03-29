import 'dart:io';

import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/CommunityCreateDto.dart';
import 'package:event_app/Models/Country.dart';
import 'package:event_app/Services/CityService.dart';
import 'package:event_app/Services/CommunityService.dart';
import 'package:event_app/Services/CountryService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCommunityScreen extends StatefulWidget {
  CreateCommunityScreen({
    Key key,
  }) : super(key: key);

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  double pagePadding = 26;
  TextEditingController communityNameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController imagePath = TextEditingController(text: "");

  String countryDropdownValue = "1";
  String cityDropdownValue = "1";
  String oldCityDropdownValue = "1";

  File communityImage;
  SharedPreferences _preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  getPrefs() async{
    _preferences = await SharedPreferences.getInstance();
  }

  Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if(image != null){
        final imageTemporary = File(image.path);
        communityImage = imageTemporary;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            children: [
              communityImage != null ? ClipOval(child: Image.file(communityImage, width: 100, height: 100, fit: BoxFit.cover,)) : CreateCommunityImage(),
              WhiteSpaceVertical(factor: 5,),
              TextFieldWithIcon(
                controller: communityNameController,
                prefixIcon: FontAwesomeIcons.user,
                placeholder: Texts.communityName,
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: descriptionController,
                prefixIcon: FontAwesomeIcons.user,
                placeholder: Texts.description,
              ),
              WhiteSpaceVertical(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: CreateCountryDropdown(),
              ),
              WhiteSpaceVertical(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: CreateCityDropdown(),
              ),
              WhiteSpaceVertical(),
              Container(
                width: double.infinity,
                height: 60,
                child: SizedBox(
                  child: ElevatedButton(
                    child: Text(Texts.addPhotograph, style: TextStyle(fontSize: 15),),
                    onPressed: ()=> pickImage(),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ),
              ),
              WhiteSpaceVertical(factor: 5,),
              ButtonWithIcon(
                  title: Texts.create,
                  onPressed: (){
                    if(communityNameController.text.isNotEmpty && descriptionController.text.isNotEmpty && communityImage != null){
                      CreateCommunity(
                          CommunityCreateDto(
                            description: descriptionController.text,
                            name: communityNameController.text,
                            cityId: int.parse(cityDropdownValue),
                            countryId: int.parse(countryDropdownValue),
                            imagePath: communityImage.path,
                          ), _preferences.getInt('sessionUserId'), communityImage
                      );
                    }
                    else{
                      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  CreateCommunityImage(){
    return ClipOval(
        child: Container(
            width: 100,
            height: 100,
            color: Colors.white,
          child: IconButton(
            icon: Icon(Icons.camera_alt, size: 35, color: Colors.grey,),
            onPressed: () => pickImage()
          ),
        )
    );
  }

  FutureBuilder CreateCountryDropdown(){
    return FutureBuilder<CountryBase>(
      future: GetAllCountries(),
      builder: (BuildContext context, AsyncSnapshot<CountryBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<Country> countryList = snapshot.data.data;

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return countryList
                  .map((e) => Container(
                alignment: Alignment.center,
                child: Text(
                  e.name,
                  style: TextStyle(color: Colors.black),
                ),
              )).toList();
            },
            hint: Text("Ülke seç", style: TextStyle(color: Colors.black),),
            value: countryDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                countryDropdownValue = newValue;
              });
            },
            items: countryList.map((Country map) {
              return DropdownMenuItem<String>(
                value: map.id.toString(),
                child: Text(
                  map.name,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  FutureBuilder CreateCityDropdown(){
    return FutureBuilder<CityBase>(
      future: GetAllCitiesByCountryId(int.parse(countryDropdownValue)),
      builder: (BuildContext context, AsyncSnapshot<CityBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<City> cityList = snapshot.data.data;
        cityDropdownValue = oldCityDropdownValue == cityList.first.id.toString() ? cityDropdownValue : cityList.first.id.toString();

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return cityList
                  .map((e) => Container(
                alignment: Alignment.center,
                child: Text(
                  e.name,
                  style: TextStyle(color: Colors.black),
                ),
              )).toList();
            },
            hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
            value: cityDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                oldCityDropdownValue = cityDropdownValue;
                cityDropdownValue = newValue;
              });
            },
            items: cityList.map((City map) {
              return DropdownMenuItem<String>(
                value: map.id.toString(),
                child: Text(
                  map.name,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  AppBar CreateAppBar() {
    return AppBar(
      title: Text(Texts.createCommunity),
    );
  }
}