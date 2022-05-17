import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Company.dart';
import 'package:event_app/Services/CompaniesService.dart';
import 'package:flutter/material.dart';

class CompanyDetailScreen extends StatelessWidget {
  Company company;

  CompanyDetailScreen({
    Key key,
    this.company,
  }) : super(key: key);

  EdgeInsets pagePadding = EdgeInsets.symmetric(vertical: 35, horizontal: 30);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.82,
        width: SizeConfig.screenWidth,
        child: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.white,
                      child: Image(
                        image: GetCompanyImage(company.id),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  WhiteSpaceVertical(),
                  Text(
                    company.companyName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  WhiteSpaceVertical(factor: 1,),
                  Text(
                    "${company.city.name}, ${company.city.country.shortName}",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              WhiteSpaceVertical(factor: 5,),
              Container(
                width: double.infinity,
                child: Text(
                  Texts.about,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              WhiteSpaceVertical(factor: 3,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    company.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 2
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
