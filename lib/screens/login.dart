import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todoapp/screens/signin.dart';
import 'package:todoapp/widgets/app_color.dart';
import 'package:todoapp/mixins/loginmixin.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _SigninState();
}

class _SigninState extends State<Login> with LoginMixin {
  /// mixins/loginmixin.dart kullanıyorum
  @override
  Widget build(BuildContext context) {
    final appbarlength = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: appbarlength,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            SizedBox(height: 70),
            Center(
              child: Text(
                'Welcome back!',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.06,

              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: emailcont,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 12),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,

            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: passcontroller,
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
          ),
          SizedBox(height: 70),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
              ),
              onPressed: () async {
                await LogInWithEmailAndPassword(
                  //fonksn napcagını yukarda tanımladk burda kullanıyoruz burdan degeri alıp yukarı fonksa gidiyo eger baarılı olursa yine yukarda task sayfasına geciriyo
                  emailcont.text.trim(),
                  passcontroller.text.trim(),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          SizedBox(height: 12),

          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGray,
              ),
              onPressed: () => navigateToSignIn(),

              child: Text(
                'Sign up',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 12),

          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => print('tıklandı'),
              child: Text(
                'Forget Password',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
