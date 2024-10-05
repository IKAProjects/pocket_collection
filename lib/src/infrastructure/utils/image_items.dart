import '../../../gen/assets.gen.dart';
import '../../domain/models/image_item.dart';
import '../routes/app_router.dart';

List<ImageItem> imageItems = [
  ImageItem(
    id: 0,
    asset: Assets.svg.collections,
    path: Routes.collections,
    name: 'Collections',
  ),
  ImageItem(
    id: 1,
    asset: Assets.svg.star,
    path: Routes.achievements,
    name: 'Achievements',
  ),
  ImageItem(
    id: 2,
    asset: Assets.svg.dollar,
    path: Routes.expensive,
    name: 'Expensive Items',
  ),
  ImageItem(
    id: 3,
    asset: Assets.svg.gear,
    path: Routes.settings,
    name: 'Settings',
  ),
];
