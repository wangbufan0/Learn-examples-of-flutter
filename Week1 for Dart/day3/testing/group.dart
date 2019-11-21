

import 'package:test/test.dart';

void main(){
  group('Stirng', (){
    test('test on splite()', (){
      var string = "foo,bar,baz";
      expect(string.split(","), equals(["foo", "bar", "baz"])); 
    });

    test('test on trim()', (){
      var string = ' foo  ';
      expect(string.trim(), 'foo');
    });
  });

}