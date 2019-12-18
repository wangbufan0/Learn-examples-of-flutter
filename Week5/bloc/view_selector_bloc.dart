import 'package:bloc/bloc.dart';

///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///  


class ViewSelectBloc extends Bloc<int,int>{

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int event) async*{
    yield event;
  }


}
