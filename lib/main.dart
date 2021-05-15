import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/api/auth_service.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          catchError: (_, __) => null,
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider<AdvertProvider>(
          create: (context) => AdvertProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: kColorOne,
        ),
        // home: UploadToFirebaseStorage(),
        // home: Login(),
        home: HomeScreen(),
      ),
    );
  }
}
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:kakaaga/johannes_milke/todo_app/provider/todos.dart';
// import 'package:kakaaga/johannes_milke/todo_app/page/home_page.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static final String title = 'Todo App With Firebase';

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (context) => TodosProvider(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//  //         title: title,
//           theme: ThemeData(
//             primarySwatch: Colors.pink,
//             scaffoldBackgroundColor: Color(0xFFf6f5ee),
//           ),
//           home: HomePage(),
//         ),
//       );
// }
