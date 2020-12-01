import 'dart:async';
import 'dart:io';


void swap<T>(List<T> arr, int index1, int index2) {
  if (index1 <= arr.length && index2 <= arr.length) {
    final a = arr[index1];
    final b = arr[index2];
    arr[index2] = a;
    arr[index1] = b;
  } else {
    print("index out of range");
  }
}

void rotateL<T>(List<T> arr) {
  final l = arr[0];
  arr.removeAt(0);
  arr.add(l);
}

List<T> rotateR<T>(List<T> arr) {
  final r = arr[arr.length - 1];
  arr.removeLast();
  List<T> tmp = [];
  tmp.add(r);
  for (int i = 0; i < arr.length; i++) {
    tmp.add(arr[i]);
  }
  return tmp;
}


bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

