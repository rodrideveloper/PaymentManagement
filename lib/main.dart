import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymen/bloc/people_bloc.dart';
import 'package:paymen/firebase_options.dart';
import 'package:paymen/pages/home_page.dart';
import 'package:paymen/services.dart/people_service.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            PeopleBloc(peopleService: PeopleService())..add(GetPeopleEvent()),
        child: const HomePAge(),
      ),
    );
  }
}
