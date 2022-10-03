import 'package:event_app/Components/ItemTileWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Company.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Services/CompaniesService.dart';
import 'package:event_app/Services/SponsorsService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddEventSponsorScreen extends StatefulWidget {
  Event event;

  AddEventSponsorScreen({Key key, this.event}) : super(key: key);

  @override
  State<AddEventSponsorScreen> createState() => _AddEventSponsorScreenState();
}

class _AddEventSponsorScreenState extends State<AddEventSponsorScreen> {
  EdgeInsets pagePadding = EdgeInsets.all(8.0);

  void addSponsorRequest(int companyId){
    CreateSponsor(widget.event.id, companyId);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FutureBuilder<CompanyBase>(
              future: GetCompanies(),
              builder: (BuildContext context, AsyncSnapshot<CompanyBase> snapshot){
                if(!snapshot.hasData) return CircularProgressIndicator();

                List<Company> companiesList = snapshot.data.data;

                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => WhiteSpaceVertical(),
                  itemCount: companiesList.length,
                  itemBuilder: (context, index){
                    Company item = companiesList[index];

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ItemTileWithIcon(
                            icon: FaIcon(FontAwesomeIcons.c),
                            title: item.companyName,
                            leftBorderColor: Theme.of(context).primaryColor,
                            onTap: (){
                            },
                          ),
                        ),
                        Container(
                          width: 50,
                          child: ElevatedButton(
                            child: FaIcon(FontAwesomeIcons.plus, color: Colors.white,),
                            onPressed: (){
                              addSponsorRequest(item.id);
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.addEventSponsor),
    );
  }
}
