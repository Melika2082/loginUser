import 'package:dino_vpn/model/login_model.dart';
import 'package:dino_vpn/api/api_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = '';
  final Color _emailColor = Colors.white;
  final Color _passwordColor = Colors.white;
  bool isApiProcess = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginRequestModel? requestModel;
  bool inAsyncCallProcess = false;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _uiStep(context);
  }

  Widget _uiStep(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 17, 24, 40),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ورود کاربر',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (input) => requestModel!.email = input,
                  controller: _emailController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelText: ' آدرس ایمیل ',
                    labelStyle: TextStyle(
                      color: _emailColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: _emailColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: _emailColor,
                        width: 2,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: _emailColor,
                  ),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'آدرس ایمیل معتبر نمی باشد.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => requestModel!.password = input,
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: ' رمز عبور ',
                    labelStyle: TextStyle(
                      color: _passwordColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: _passwordColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(
                        color: _passwordColor,
                        width: 2,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: _passwordColor,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  style: TextStyle(
                    color: _passwordColor,
                  ),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'رمز عبور باید حداقل سه رقم باشد.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(() {
                          isApiProcess = true;
                        });

                        APIService apiService = APIService();
                        apiService.loginUser(requestModel!).then((value) {
                          setState(() {
                            inAsyncCallProcess = false;
                          });

                          if (value.token!.isNotEmpty) {
                            const snackBar = SnackBar(
                              content:
                                  Text('ورود به حساب کاربری موفقیت آمیز بود'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('ورود به حساب کاربری ناموفق بود'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }).catchError((error) {
                          setState(() {
                            inAsyncCallProcess = false;
                          });
                          final snackBar = SnackBar(
                              content: Text(
                                  'خطا در هنگام ورود به حساب کاربری: $error'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      print(requestModel?.toJson());
                    },
                    child: const Text(
                      'ورود به حساب کاربری',
                      style: TextStyle(
                        color: Color.fromARGB(255, 17, 24, 40),
                        fontSize: 16,
                        fontFamily: 'vazir',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color:
                        _errorMessage == 'ورود به حساب کاربری موفقیت آمیز بود'
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
