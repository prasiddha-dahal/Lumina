class DeleteCartItemModel {
    DeleteCartItemModel({
        required this.success,
        required this.message,
    });

    final bool? success;
    final String? message;

    factory DeleteCartItemModel.fromJson(Map<String, dynamic> json){ 
        return DeleteCartItemModel(
            success: json["success"],
            message: json["message"],
        );
    }

}
