// تعریف کلاس LoginResponseModel
class LoginResponseModel {
  // تعریف دو فیلد اختیاری از نوع رشته: token و error
  final String? token;
  final String? error;

  // تعریف سازنده کلاس که می تواند token و error را دریافت کند
  LoginResponseModel({
    this.token,
    this.error,
  });

  // تعریف یک متد کارخانه ای که یک Map را دریافت کرده و یک نمونه از LoginResponseModel را برمی گرداند
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      // اگر token در json وجود نداشته باشد، مقدار پیش فرض آن را به عنوان رشته خالی تنظیم می کند
      token: json['data']['token'] ?? '',
      // اگر status در json برابر با 'success' باشد، مقدار error را null قرار می دهد، در غیر این صورت، مقدار status را به عنوان error قرار می دهد
      error: json['status'] == 'success' ? null : json['status'],
    );
  }
}

// تعریف کلاس LoginRequestModel
class LoginRequestModel {
  // تعریف دو فیلد اختیاری از نوع رشته: email و password
  String? email;
  String? password;

  // تعریف سازنده کلاس که می‌تواند email و password را دریافت کند
  LoginRequestModel({
    this.email,
    this.password,
  });

  // تعریف یک متد که یک Map را برمی‌گرداند
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      // اضافه کردن email و password به map پس از حذف فاصله‌های اضافی از ابتدا و انتهای آن‌ها
      'email': email!.trim(),
      'password': password!.trim(),
    };

    // برگرداندن map
    return map;
  }
}
