
import 'package:flutter_app_week6/base/bloc/base_state.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

enum UserStateValues {
  loading,
  error,
  success,
}

// ignore: must_be_immutable
class UserState extends BaseState {

  UserStateValues state;
  var data;

  UserState({this.state,this.data});

  @override
  BaseState initial() {
    state=UserStateValues.loading;
    data=null;
    return this;
  }

  @override
  // TODO: implement props
  List<Object> get props => [state,data];


}
