import 'package:date_time_picker/date_time_picker.dart';
import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/FlowCard.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Helpers/ToastHelper.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventSchedule.dart';
import 'package:event_app/Services/EventScheduleService.dart';
import 'package:flutter/material.dart';

class CreateEventScheduleScreen extends StatefulWidget {
  Event event;
  bool isAuthorized;

  CreateEventScheduleScreen({Key key, this.event, this.isAuthorized}) : super(key: key);

  @override
  State<CreateEventScheduleScreen> createState() =>
      _CreateEventScheduleScreenState();
}

class _CreateEventScheduleScreenState extends State<CreateEventScheduleScreen> {
  double pagePadding = 8;

  List<EventSchedule> eventSchedules = [];

  TextEditingController startDate = TextEditingController(text: '');
  TextEditingController endDate = TextEditingController(text: '');

  TextEditingController descriptionController = TextEditingController(text: '');

  int startIndex = 0;

  addEventSchedules() {
    if(startDate.text.isNotEmpty && endDate.text.isNotEmpty && descriptionController.text.isNotEmpty){
      setState(() {
        eventSchedules.add(EventSchedule(
            id: startIndex,
            startDate: startDate.text,
            endDate: endDate.text,
            description: descriptionController.text));

        startDate.clear();
        endDate.clear();
        descriptionController.clear();

        startIndex++;
      });
    }
    else{
      ToastHelper().makeToastMessage(Texts.allFieldsMustBeFilled);
    }
  }

  deleteEventSchedule(EventSchedule eventSchedule) {
    setState(() {
      eventSchedules = eventSchedules
          .where((element) => element.id != eventSchedule.id)
          .toList();

      startDate.clear();
      endDate.clear();
      descriptionController.clear();
    });
  }

  sendSchedule() {
    PostEventSchedule(widget.event.id, eventSchedules);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateTimePicker(
                      controller: startDate,
                      type: DateTimePickerType.time,
                      timeLabelText: Texts.pickStartTime,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          startDate.text = value;
                        });
                      },
                    ),
                    WhiteSpaceVertical(),
                    DateTimePicker(
                      controller: endDate,
                      type: DateTimePickerType.time,
                      timeLabelText: Texts.pickEndTime,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          endDate.text = value;
                        });
                      },
                    ),
                    WhiteSpaceVertical(),
                    TextFieldWithIcon(
                      prefixIcon: Icons.description,
                      placeholder: Texts.description,
                      controller: descriptionController,
                    ),
                    WhiteSpaceVertical(),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: addEventSchedules,
                        child: Text(
                          'Ekle',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    WhiteSpaceVertical(
                      factor: 6,
                    ),
                    Text(
                      Texts.addedScheduleBelow,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    WhiteSpaceVertical(),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return WhiteSpaceVertical();
                      },
                      shrinkWrap: true,
                      itemCount: eventSchedules.length,
                      itemBuilder: (context, index) {
                        EventSchedule eventSchedule = eventSchedules[index];

                        return Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: FlowCard(
                                  startDate: eventSchedule.startDate,
                                  endDate: eventSchedule.endDate,
                                  description: eventSchedule.description,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.delete_forever,
                                      color: Colors.white, size: 32),
                                  onPressed: () {
                                    deleteEventSchedule(eventSchedule);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(pagePadding),
            child: ButtonWithIcon(
              onPressed: sendSchedule,
              title: Texts.send,
            ),
          )
        ],
      ),
    );
  }

  AppBar CreateAppBar() {
    return AppBar(
      title: Text(Texts.createSchedule),
    );
  }
}
