import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_inovation/ui/screen/QRScreen.dart';

import '../../core/blocs/login_bloc.dart';
import '../widgets/loadingdialog_widget.dart';
import '../widgets/notification_widget.dart';


class Loginscreen extends StatefulWidget {
  static const id = 'Loginscreen';

  @override
  _Loginscreenstate createState() => _Loginscreenstate();
}

class _Loginscreenstate extends State<Loginscreen> {

  List<FocusNode> _focusNodes;
  LoginBloc _formBloc;

  Future<bool> isLogin() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool value = await storage.get('isLogin');
    print(value);
    return value == null ? false : value;
  }

  @override
  void initState() {
    super.initState();
    _focusNodes = [FocusNode(),FocusNode()];
    isLogin().then((value){
      print(_focusNodes.length);
      return value ? print(value):print(value);
    });

  }
  @override
  void dispose() {
    _formBloc.dispose();
    _focusNodes.forEach((_focusNodes)=> _focusNodes.dispose());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        builder: (context)=>LoginBloc(),
        child:Builder(builder: (context){
          _formBloc = BlocProvider.of<LoginBloc>(context);
          return Scaffold(
            body: FormBlocListener<LoginBloc,String,String>(
              onSubmitting: (context,state)=> LoadingDialog.show(context),
              //kondisi jika berhasil login
              onSuccess: (context,state){
                LoadingDialog.hide(context);
                Navigator.pushReplacementNamed(context, ScanQRScreen.id);
              },
              //kondiisi jika gagal login
              onFailure: (context,state){
                LoadingDialog.hide(context);
                Notifications.showSnackBarWithError(context, state.failureResponse);
              },

              child: ListView(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF00b2cc),
                            Color(0xFF00e5ff),
                            Color(0xFF6effff)
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(90)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.code,
                            color: Colors.yellow,
                            size: 80,),
                        ),
                        Spacer(),
                        Align(
                          alignment : Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 32,right:32
                            ),
                            child: Text('Login'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:  20,
                                  fontWeight:  FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          height: 45,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextFieldBlocBuilder(
                            keyboardType: TextInputType.text,
                            focusNode: _focusNodes[0],
                            nextFocusNode: _focusNodes[1],
                            decoration: InputDecoration(
                              icon:  Icon(Icons.person,
                                color: Colors.grey,
                              ),
                              hintText: 'Username',
                            ),
                            textFieldBloc: _formBloc.emailField,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          height: 45,
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 2

                                )
                              ]
                          ),
                          child: TextFieldBlocBuilder(
                            keyboardType:  TextInputType.text,
                            suffixButton: SuffixButton.obscureText,
                            focusNode: _focusNodes[1],
                            decoration: InputDecoration(
                              icon:  Icon(Icons.vpn_key,
                                color: Colors.grey,
                              ),

                              hintText: 'Password',
                            ),
                            textFieldBloc: _formBloc.passwordField,
                          ),
                        ),
                         CheckboxFieldBlocBuilder(
                            booleanFieldBloc: _formBloc.isRememberMe,
                            body: Text(
                              'Remember me',style: TextStyle(
                              color: Colors.grey,
                            ),
                            ),
                          ),

                       Container(
                         width: MediaQuery.of(context).size.width/1.2,
                         height: 50,
                         margin: EdgeInsets.only(top: 10),
                         padding: EdgeInsets.only(
                             top: 4,left: 16, right: 16,bottom: 4
                         ),
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(
                                 Radius.circular(50)
                             ),
                         ),
                           child:ButtonTheme(
                             height: 50,
                             minWidth: double.infinity,
                             child: RaisedButton(
                                 color: Colors.lightBlueAccent,
                                 onPressed: (){
                                   _formBloc.submit();
                                   _focusNodes.clear();
                                 },
                                 child:Text(
                                   'Login',style: TextStyle(color :Colors.white),
                                 )
                             ),
                           )
                       ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}

