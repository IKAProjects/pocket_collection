import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_collection/src/data/collection_repository.dart';
import 'package:pocket_collection/src/data/item_repository.dart';
import 'package:pocket_collection/src/ui/screens/blocs/collection_bloc/collection_bloc.dart';
import 'package:pocket_collection/src/ui/screens/blocs/item_bloc/item_bloc.dart';
import 'package:provider/provider.dart';

import 'di.dart';
import 'src/infrastructure/routes/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    _router = buildRouter(context);
    super.initState();
  }

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        routerDelegate: _router.routerDelegate,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}
