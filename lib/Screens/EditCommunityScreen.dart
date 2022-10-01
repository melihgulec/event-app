import 'dart:io';

import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/Community.dart';
import 'package:event_app/Models/CommunityCreateDto.dart';
import 'package:event_app/Models/Country.dart';
import 'package:event_app/Services/CityService.dart';
import 'package:event_app/Services/CommunityService.dart';
import 'package:event_app/Services/CountryService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditCommunityScreen extends StatefulWidget {
  Community community;
  EditCommunityScreen({Key key, this.community}) : super(key: key);

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  double pagePadding = 26;
  TextEditingController communityNameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController imagePath = TextEditingController(text: "");

  String countryDropdownValue = "1";
  String cityDropdownValue = "1";
  String oldCityDropdownValue = "1";

  File communityImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    communityNameController.text = widget.community.name;
    descriptionController.text = widget.community.description;
    countryDropdownValue = widget.community.country.id.toString();
    cityDropdownValue = widget.community.city.id.toString();
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
              WhiteSpaceVertical(factor: 5,),
              ButtonWithIcon(
                  title: Texts.communityEdit,
                  onPressed: (){
                    if(communityNameController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                      UpdateCommunity(
                          CommunityCreateDto(
                              countryId: int.parse(countryDropdownValue),
                              cityId: int.parse(cityDropdownValue),
                              imagePath: widget.community.imagePath,
                              name: communityNameController.text,
                              description: descriptionController.text,
                          ),
                          widget.community
                      );
                    }
                    else{
                      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
                    }
                  }
              ),
              WhiteSpaceVertical(),
              ButtonWithIcon(
                  title: Texts.communityDelete,
                  onPressed: (){
                    DeleteCommunity(widget.community);
                    Navigator.pop(context);
                    Navigator.pop(context);
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
      title: Text(Texts.communityEdit),
    );
  }
}
