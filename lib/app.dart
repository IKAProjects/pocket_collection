import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_collection/src/data/collection_repository.dart';
import 'package:pocket_collection/src/data/item_repository.dart';
import 'package:pocket_collection/src/ui/screens/blocs/collection_bloc/collection_bloc.dart';
import 'package:pocket_collection/src/ui/screens/blocs/item_bloc/item_bloc.dart';
import 'package:pocket_collection/src/ui/screens/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

import 'di.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CollectionRepository>(
          create: (_) => getIt<CollectionRepository>(),
        ),
        BlocProvider<CollectionBloc>(
          create: (context) =>
              CollectionBloc(context.read<CollectionRepository>()),
        ),
        Provider<ItemRepository>(
          create: (_) => getIt<ItemRepository>(),
        ),
        BlocProvider<ItemBloc>(
          create: (context) => ItemBloc(context.read<ItemRepository>()),
        ),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket collection',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Roboto',
          highlightColor: Colors.transparent,
        ),
        home: const Onboarding(),
      ),
    );
  }
}
