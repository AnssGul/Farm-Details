import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';

class TaskProvider extends GetConnect {
  // Fetch Data
  Future<List<dynamic>> getTask(var page) async {
    try {
      final response = await get(
          "http://192.168.43.152:81/TodoApp/public/api/getTask?page=$page");
      if (response.status.hasError) {
        return Future.error(response.statusText as Object);
      } else {
        return response.body['data'];
      }
    }
    catch(exception)
    {

      return Future.error(exception.toString());
    }
  }

  //Save Data
  Future<String> saveTask(Map data) async {
    try
    {
      final response = await post(
          "http://192.168.43.152:81/TodoApp/public/api/saveTask",data);
      if (response.status.hasError) {
        return Future.error(response.statusText as Object);
      } else {
        return  response.body['result'];
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }

  // Update Data
  Future<String> updateTask(Map data) async {
    try {
      final response = await post(
          "http://192.168.43.152:81/TodoApp/public/api/updateTask", data);
      if (response.status.hasError) {
        return Future.error(response.statusText as Object);
      } else {
        return response.body['result'];
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }
  }
// Delete Data
  Future<String> deleteTask(Map data) async {
    try{
      final response = await post(
          "http://192.168.43.152:81/TodoApp/public/api/deleteTask",data);
      if (response.status.hasError) {
        return Future.error(response.statusText as Object);
      } else {
        return response.body['result'];
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }
}

//
//
// class UserProvider extends GetConnect{
//   Future <List<dynamic>> getUser() async {
//     final response = await get('https://randomuser.me/api/?results=10');
//     if(response.status.hasError){
//       return Future.error(response.hasError);
//     } else {
//       return response.body['results'];
//     }
//   }
// }
// class TaskProvider extends GetConnect {
// //   Future<List<dynamic>> getTask(int page) async {
// //     try {
// //       final response = await get('https://randomuser.me/api/?results=10&page=$page');
// //
// //       if (response.status.hasError) {
// //         return Future.error(response.statusText as Object);
// //       } else {
// //         return List<dynamic>.from(response.body['results']);
// //       }
// //     } catch (exception) {
// //       return Future.error(exception.toString());
// //     }
// //   }
// // }