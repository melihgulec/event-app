import 'dart:io';
import 'dart:math';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/City.dart';
import 'package:event_app/Models/Country.dart';
import 'package:event_app/Models/EventCreateDto.dart';
import 'package:event_app/Models/EventType.dart';
import 'package:event_app/Models/Interest.dart';
import 'package:event_app/Models/Language.dart';
import 'package:event_app/Models/ParticipationType.dart';
import 'package:event_app/Models/UserCommunityRoles.dart';
import 'package:event_app/Services/CityService.dart';
import 'package:event_app/Services/CountryService.dart';
import 'package:event_app/Services/EventService.dart';
import 'package:event_app/Services/EventTypeService.dart';
import 'package:event_app/Services/InterestsService.dart';
import 'package:event_app/Services/LanguageService.dart';
import 'package:event_app/Services/ParticipationTypeService.dart';
import 'package:event_app/Services/UserCommunityRoleService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 26, vertical: 25);
  TextEditingController eventNameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController imagePath = TextEditingController(text: "");
  TextEditingController onlineLink = TextEditingController(text: "");

  String countryDropdownValue = "1";
  String oldCountryDropdownValue = "1";
  String cityDropdownValue = "-1";
  String oldCityDropdownValue = "-1";
  String eventTypeDropdownValue = "2";
  String oldEventTypeDropdownValue = "2";
  String languageDropdownValue = "-1";
  String oldLanguageDropdownValue = "-1";
  String participationTypeDropdownValue = "1";
  String oldParticipationTypeDropdownValue = "1";
  String userCommunityRoleDropdownValue = "-1";
  String oldUserCommunityRoleDropdownValue = "-1";
  String interestDropdownValue = "-1";
  String oldInterestDropdownValue = "-1";

  DateTime startDate, endDate;

  File eventImage;

  bool isOnline = false;

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
        eventImage = imageTemporary;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: CreateAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            children: [
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => WhiteSpaceVertical(),
                itemCount: CreateFields().length,
                itemBuilder: (context, index){
                  Widget item = CreateFields()[index];
                  return item;
                },
              ),
              WhiteSpaceVertical(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: Text(Texts.addPhotograph, style: TextStyle(fontSize: 15),),
                  onPressed: ()=> pickImage(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ),
              WhiteSpaceVertical(),
              Row(
                children: [
                  SizedBox(
                    child: Checkbox(
                      value: isOnline,
                      onChanged: (val){
                        setState(() {
                          isOnline = val;
                        });
                      },
                    ),
                  ),
                  Text(Texts.online),
                ],
              ),
              if(isOnline) TextFieldWithIcon(
                controller: onlineLink,
                prefixIcon: FontAwesomeIcons.link,
                placeholder: Texts.onlineLink,
              ),
              WhiteSpaceVertical(factor: 5,),
              ButtonWithIcon(
                  title: Texts.create,
                  onPressed: (){
                    if(eventNameController.text.isNotEmpty && descriptionController.text.isNotEmpty && eventImage != null){
                      CreateEvent(
                        EventCreateDto(
                          imagePath: eventImage.path,
                          countryId: int.parse(countryDropdownValue),
                          cityId: int.parse(cityDropdownValue),
                          name: eventNameController.text,
                          description: descriptionController.text,
                          communityId: int.parse(userCommunityRoleDropdownValue),
                          address: addressController.text,
                          endDate: endDate,
                          startDate: startDate,
                          eventTypeId: int.parse(eventTypeDropdownValue),
                          isOnline: isOnline,
                          isOver: false,
                          languageId: int.parse(languageDropdownValue),
                          participationTypeId: int.parse(participationTypeDropdownValue),
                          onlineLink: isOnline ? onlineLink.text : "null",
                          interestId: int.parse(interestDropdownValue)
                        ), _preferences.getInt('sessionUserId'), eventImage
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

  List<Widget> CreateFields(){
    return [
      CreateEventImage(),
      TextFieldWithIcon(
        controller: eventNameController,
        prefixIcon: FontAwesomeIcons.user,
        placeholder: Texts.eventName,
      ),
      TextFieldWithIcon(
        controller: descriptionController,
        prefixIcon: FontAwesomeIcons.user,
        placeholder: Texts.description,
      ),
      TextFieldWithIcon(
        controller: addressController,
        prefixIcon: FontAwesomeIcons.user,
        placeholder: Texts.eventAddress,
      ),
      DateTimePicker(
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: Texts.pickStartDate,
        style: TextStyle(color: Colors.black),
        onChanged: (value){
          setState(() {
            startDate = DateTime.parse(value);
          });
        },
      ),
      DateTimePicker(
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: Texts.pickEndDate,
        style: TextStyle(color: Colors.black),
        onChanged: (value){
          setState(() {
            endDate = DateTime.parse(value);
          });
        },
      ),
      CreateDropdown(
          child: CreateCountryDropdown()
      ),
      CreateDropdown(
          child: CreateCityDropdown()
      ),
      CreateDropdown(
        child: CreateEventTypeDropdown(),
      ),
      CreateDropdown(
        child: CreateLanguageDropdown(),
      ),
      CreateDropdown(
        child: CreateParticipationTypeDropdown()
      ),
      CreateDropdown(
          child: CreateInterestDropdown()
      ),CreateDropdown(
        child: CreateUserCommunityRolesDropdown()
      ),
    ];
  }

  CreateEventImage(){

    CreateIcon(){
      return Icon(Icons.camera_alt, size: 35, color: Colors.grey,);
    }

    CreateImage(){
      return Image.file(eventImage, width: 100, height: 100, fit: BoxFit.cover,);
    }

    return Center(
      child: ClipOval(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.white,
          child: InkWell(
            onTap: () => pickImage(),
            child: eventImage == null ? CreateIcon() : CreateImage(),
          )
          ),
      ),
    );
  }

  FutureBuilder CreateCountryDropdown(){
    return FutureBuilder<CountryBase>(
      future: GetAllCountries(),
      builder: (BuildContext context, AsyncSnapshot<CountryBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<Country> countryList = snapshot.data.data;
        countryDropdownValue = oldCountryDropdownValue == countryList.first.id.toString() ? countryDropdownValue : countryList.first.id.toString();

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

  FutureBuilder CreateEventTypeDropdown(){
    return FutureBuilder<EventTypeBase>(
      future: GetAllEventTypes(),
      builder: (BuildContext context, AsyncSnapshot<EventTypeBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<EventType> eventTypeList = snapshot.data.data;
        eventTypeDropdownValue = oldEventTypeDropdownValue == eventTypeList.first.id.toString() ? eventTypeDropdownValue : eventTypeList.first.id.toString();

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return eventTypeList
                  .map((e) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      e.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  )).toList();
            },
            hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
            value: eventTypeDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                eventTypeDropdownValue = newValue;
              });
            },
            items: eventTypeList.map((EventType map) {
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

  FutureBuilder CreateLanguageDropdown(){
    return FutureBuilder<LanguageBase>(
      future: GetAllLanguages(),
      builder: (BuildContext context, AsyncSnapshot<LanguageBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<Language> languageList = snapshot.data.data;
        languageDropdownValue = oldLanguageDropdownValue == languageList.first.id.toString() ? languageDropdownValue : languageList.first.id.toString();

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return languageList
                  .map((e) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      e.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  )).toList();
            },
            hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
            value: languageDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                languageDropdownValue = newValue;
              });
            },
            items: languageList.map((Language map) {
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

  FutureBuilder CreateParticipationTypeDropdown(){
    return FutureBuilder<ParticipationTypeBase>(
      future: GetAllParticipationTypes(),
      builder: (BuildContext context, AsyncSnapshot<ParticipationTypeBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<ParticipationType> participationTypeList = snapshot.data.data;
        participationTypeDropdownValue = oldParticipationTypeDropdownValue == participationTypeList.first.id.toString() ? participationTypeDropdownValue : participationTypeList.first.id.toString();

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return participationTypeList
                  .map((e) => Container(
                alignment: Alignment.center,
                child: Text(
                  e.name,
                  style: TextStyle(color: Colors.black),
                ),
              )).toList();
            },
            hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
            value: participationTypeDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                participationTypeDropdownValue = newValue;
              });
            },
            items: participationTypeList.map((ParticipationType map) {
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

  FutureBuilder CreateUserCommunityRolesDropdown(){
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return CircularProgressIndicator();

        return FutureBuilder<UserCommunityRoleBase>(
          future: GetAllUserCommunityRolesByRoleID(snapshot.data.getInt("sessionUserId"), 1),
          builder: (BuildContext context, AsyncSnapshot<UserCommunityRoleBase> snapshot){
            if(!snapshot.hasData || snapshot.data.data.isEmpty) return Center(child: Text("Henüz bir toplulukta yetkiniz bulunmuyor.", style: TextStyle(color: Colors.black),));

            List<UserCommunityRole> userCommunityRoleList = snapshot.data.data;
            userCommunityRoleDropdownValue = oldUserCommunityRoleDropdownValue == userCommunityRoleList.first.community.id.toString() ? userCommunityRoleDropdownValue : userCommunityRoleList.first.community.id.toString();

            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                selectedItemBuilder: (_) {
                  return userCommunityRoleList
                      .map((e) => Container(
                    alignment: Alignment.center,
                    child: Text(
                      e.community.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  )).toList();
                },
                hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
                value: userCommunityRoleDropdownValue,
                icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    oldUserCommunityRoleDropdownValue = userCommunityRoleDropdownValue;
                    userCommunityRoleDropdownValue = newValue;
                  });
                },
                items: userCommunityRoleList.map((UserCommunityRole item) {
                  return DropdownMenuItem<String>(
                    key: UniqueKey(),
                    value: item.community.id.toString(),
                    child: Text(
                      item.community.name,
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
      },
    );
  }

  FutureBuilder CreateInterestDropdown(){
    return FutureBuilder<InterestBase>(
      future: GetAllInterests(),
      builder: (BuildContext context, AsyncSnapshot<InterestBase> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());

        List<Interest> interestList = snapshot.data.data;
        interestDropdownValue = oldInterestDropdownValue == interestList.first.id.toString() ? interestDropdownValue : interestList.first.id.toString();

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (_) {
              return interestList
                  .map((e) => Container(
                alignment: Alignment.center,
                child: Text(
                  e.name,
                  style: TextStyle(color: Colors.black),
                ),
              )).toList();
            },
            hint: Text("Şehir seç", style: TextStyle(color: Colors.black),),
            value: interestDropdownValue,
            icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryIconTheme.color,),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                oldInterestDropdownValue = interestDropdownValue;
                interestDropdownValue = newValue;
              });
            },
            items: interestList.map((Interest map) {
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

  CreateDropdown({Widget child}){
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: child,
    );
  }

  AppBar CreateAppBar() {
    return AppBar(
      title: Text(Texts.createEvent),
    );
  }
}
