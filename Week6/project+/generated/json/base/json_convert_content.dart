// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_app_week6/dio/user_response_entity.dart';
import 'package:flutter_app_week6/generated/json/user_response_entity_helper.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
      case UserResponseEntity:
        return userResponseEntityFromJson(data as UserResponseEntity, json)
            as T;
      case UserResponseResults:
        return userResponseResultsFromJson(data as UserResponseResults, json)
            as T;
      case UserResponseResultsName:
        return userResponseResultsNameFromJson(
            data as UserResponseResultsName, json) as T;
      case UserResponseResultsLocation:
        return userResponseResultsLocationFromJson(
            data as UserResponseResultsLocation, json) as T;
      case UserResponseResultsLocationStreet:
        return userResponseResultsLocationStreetFromJson(
            data as UserResponseResultsLocationStreet, json) as T;
      case UserResponseResultsLocationCoordinates:
        return userResponseResultsLocationCoordinatesFromJson(
            data as UserResponseResultsLocationCoordinates, json) as T;
      case UserResponseResultsLocationTimezone:
        return userResponseResultsLocationTimezoneFromJson(
            data as UserResponseResultsLocationTimezone, json) as T;
      case UserResponseResultsLogin:
        return userResponseResultsLoginFromJson(
            data as UserResponseResultsLogin, json) as T;
      case UserResponseResultsDob:
        return userResponseResultsDobFromJson(
            data as UserResponseResultsDob, json) as T;
      case UserResponseResultsRegistered:
        return userResponseResultsRegisteredFromJson(
            data as UserResponseResultsRegistered, json) as T;
      case UserResponseResultsId:
        return userResponseResultsIdFromJson(
            data as UserResponseResultsId, json) as T;
      case UserResponseResultsPicture:
        return userResponseResultsPictureFromJson(
            data as UserResponseResultsPicture, json) as T;
    }
    return data as T;
  }

  static getToJson<T>(Type type, data) {
    switch (type) {
      case UserResponseEntity:
        return userResponseEntityToJson(data as UserResponseEntity);
      case UserResponseResults:
        return userResponseResultsToJson(data as UserResponseResults);
      case UserResponseResultsName:
        return userResponseResultsNameToJson(data as UserResponseResultsName);
      case UserResponseResultsLocation:
        return userResponseResultsLocationToJson(
            data as UserResponseResultsLocation);
      case UserResponseResultsLocationStreet:
        return userResponseResultsLocationStreetToJson(
            data as UserResponseResultsLocationStreet);
      case UserResponseResultsLocationCoordinates:
        return userResponseResultsLocationCoordinatesToJson(
            data as UserResponseResultsLocationCoordinates);
      case UserResponseResultsLocationTimezone:
        return userResponseResultsLocationTimezoneToJson(
            data as UserResponseResultsLocationTimezone);
      case UserResponseResultsLogin:
        return userResponseResultsLoginToJson(data as UserResponseResultsLogin);
      case UserResponseResultsDob:
        return userResponseResultsDobToJson(data as UserResponseResultsDob);
      case UserResponseResultsRegistered:
        return userResponseResultsRegisteredToJson(
            data as UserResponseResultsRegistered);
      case UserResponseResultsId:
        return userResponseResultsIdToJson(data as UserResponseResultsId);
      case UserResponseResultsPicture:
        return userResponseResultsPictureToJson(
            data as UserResponseResultsPicture);
    }
    return data as T;
  }

  static T fromJsonAsT<T>(json) {
    switch (T.toString()) {
      case 'UserResponseEntity':
        return UserResponseEntity().fromJson(json) as T;
      case 'UserResponseResults':
        return UserResponseResults().fromJson(json) as T;
      case 'UserResponseResultsName':
        return UserResponseResultsName().fromJson(json) as T;
      case 'UserResponseResultsLocation':
        return UserResponseResultsLocation().fromJson(json) as T;
      case 'UserResponseResultsLocationStreet':
        return UserResponseResultsLocationStreet().fromJson(json) as T;
      case 'UserResponseResultsLocationCoordinates':
        return UserResponseResultsLocationCoordinates().fromJson(json) as T;
      case 'UserResponseResultsLocationTimezone':
        return UserResponseResultsLocationTimezone().fromJson(json) as T;
      case 'UserResponseResultsLogin':
        return UserResponseResultsLogin().fromJson(json) as T;
      case 'UserResponseResultsDob':
        return UserResponseResultsDob().fromJson(json) as T;
      case 'UserResponseResultsRegistered':
        return UserResponseResultsRegistered().fromJson(json) as T;
      case 'UserResponseResultsId':
        return UserResponseResultsId().fromJson(json) as T;
      case 'UserResponseResultsPicture':
        return UserResponseResultsPicture().fromJson(json) as T;
    }
    return null;
  }
}
