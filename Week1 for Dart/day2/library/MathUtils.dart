library math_utils;

//int add(int firstNumber,int SecondNumber,[int carry])=>carry==null ? firstNumber+SecondNumber : firstNumber+SecondNumber+carry;

int add(int firstNumber,int SecondNumber,[int carry])=>firstNumber+SecondNumber+carry??0;