import 'dart:async';
import 'package:dio/dio.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_inovation/core/models/transorder_model.dart';
import 'package:project_inovation/resources/api.dart';

class TransorderBloc extends FormBloc<String, String> {
  final API api = API();
  final shipmentTypeIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final customerIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final fleetIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final driverIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final paymentTypeIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final productIdField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final dateETDField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );
  final dateETAField = TextFieldBloc(
    validators: [FieldBlocValidators.requiredTextFieldBloc],
  );

  TransorderBloc() {
    prefillFields();
  }

  void dispose() {
    shipmentTypeIdField.close();
    customerIdField.close();
    fleetIdField.close();
    driverIdField.close();
    paymentTypeIdField.close();
    productIdField.close();
    dateETDField.close();
    dateETAField.close();
  }

  void prefillFields() async {
    final storage = await SharedPreferences.getInstance();

    shipmentTypeIdField.updateInitialValue(storage.getString('shipmentTypeId'));
    customerIdField.updateInitialValue(storage.getString('customerId'));
    fleetIdField.updateInitialValue(storage.getString('fleetId'));
    driverIdField.updateInitialValue(storage.getString('driverId'));
    paymentTypeIdField.updateInitialValue(storage.getString('paymentTypeId'));
    productIdField.updateInitialValue(storage.getString('productId'));
    dateETDField.updateInitialValue(storage.getString('dateETD'));
    dateETAField.updateInitialValue(storage.getString('dateETA'));
  }

  @override
  List<FieldBloc> get fieldBlocs =>
      [
        shipmentTypeIdField,
        customerIdField,
        fleetIdField,
        driverIdField,
        paymentTypeIdField,
        productIdField,
        dateETDField,
        dateETAField
      ];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    final storage = await SharedPreferences.getInstance();

      PostTMSModel body = PostTMSModel(
        shipmentTypeId: shipmentTypeIdField.value,
        customerId: customerIdField.value,
        fleetId: fleetIdField.value,
        driverId: driverIdField.value,
        paymentTypeId: paymentTypeIdField.value,
        productId: productIdField.value,
        dateETD: dateETDField.value,
        dateETA: dateETAField.value,
      );
      var response = await api.TransorderAPI(body).timeout(
        Duration(seconds: 10),
      );


    }

}