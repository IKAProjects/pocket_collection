import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_collection/src/domain/models/expensive_item_model.dart';
import 'package:pocket_collection/src/ui/screens/achievements/achievements_screen.dart';
import 'package:pocket_collection/src/ui/screens/collections/collections_screen.dart';
import 'package:pocket_collection/src/ui/screens/colletion_items/collection_items_screen.dart';
import 'package:pocket_collection/src/ui/screens/expensive_items/expensive_items_screen.dart';
import 'package:pocket_collection/src/ui/screens/expensive_items_details/expensive_items_details_screen.dart';
import 'package:pocket_collection/src/ui/screens/item_info/item_info_screen.dart';

import '../../domain/models/collection_model.dart';
import '../../domain/models/item_model.dart';
import '../../ui/screens/navigation/navigation_screen.dart';
import '../../ui/screens/onboarding/onboarding.dart';
import '../../ui/screens/settings/settings_screen.dart';
import '../utils/custom_transition.dart';

final class Routes {
  static const onboarding = '/onboarding';
  static const collections = '/collections';
  static const collectionItems = '/collectionItems';
  static const itemInfo = '/itemInfo';
  static const addItem = '/addItem';
  static const achievements = '/achievements';
  static const expensive = '/expensive';
  static const expensiveDetails = '/expensiveDetails';
  static const settings = '/settings';
}

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    initialLocation: Routes.onboarding,
    routes: [
      GoRoute(
        name: Routes.onboarding,
        path: Routes.onboarding,
        builder: (context, state) {
          return const Onboarding();
        },
      ),
      ShellRoute(
        pageBuilder: (context, state, child) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: NavigationScreen(child: child),
          );
        },
        routes: [
          GoRoute(
            name: Routes.collections,
            path: Routes.collections,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: CollectionsScreen(),
              );
            },
          ),
          GoRoute(
            name: Routes.achievements,
            path: Routes.achievements,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: AchievementsScreen(),
              );
            },
          ),
          GoRoute(
            name: Routes.expensive,
            path: Routes.expensive,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: ExpensiveItemsScreen(),
              );
            },
          ),
          GoRoute(
            name: Routes.settings,
            path: Routes.settings,
            pageBuilder: (context, state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: SettingsScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: Routes.collectionItems,
        path: Routes.collectionItems,
        builder: (context, state) {
          final collection = state.extra as CollectionModel;

          return CollectionItemsScreen(
            collectionModel: collection,
          );
        },
      ),
      GoRoute(
        name: Routes.itemInfo,
        path: Routes.itemInfo,
        builder: (context, state) {
          final item = state.extra as ItemModel;
          return ItemInfoScreen(itemModel: item);
        },
      ),
      GoRoute(
        name: Routes.expensiveDetails,
        path: Routes.expensiveDetails,
        builder: (context, state) {
          final expensiveItem = state.extra as ExpensiveItemModel;
          return ExpensiveItemsDetailsScreen(expensiveItemModel: expensiveItem);
        },
      ),
    ],
  );
}
