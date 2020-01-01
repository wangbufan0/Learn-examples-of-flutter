import 'package:flutter_app_week6/user_response_entity.dart';
import 'package:flutter_app_week6/generated/json/base/json_filed.dart';

userResponseEntityFromJson(UserResponseEntity data, Map<String, dynamic> json) {
	if (json['results'] != null) {
		data.results = new List<UserResponseResults>();
		(json['results'] as List).forEach((v) {
			data.results.add(new UserResponseResults().fromJson(v));
		});
	}
	data.error = json['error'];
	return data;
}

Map<String, dynamic> userResponseEntityToJson(UserResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.results != null) {
		data['results'] =  entity.results.map((v) => v.toJson()).toList();
	}
	data['error'] = entity.error;
	return data;
}

userResponseResultsFromJson(UserResponseResults data, Map<String, dynamic> json) {
	data.gender = json['gender'];
	data.name = json['name'] != null ? new UserResponseResultsName().fromJson(json['name']) : null;
	data.location = json['location'] != null ? new UserResponseResultsLocation().fromJson(json['location']) : null;
	data.email = json['email'];
	data.login = json['login'] != null ? new UserResponseResultsLogin().fromJson(json['login']) : null;
	data.dob = json['dob'] != null ? new UserResponseResultsDob().fromJson(json['dob']) : null;
	data.registered = json['registered'] != null ? new UserResponseResultsRegistered().fromJson(json['registered']) : null;
	data.phone = json['phone'];
	data.cell = json['cell'];
	data.id = json['id'] != null ? new UserResponseResultsId().fromJson(json['id']) : null;
	data.picture = json['picture'] != null ? new UserResponseResultsPicture().fromJson(json['picture']) : null;
	data.nat = json['nat'];
	return data;
}

Map<String, dynamic> userResponseResultsToJson(UserResponseResults entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['gender'] = entity.gender;
	if (entity.name != null) {
		data['name'] = UserResponseResultsName().toJson();
	}
	if (entity.location != null) {
		data['location'] = UserResponseResultsLocation().toJson();
	}
	data['email'] = entity.email;
	if (entity.login != null) {
		data['login'] = UserResponseResultsLogin().toJson();
	}
	if (entity.dob != null) {
		data['dob'] = UserResponseResultsDob().toJson();
	}
	if (entity.registered != null) {
		data['registered'] = UserResponseResultsRegistered().toJson();
	}
	data['phone'] = entity.phone;
	data['cell'] = entity.cell;
	if (entity.id != null) {
		data['id'] = UserResponseResultsId().toJson();
	}
	if (entity.picture != null) {
		data['picture'] = UserResponseResultsPicture().toJson();
	}
	data['nat'] = entity.nat;
	return data;
}

userResponseResultsNameFromJson(UserResponseResultsName data, Map<String, dynamic> json) {
	data.title = json['title'];
	data.first = json['first'];
	data.last = json['last'];
	return data;
}

Map<String, dynamic> userResponseResultsNameToJson(UserResponseResultsName entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['title'] = entity.title;
	data['first'] = entity.first;
	data['last'] = entity.last;
	return data;
}

userResponseResultsLocationFromJson(UserResponseResultsLocation data, Map<String, dynamic> json) {
	data.street = json['street'] != null ? new UserResponseResultsLocationStreet().fromJson(json['street']) : null;
	data.city = json['city'];
	data.state = json['state'];
	data.country = json['country'];
	data.postcode = json['postcode'];
	data.coordinates = json['coordinates'] != null ? new UserResponseResultsLocationCoordinates().fromJson(json['coordinates']) : null;
	data.timezone = json['timezone'] != null ? new UserResponseResultsLocationTimezone().fromJson(json['timezone']) : null;
	return data;
}

Map<String, dynamic> userResponseResultsLocationToJson(UserResponseResultsLocation entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.street != null) {
		data['street'] = UserResponseResultsLocationStreet().toJson();
	}
	data['city'] = entity.city;
	data['state'] = entity.state;
	data['country'] = entity.country;
	data['postcode'] = entity.postcode;
	if (entity.coordinates != null) {
		data['coordinates'] = UserResponseResultsLocationCoordinates().toJson();
	}
	if (entity.timezone != null) {
		data['timezone'] = UserResponseResultsLocationTimezone().toJson();
	}
	return data;
}

userResponseResultsLocationStreetFromJson(UserResponseResultsLocationStreet data, Map<String, dynamic> json) {
	data.number = json['number'];
	data.name = json['name'];
	return data;
}

Map<String, dynamic> userResponseResultsLocationStreetToJson(UserResponseResultsLocationStreet entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['number'] = entity.number;
	data['name'] = entity.name;
	return data;
}

userResponseResultsLocationCoordinatesFromJson(UserResponseResultsLocationCoordinates data, Map<String, dynamic> json) {
	data.latitude = json['latitude'];
	data.longitude = json['longitude'];
	return data;
}

Map<String, dynamic> userResponseResultsLocationCoordinatesToJson(UserResponseResultsLocationCoordinates entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	return data;
}

userResponseResultsLocationTimezoneFromJson(UserResponseResultsLocationTimezone data, Map<String, dynamic> json) {
	data.offset = json['offset'];
	data.description = json['description'];
	return data;
}

Map<String, dynamic> userResponseResultsLocationTimezoneToJson(UserResponseResultsLocationTimezone entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['offset'] = entity.offset;
	data['description'] = entity.description;
	return data;
}

userResponseResultsLoginFromJson(UserResponseResultsLogin data, Map<String, dynamic> json) {
	data.uuid = json['uuid'];
	data.username = json['username'];
	data.password = json['password'];
	data.salt = json['salt'];
	data.md5 = json['md5'];
	data.sha1 = json['sha1'];
	data.sha256 = json['sha256'];
	return data;
}

Map<String, dynamic> userResponseResultsLoginToJson(UserResponseResultsLogin entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uuid'] = entity.uuid;
	data['username'] = entity.username;
	data['password'] = entity.password;
	data['salt'] = entity.salt;
	data['md5'] = entity.md5;
	data['sha1'] = entity.sha1;
	data['sha256'] = entity.sha256;
	return data;
}

userResponseResultsDobFromJson(UserResponseResultsDob data, Map<String, dynamic> json) {
	data.date = json['date'];
	data.age = json['age'];
	return data;
}

Map<String, dynamic> userResponseResultsDobToJson(UserResponseResultsDob entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['age'] = entity.age;
	return data;
}

userResponseResultsRegisteredFromJson(UserResponseResultsRegistered data, Map<String, dynamic> json) {
	data.date = json['date'];
	data.age = json['age'];
	return data;
}

Map<String, dynamic> userResponseResultsRegisteredToJson(UserResponseResultsRegistered entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['age'] = entity.age;
	return data;
}

userResponseResultsIdFromJson(UserResponseResultsId data, Map<String, dynamic> json) {
	data.name = json['name'];
	data.value = json['value'];
	return data;
}

Map<String, dynamic> userResponseResultsIdToJson(UserResponseResultsId entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['value'] = entity.value;
	return data;
}

userResponseResultsPictureFromJson(UserResponseResultsPicture data, Map<String, dynamic> json) {
	data.large = json['large'];
	data.medium = json['medium'];
	data.thumbnail = json['thumbnail'];
	return data;
}

Map<String, dynamic> userResponseResultsPictureToJson(UserResponseResultsPicture entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['large'] = entity.large;
	data['medium'] = entity.medium;
	data['thumbnail'] = entity.thumbnail;
	return data;
}