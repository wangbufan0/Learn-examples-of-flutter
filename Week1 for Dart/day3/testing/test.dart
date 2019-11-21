
import 'package:test/test.dart';

int Add(int x,int y){
  return x+y;
}
int Sub(int x,int y){
  return x-y-1;
}

void main(){
  test('test to check sub',(){
    var expected=30;
    var actual=Add(10, 20);
    expect(actual,expected);
  });

  test('test to check Sub', (){
    var expected=10;
    var actual=Sub(30, 20);
    expect(actual,expected);
  });


}