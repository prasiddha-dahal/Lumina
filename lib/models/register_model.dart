class RegisterModel {
    RegisterModel({
        required this.success,
        required this.token,
        required this.message,
    });

    final bool? success;
    final String? token;
    final String? message;

    factory RegisterModel.fromJson(Map<String, dynamic> json){ 
                final successValue = json["success"];
                bool? parsedSuccess;
                if (successValue is bool) {
                    parsedSuccess = successValue;
                } else if (successValue is String) {
                    final s = successValue.toLowerCase();
                    if (s == 'true') parsedSuccess = true;
                    else if (s == 'false') parsedSuccess = false;
                } else if (successValue is num) {
                    parsedSuccess = successValue == 1;
                }

                return RegisterModel(
                        success: parsedSuccess,
                        token: json["token"]?.toString(),
                        message: json["message"]?.toString(),
                );
    }

}
