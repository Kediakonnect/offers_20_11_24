import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/gst_calculator_type.dart';
import 'package:divyam_flutter/core/helpers/user_helpers.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';

class SideBarUtils {
  static List<SideBarEntity> sideBarOptions = [
    SideBarEntity(
      title: 'Home',
      assetName: AppIcons.mlm,
      canAddSpacer: true,
      routeName: AppRouter.businessDirectoryScreen,
    ),
    SideBarEntity(
      title: 'Notifications',
      assetName: AppIcons.notification,
      canAddSpacer: false,
      routeName: AppRouter.notificationScreen,
    ),
    SideBarEntity(
      canAddSpacer: false,
      title: 'MLM',
      assetName: AppIcons.mlm,
      routeName: '',
      expandedItems: const [
        SideBarExpandedItemEntity(
            title: 'Join & Earn', routeName: AppRouter.joinAndEarnScreen),
        SideBarExpandedItemEntity(
            title: 'Invite & Earn', routeName: AppRouter.inviteAndEarnScreen),
        SideBarExpandedItemEntity(
            title: 'My Team', routeName: AppRouter.myTeamScreen),
        SideBarExpandedItemEntity(
            title: 'My Bonus', routeName: AppRouter.myBonusScreen),
        SideBarExpandedItemEntity(
            title: 'Withdraw Bonus', routeName: AppRouter.withdrawBonusScreen),
        SideBarExpandedItemEntity(
            title: 'Sales History', routeName: AppRouter.salesHistoryScreen),
      ],
    ),
    SideBarEntity(
      canAddSpacer: true,
      title: 'Daily Prize',
      assetName: AppIcons.gift,
      routeName: AppRouter.dailyPrizesScreen,
    ),
    SideBarEntity(
      title: 'My Recharge Coins',
      canAddSpacer: false,
      assetName: AppIcons.coins,
      routeName: AppRouter.diamondCoinScreen,
      arguments: GSTCalculatorType.purchaseCoins,
    ),
    SideBarEntity(
      title: 'My Posts',
      canAddSpacer: false,
      assetName: AppIcons.posts,
      routeName: '',
      expandedItems: const [
        SideBarExpandedItemEntity(
          title: 'Purchase Coins',
          routeName: AppRouter.diamondCoinScreen,
          arguments: GSTCalculatorType.purchaseCoins,
        ),
        SideBarExpandedItemEntity(
            title: 'My Businesses', routeName: AppRouter.myBusinessScreen),
        SideBarExpandedItemEntity(
            title: 'My Offers', routeName: AppRouter.myOffersScreen),
        SideBarExpandedItemEntity(
          title: 'My Events',
          routeName: AppRouter.myEventScreen,
        ),
        SideBarExpandedItemEntity(
          title: 'My Publications',
          routeName: AppRouter.myNewsScreen,
        ),
        SideBarExpandedItemEntity(
          title: 'For Famous',
          routeName: AppRouter.myAnnoucementDetailScreen,
        ),
      ],
    ),
    SideBarEntity(
      title: 'Profile',
      assetName: AppIcons.profile,
      canAddSpacer: true,
      routeName: AppRouter.profileScreen,
    ),
    SideBarEntity(
      title: 'Favorites',
      canAddSpacer: false,
      assetName: AppIcons.favourite,
      routeName: AppRouter.favoriteScreen,
    ),
    SideBarEntity(
      title: 'Help & Support',
      assetName: AppIcons.help,
      canAddSpacer: false,
      routeName: '',
      expandedItems: const [
        SideBarExpandedItemEntity(
          title: 'Tickets',
          routeName: AppRouter.myTicketsScreen,
        ),
        SideBarExpandedItemEntity(
            title: 'Contact', routeName: AppRouter.contactScreen),
        SideBarExpandedItemEntity(
            title: 'FAQs', routeName: AppRouter.faqsScreen),
        SideBarExpandedItemEntity(
          title: 'Terms & Conditions',
          routeName: AppRouter.termsAndConditionsScreen,
        ),
      ],
    ),
    SideBarEntity(
      title: 'New Features',
      canAddSpacer: true,
      assetName: AppIcons.newFeature,
      routeName: AppRouter.newFeatureScreen,
    ),
    SideBarEntity(
      canAddSpacer: true,
      title: 'Logout',
      assetName: AppIcons.logout,
      routeName: '',
      onItemTap: () async {
        await UserHelpers.deleteAuthToken();
        kNavigatorKey.currentState?.pushReplacementNamed(AppRouter.loginScreen);
      },
    ),
  ];
}

class SideBarEntity {
  final String title, assetName, routeName;
  final bool? canAddSpacer;
  final dynamic arguments;

  final List<SideBarExpandedItemEntity>? expandedItems;
  final void Function()? onItemTap;

  const SideBarEntity({
    required this.title,
    this.arguments,
    this.canAddSpacer = true,
    required this.assetName,
    required this.routeName,
    this.onItemTap,
    this.expandedItems = const [],
  });
}

class SideBarExpandedItemEntity {
  final String title, routeName;
  final dynamic arguments;

  const SideBarExpandedItemEntity(
      {required this.title, required this.routeName, this.arguments});
}
