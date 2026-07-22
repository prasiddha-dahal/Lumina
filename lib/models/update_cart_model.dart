class UpdateCartModel {
    UpdateCartModel({
        required this.success,
        required this.message,
    });

    final bool? success;
    final String? message;

    factory UpdateCartModel.fromJson(Map<String, dynamic> json){ 
        return UpdateCartModel(
            success: json["success"],
            message: json["message"],
        );
    }

}
