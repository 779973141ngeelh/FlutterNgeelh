import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatefulWidget {
@override
_LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
String userID = '';
String password = '';
Future<void> _login() async {
if (_formKey.currentState!.validate()) {
_formKey.currentState!.save();
try {
final response = await http.post(
Uri.parse('https://example.com/api/login'),
headers: {
'Content-Type': 'application/json',
},body: jsonEncode({
'userID': userID,
'password': password,
}),
);
if (response.statusCode == 200) {
Navigator.pushNamed(context, '/home');
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('account')
),);
}
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('serves err')
),);
}
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
   backgroundColor: Colors.white,
   body: Column(
     children:[
      
          Row(

          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/IMG_٢٠٢٥٠٤٢٣_٠٧٥٢١٤ - Copy.jpg'),
                      fit: BoxFit.cover)),
            ),
              SizedBox(
                        width: 5),
            Positioned(
              top: 0,
              right: -5,
              child: Container(
                          padding: EdgeInsets.all(50),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: IconButton(
                                    child: Icon(Icons.language),
                                    size: 17,
                                    color: Colors.white,
                                    onPressed:(){
                                      
                              
                                       
                              String selectedLanguage = 'English';
                              
                                void showLanguageDialog(BuildContext context) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose Language'),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedLanguage = 'Arabic';
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('لغة عربية'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedLanguage = 'English';
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('English'),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                         
                                            print('Selected Language: $selectedLanguage');
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Apply'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                }
                              
                              
                                    }
                              ),
                            ),
                            ),
                              
                          ),
                        ),
          ],
        ),
      
            SizedBox(
                  height: 10,),
                 
                   Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w800),
                  ),
                ),

                SizedBox(
                  height: 10,),

                  
                   Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
        );

       Padding(
       padding: const EdgeInsets.all(20.0),
       child: Form(
       key: _formKey,
       child: Column(
       children: [
       TextFormField(
       decoration: InputDecoration(
        
       labelText: 'userID'
       ),
       
       validator: (value) {
       if (value==null|| value.isEmpty) {
        return "Enter your userID";
       
       }
       
       },
       onSaved: (value) => userID = value!,
       ),

       SizedBox(
                  height: 10,),
       TextFormField(
       decoration: InputDecoration(
       labelText: 'Password'
       ),
       obscureText: true,
       validator: (value) {
       if (value==null ||value.isEmpty) {
       return 'Enter your Password';
       }
       
       },
       onSaved: (value) => password = value!,
       ),
       SizedBox(height: 20,),
       Text('Show more',style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
       ),),

         SizedBox(height: 20,),
        InkWell(
                  onTap:_login ,
                   
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xff13323E),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 17,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

       SizedBox(
                  height: 10,),
                  Center(
                    child: Image.asset('images/IMG_٢٠٢٥٠٤٢٣_٠٧٥٠٠٠.jpg'),
                    
                    
                  )
       ],
       ),
       ),
       ),
     ],),
   

}
}