class CategoriesModel {
    CategoriesModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Datum> data;

    factory CategoriesModel.fromJson(Map<String, dynamic> json){ 
        return CategoriesModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.title,
        required this.slug,
        required this.products,
    });

    final dynamic? id;
    final String? title;
    final String? slug;
    final List<Product> products;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            title: json["title"],
            slug: json["slug"],
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        );
    }

}

class Product {
    Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.discountPercent,
        required this.discountAmount,
        required this.discountedPrice,
        required this.image,
        required this.category,
        required this.isFeatured,
        required this.featuredOrder,
        required this.featuredImage,
    });

    final dynamic? id;
    final String? title;
    final String? description;
    final dynamic? price;
    final String? discountPercent;
    final dynamic? discountAmount;
    final dynamic? discountedPrice;
    final String? image;
    final String? category;
    final bool? isFeatured;
    final dynamic? featuredOrder;
    final String? featuredImage;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            price: json["price"],
            discountPercent: json["discount_percent"],
            discountAmount: json["discount_amount"],
            discountedPrice: json["discounted_price"],
            image: json["image"],
            category: json["category"],
            isFeatured: json["is_featured"],
            featuredOrder: json["featured_order"],
            featuredImage: json["featured_image"],
        );
    }

}
