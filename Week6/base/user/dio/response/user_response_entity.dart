import 'package:flutter_app_week6/generated/json/base/json_convert_content.dart';

class UserResponseEntity with JsonConvert<UserResponseEntity> {
	List<UserResponseResults> results;
	String error;

	UserResponseEntity withError(String errorValue){
		results=List();
		error=errorValue;
		return this;
	}

}

class UserResponseResults with JsonConvert<UserResponseResults> {
	String gender;
	UserResponseResultsName name;
	UserResponseResultsLocation location;
	String email;
	UserResponseResultsLogin login;
	UserResponseResultsDob dob;
	UserResponseResultsRegistered registered;
	String phone;
	String cell;
	UserResponseResultsId id;
	UserResponseResultsPicture picture;
	String nat;
}

class UserResponseResultsName with JsonConvert<UserResponseResultsName> {
	String title;
	String first;
	String last;
}

class UserResponseResultsLocation with JsonConvert<UserResponseResultsLocation> {
	UserResponseResultsLocationStreet street;
	String city;
	String state;
	String country;
	int postcode;
	UserResponseResultsLocationCoordinates coordinates;
	UserResponseResultsLocationTimezone timezone;
}

class UserResponseResultsLocationStreet with JsonConvert<UserResponseResultsLocationStreet> {
	int number;
	String name;
}

class UserResponseResultsLocationCoordinates with JsonConvert<UserResponseResultsLocationCoordinates> {
	String latitude;
	String longitude;
}

class UserResponseResultsLocationTimezone with JsonConvert<UserResponseResultsLocationTimezone> {
	String offset;
	String description;
}

class UserResponseResultsLogin with JsonConvert<UserResponseResultsLogin> {
	String uuid;
	String username;
	String password;
	String salt;
	String md5;
	String sha1;
	String sha256;
}

class UserResponseResultsDob with JsonConvert<UserResponseResultsDob> {
	String date;
	int age;
}

class UserResponseResultsRegistered with JsonConvert<UserResponseResultsRegistered> {
	String date;
	int age;
}

class UserResponseResultsId with JsonConvert<UserResponseResultsId> {
	String name;
	String value;
}

class UserResponseResultsPicture with JsonConvert<UserResponseResultsPicture> {
	String large;
	String medium;
	String thumbnail;
}
