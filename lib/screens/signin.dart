import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/widgets/app_color.dart';
import 'package:todoapp/mixins/signinmixin.dart';

final AuthServices services = AuthServices();
TextEditingController emailcont = TextEditingController();
TextEditingController passcontroller = TextEditingController();

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with SigninMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: 120),

          Center(
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 15),

          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: emailcont,
              decoration: InputDecoration(
                labelText: '  Email',
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.only(left: 12),
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
                border: OutlineInputBorder(borderSide: BorderSide.none),
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
                if (emailcont.text.isEmpty || passcontroller.text.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('hata')));
                } else {
                  await SigninWithEmailAndPassword(
                    ///Signinmixin içinde tanımlı fonksiyon
                    emailcont.text.trim(),
                    passcontroller.text.trim(),
                  );
                  emailcont.clear();
                  passcontroller.clear();
                }
              },

              child: Text(
                'Kaydet',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () => navigateToLogin(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGray,
              ),
              child: Text(
                'Hesabım var ',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
