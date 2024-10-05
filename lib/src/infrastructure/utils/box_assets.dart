import '../../../gen/assets.gen.dart';
import '../../domain/models/box_asset.dart';

final List<BoxAsset> boxAssets = [
  BoxAsset(
    id: 0,
    asset: Assets.png.onb1.path,
    text1: 'Welcome to\nPocket Collection!',
    text2:
    'Digitize and manage your favorite collections all in one convenient place. Start creating your collection now!',
  ),
  BoxAsset(
    id: 1,
    asset: Assets.png.onb2.path,
    text1: "Create Your\nFirst Collection",
    text2:
    "Choose a category and add your collectible items. Organize them by rarity, value, or date added.",
  ),
  BoxAsset(
    id: 2,
    asset: Assets.png.onb3.path,
    text1: "Track Your\nAchievements",
    text2:
    'Earn unique achievements for adding collections and items. Reach new milestones and unlock hidden rewards!',
  ),
];
