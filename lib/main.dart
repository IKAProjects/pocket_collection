import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocket_collection/src/domain/models/collection_model.dart';
import 'package:pocket_collection/src/domain/models/item_model.dart';
import 'app.dart';
import 'di.dart';
import 'src/domain/models/achievement_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(CollectionModelAdapter());
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(AchievementModelAdapter());
  setUpDependencies();

  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (BuildContext context, Widget? child) => const MyApp(),
    ),
  );
}
