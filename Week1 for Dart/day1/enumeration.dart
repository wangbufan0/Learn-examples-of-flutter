

enum WEEK{
  SUN,
  MON,
  TUES,
  WED,
  THUR,
  FRI,
  SAT,
}

void main(){

  print(WEEK.values);
  WEEK.values.forEach((v)=>print('$v\'s index is ${v.index}'));
}