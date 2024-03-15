// وارد کردن کتابخانه ی مورد نیاز
import 'package:dino_vpn/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// تعریف کلاس APIService
class APIService {
  // تعریف متد آسنکرون loginUser که یک نمونه از کلاس LoginRequestModel را به عنوان ورودی میگیرد و یک Future<LoginResponseModel> برمی گرداند.
  Future<LoginResponseModel> loginUser(LoginRequestModel requestModel) async {
    // تعریف آدرس URL
    String url = "https://hub.archnets.com/api/v2/client/token";
    try {
      // ارسال درخواست POST به سرور با استفاده از کتابخانه http
      final response = await http.post(
        // تبدیل رشته URL به یک نمونه از کلاس Uri
        Uri.parse(url),
        // تعریف هدرهای درخواست
        headers: {
          'XMPus-API-Token': '15dde8524a8b998932564e11b3bd5fe5',
          'Content-Type': 'application/json'
        },
        // تبدیل داده های درخواست به فرمت JSON
        body: jsonEncode(
          requestModel.toJson(),
        ),
      );
      // بررسی وضعیت پاسخ دریافتی
      if (response.statusCode == 200 || response.statusCode == 400) {
        // در صورت موفقیت آمیز بودن درخواست، تبدیل پاسخ به یک نمونه از کلاس LoginResponseModel
        return LoginResponseModel.fromJson(json.decode(response.body));
      } else {
        // در صورت بروز خطا، پرتاب یک استثنا
        throw Exception('داده ها بارگیری نشدند.');
      }
    } catch (e) {
      print('خطا در هنگام ورود به سیستم: $e');
      return LoginResponseModel();
    }
  }
}
