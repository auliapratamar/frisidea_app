import 'package:flutter/material.dart';
import 'package:frisidea_app/base/base_widget.dart';
import 'package:frisidea_app/main/main_view_model.dart';
import 'package:frisidea_app/widget/bottomsheets.dart';
import 'package:frisidea_app/widget/custom_textfield.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController _firstInputController = TextEditingController();
  TextEditingController _secondInputController = TextEditingController();
  FocusNode _firstInputNode = FocusNode();
  FocusNode _secondInputNode = FocusNode();

  _handleShowSelfInformation(){
    showMaterialModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      backgroundColor: Colors.transparent,
      bounce: true,
      builder: (context) => _InformationModal(
        githubUrl: 'https://github.com/auliapratamar',
        linkedInUrl: 'https://www.linkedin.com/in/aulia-pratama-riwayanto-181796165/',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MainViewModel>(
      model: MainViewModel(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Text('Frisidea App'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(color: Colors.black12,
                        blurRadius: 10,offset: Offset(0,3),
                        spreadRadius: 1)]),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      child: TextFormFieldWidget(
                        textInputType: TextInputType.number,
                        actionKeyboard: TextInputAction.done,
                        functionValidate: commonValidation,
                        parametersValidate: 'Input Pertama tidak boleh kosong',
                        controller: _firstInputController,
                        focusNode: _firstInputNode,
                        onSubmitField: (){
                          changeFocus(context,
                              currentFocus: _firstInputNode,
                              nextFocus: _secondInputNode
                          );
                        },
                        onGetValue: (value) => viewModel.firstInputValue = value,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 70,
                      child: TextFormFieldWidget(
                        textInputType: TextInputType.number,
                        actionKeyboard: TextInputAction.done,
                        functionValidate: commonValidation,
                        parametersValidate: 'Input Kedua tidak boleh kosong',
                        controller: _secondInputController,
                        focusNode: _secondInputNode,
                        onSubmitField: (){
                          _secondInputNode.unfocus();
                        },
                        onGetValue: (value) => viewModel.secondInputValue = value
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: viewModel.loadingStatus ? 50 : 150,
                child: MaterialButton(
                  onPressed: () => viewModel.calculate(
                      isPrimeNumber: (isTrue){
                        print(isTrue);
                        if (isTrue){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'prime value',
                              ),
                              backgroundColor: Colors.blue,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'wrong value',
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                  ),
                  child: viewModel.loadingStatus ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(backgroundColor: Colors.white,),
                  ) : Text('Submit',style: TextStyle(
                      color: Colors.white
                  ),
                  ),
                  elevation: 3,
                  color: Colors.blue,
                  minWidth: 150,
                  height: 50,
                ),
              ),
              MaterialButton(
                minWidth: 100,
                height: 35,
                color: Colors.redAccent,
                onPressed: () => viewModel.resetValue(
                  isDone: (isTrue){
                    if (isTrue){
                      _firstInputController.clear();
                      _secondInputController.clear();
                    }
                  }
                ),
                child: Text('reset',style: TextStyle(
                    color: Colors.white
                ),)),
              viewModel.primeList.isNotEmpty ?
              Container(
                color: Colors.teal,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Prime List'),
                    ListView.builder(
                      itemCount: viewModel.primeList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          viewModel.primeList[index],
                          style: TextStyle(color: Colors.black54),
                        );
                      },
                    )
                  ],
                ),
              ) : SizedBox(),
              MaterialButton(
                onPressed: _handleShowSelfInformation,
                height: 30,
                minWidth: 75,
                color: Colors.blue,
                child: Text('Show Information',style: TextStyle(
                    color: Colors.white
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationModal extends StatelessWidget {

  final String linkedInUrl;
  final String githubUrl;

  _InformationModal({@required this.linkedInUrl, @required this.githubUrl});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetsFit(
      title: 'Self Information',
      children: [
        Text('Aulia Pratama Riwayanto',style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 20,),
        Center(
          child: Image.network(
              'https://media-exp1.licdn.com/dms/image/C5103AQGbqhcXE0cBYw/profile-displayphoto-shrink_800_800/0/1580317418044?e=1623283200&v=beta&t=pGCCj7JAFGRB8IfO2L3edghtdwPVKmvnodr52rLjPUc',
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20,),
        Text('auliapratama94@gmail.com',style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 20,),
        InkWell(
          onTap: () => _launchURL(githubUrl),
          child: Text(githubUrl,style: TextStyle(
              color: Colors.lightBlueAccent
          ),),
        ),
        SizedBox(height: 20,),
        InkWell(
          onTap: () => _launchURL(linkedInUrl),
          child: Text(linkedInUrl,style: TextStyle(
            color: Colors.lightBlueAccent
          ),),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}

