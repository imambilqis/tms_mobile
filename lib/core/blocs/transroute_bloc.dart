import 'dart:async';
import 'package:dio/dio.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_inovation/core/models/transroute_model.dart';
import 'package:project_inovation/resources/api.dart';

class TransrouteBloc extends FormBloc<String, String> {
  final API api = API();
  final toIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final fromIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );

  TransrouteBloc() {
    prefillFields();
  }

  void dispose() {
    toIdField.close();
    fromIdField.close();
  }

  void prefillFields() async {
    final storage = await SharedPreferences.getInstance();

    toIdField.updateInitialValue(storage.getString('toId'));
    fromIdField.updateInitialValue(storage.getString('fromId'));
  }

  @override
  List<FieldBloc> get fieldBlocs => [toIdField, fromIdField];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    final storage = await SharedPreferences.getInstance();
    /*try {
      TransRoute body = TransRoute(
        toId: toIdField.value,
        fromId: fromIdField.value,
      );
      var response = await api.TransRouteAPI(body).timeout(
        Duration(seconds: 10),
      );
    }
  }*/}
}