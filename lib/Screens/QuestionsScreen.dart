import 'package:event_app/Components/ButtonWithIcon.dart';
import 'package:event_app/Components/ItemTileWithIcon.dart';
import 'package:event_app/Components/QuestionCard.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/QuestionBase.dart';
import 'package:event_app/Models/User.dart';
import 'package:event_app/Services/QuestionService.dart';
import 'package:event_app/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsScreen extends StatefulWidget {
  Event event;

  QuestionsScreen({Key key, this.event}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  SharedPreferences _preferences;
  EdgeInsets pagePadding = EdgeInsets.all(8.0);
  TextEditingController questionController = TextEditingController(text: '');
  TextEditingController questionEditController = TextEditingController(text: '');

  Offset _tapPosition;

  void getClickPos(TapDownDetails details) =>
      _tapPosition = details.globalPosition;

  void sendQuestion() async{
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      PostQuestionByEventId(widget.event.id, Question(
          description: questionController.text,
          user: User(
              id: _preferences.getInt("sessionUserId")
          )
      ));
    });
  }

  void editQuestion(Question question) async{
    setState(() {
      PutQuestionByEventId(widget.event.id, Question(
        id: question.id,
        description: questionEditController.text
      ));
    });
  }

  void deleteQuestion(Question question) async{
    setState(() {
      DeleteQuestionByEventId(widget.event.id, Question(
          id: question.id,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    return Scaffold(
      appBar: CreateAppBar(),
      floatingActionButton: CreateFloatingActionButton(context),
      body: Padding(
        padding: pagePadding,
        child:FutureBuilder<QuestionBase>(
          future: GetQuestionsByEventId(widget.event.id),
          builder: (BuildContext context, AsyncSnapshot<QuestionBase> snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();

            List<Question> questionList = snapshot.data.data;
            if(questionList.isEmpty) return Center(child: Text(Texts.questionsNotFound),);

            return GestureDetector(
              onTapDown: getClickPos,
              child: ListView.separated(
                separatorBuilder: (context, index) => WhiteSpaceVertical(),
                itemCount: questionList.length,
                itemBuilder: (context, index){
                  Question question = questionList[index];

                  return QuestionCard(
                    question: question,
                    onLongPress: (){
                      showQuestionEditModalBottomSheet(question);
                      questionEditController.text = question.description;
                    },
                  );
                },
              ),
            );
          },
        )
      )
    );
  }

  FloatingActionButton CreateFloatingActionButton(BuildContext context){
    SizeConfig().init(context);

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white,),
      onPressed: (){
        showAddQuestionModalBottomSheet();
      },
    );
  }

  void showAddQuestionModalBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0)),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                child: Text(Texts.sendYourQuestion, style: Theme.of(context).textTheme.titleMedium,),
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: questionController,
                prefixIcon: Icons.question_mark,
              ),
              WhiteSpaceVertical(factor: 3),
              ButtonWithIcon(
                onPressed: sendQuestion,
                title: Texts.send,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showQuestionEditModalBottomSheet(Question question){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0)),
      ),
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                child: Text(Texts.editYourQuestion, style: Theme.of(context).textTheme.titleMedium,),
              ),
              WhiteSpaceVertical(),
              TextFieldWithIcon(
                controller: questionEditController,
                prefixIcon: Icons.question_mark,
              ),
              WhiteSpaceVertical(factor: 3),
              ButtonWithIcon(
                title: Texts.edit,
                onPressed: (){
                  editQuestion(question);
                },
              ),
              WhiteSpaceVertical(),
              ButtonWithIcon(
                title: Texts.delete,
                onPressed: (){
                  deleteQuestion(question);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLongPressMenu(RenderBox overlay){
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            _tapPosition.dx,
            _tapPosition.dy,
            overlay.size.width - _tapPosition.dx,
            overlay.size.height - _tapPosition.dy),
        items: [
          PopupMenuItem(
            child: Text('Düzenle'),
            onTap: (){
              showAddQuestionModalBottomSheet();
            },
          ),
          PopupMenuItem(
            child: Text('Sil'),
          ),
        ]
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.questions),
    );
  }
}
