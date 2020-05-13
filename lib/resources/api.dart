import 'package:project_inovation/core/blocs/transorder_bloc.dart';
import 'package:project_inovation/core/models/login_model.dart';
import 'package:project_inovation/core/models/transorder_model.dart';
import 'package:project_inovation/core/models/transroute_model.dart';
import 'package:project_inovation/resources/network.dart';

class API {
  NetworkHelper _networkHelper = NetworkHelper();
  Future loginAPI(PostLoginModel body) async {
    var result = await _networkHelper.postLogin(body);
    return result;
  }
  Future TransorderAPI(PostTMSModel body) async{
    var result = await _networkHelper.createTransorder(body);
    return result;
  }
  Future TransRouteAPI(TransRoute body) async{
    var result = await _networkHelper.transroute(body);
    return result;
  }
}
