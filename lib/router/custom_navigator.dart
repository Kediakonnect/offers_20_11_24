import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/enums/event_form_type.dart';
import 'package:divyam_flutter/core/enums/gst_calculator_type.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/new_password_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_option_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_three_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_two_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/forgot_password_list_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/forgot_password_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/login_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/new_password_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/otp_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/register_screen.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/register_screen_three.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/register_screen_two.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/secondary_otp_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_directory_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_form_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_info_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/issue_resolution_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/my_business_screen.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/event_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/event_form_screen.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/event_preview_screen.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/event_screen.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/my_event_detail_screen_two.dart';
import 'package:divyam_flutter/features/dashboard/events/presentation/pages/my_events_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/famous/add_annoucement_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/famous/my_annoucement_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/famous/my_annoucement_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/highlights_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/news/add_new_news_paper_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/news/my_news_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/news/my_news_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/news/news_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/pages/news/news_paper_screen.dart';
import 'package:divyam_flutter/features/dashboard/highlights/presentation/utils/enums.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/create_offer_form.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/diamonds_to_coins_screen.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/my_offers_screen.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/offers_detail_screen.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/pages/offers_screen.dart';
import 'package:divyam_flutter/features/favourites/presentation/pages/favourites_screen.dart';
import 'package:divyam_flutter/features/feature/presentataion/pages/daily_prize_screen.dart';
import 'package:divyam_flutter/features/feature/presentataion/pages/new_feature_screen.dart';
import 'package:divyam_flutter/features/notification/presentation/pages/notification_screen.dart';
import 'package:divyam_flutter/features/onboarding/presentation/widgets/add_widget.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/invite_and_earn_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/invite_friends_to_left_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/join_and_earn_forever_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/join_and_earn_screen_two.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/my_bonus_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/my_team_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/sales_history_screen.dart';
import 'package:divyam_flutter/features/sidebar/mlm/presentation/pages/with_draw_bonus_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/ad_designer_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/change_password_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/edit_bank_details_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/edit_mlm_detail_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/edit_preferences_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/edit_profile_screen.dart';
import 'package:divyam_flutter/features/sidebar/profile/presentation/pages/my_profile_screen.dart';
import 'package:divyam_flutter/features/support/presentation/pages/contact_screen.dart';
import 'package:divyam_flutter/features/support/presentation/pages/faq_screen.dart';
import 'package:divyam_flutter/features/support/presentation/pages/terms_and_condition_screen.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_screen_entity.dart';
import 'package:divyam_flutter/features/tickets/presentation/pages/create_ticket_screen.dart';
import 'package:divyam_flutter/features/tickets/presentation/pages/my_tickets_screen.dart';
import 'package:divyam_flutter/features/tickets/presentation/pages/ticket_detail_screen.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppRouter.businessDetailScreen:
        return MaterialPageRoute(
          builder: (context) => BusinessDetailScreen(
            businessEntity: settings.arguments as BusinessEntity,
          ),
          settings: settings,
        );

      // case AppRouter.myBusinessDetailScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const BusinessDetailScreen(),
      //     settings: settings,
      //   );

      case AppRouter.addNewBusiness:
        return MaterialPageRoute(
          builder: (context) => BusinessFormScreen(
            businessFormType: settings.arguments as BusinessFormType,
          ),
          settings: settings,
        );

      case AppRouter.issuesResolutionScreen:
        return MaterialPageRoute(
          builder: (context) => const IssuesResolutionScreen(),
          settings: settings,
        );

      case AppRouter.businessInfoScreen:
        return MaterialPageRoute(
          builder: (context) => BusinessInfoScreen(
            businessEntity: settings.arguments as BusinessEntity,
          ),
          settings: settings,
        );

      // case AppRouter.businessPreviewScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const BusinessPreviewScreen(),
      //     settings: settings,
      //   );

      case AppRouter.myBusinessScreen:
        return MaterialPageRoute(
          builder: (context) => const MyBusinessScreen(),
          settings: settings,
        );

      case AppRouter.businessDirectoryScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const BusinessDirectoryScreen(),
          transitionDuration: const Duration(seconds: 0),
          settings: settings,
        );

      case AppRouter.offersScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OffersScreen(),
          transitionDuration: const Duration(seconds: 0),
          settings: settings,
        );

      case AppRouter.highLightScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HighlightsScreen(),
          transitionDuration: const Duration(seconds: 0),
          settings: settings,
        );

      case AppRouter.eventScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const EventScreen(),
          transitionDuration: const Duration(seconds: 0),
          settings: settings,
        );

      case AppRouter.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );

      case AppRouter.registerScreenOne:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: settings,
        );

//========================Offers Routes========================
      case AppRouter.myOffersScreen:
        return MaterialPageRoute(
          builder: (context) => const MyOffersScreen(),
          settings: settings,
        );

      case AppRouter.createOfferFormScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateOfferFormScreen(),
          settings: settings,
        );
      case AppRouter.addsScreen:
        return MaterialPageRoute(
          builder: (context) => AddsWidget(
            offerType: settings.arguments as String,
          ),
          settings: settings,
        );
      case AppRouter.offerDetailScreen:
        return MaterialPageRoute(
          builder: (context) => OffersDetailScreen(
            entity: settings.arguments as OfferModel,
          ),
          settings: settings,
        );

      case AppRouter.diamondCoinScreen:
        return MaterialPageRoute(
          builder: (context) => DiamondCoinScreen(
            gstCalculatorType: settings.arguments as GSTCalculatorType,
          ),
          settings: settings,
        );

//========================Auth====================================
      case AppRouter.registerScreenTwo:
        return MaterialPageRoute(
          builder: (context) => RegisterScreenTwo(
            registerScreenTwoEntity:
                settings.arguments as RegisterScreenTwoEntity,
          ),
          settings: settings,
        );

      case AppRouter.registerScreenThree:
        return MaterialPageRoute(
          builder: (context) => RegisterScreenThree(
            registerScreenThreeEntity:
                settings.arguments as RegisterScreenThreeEntity,
          ),
          settings: settings,
        );

      case AppRouter.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case AppRouter.forgotPasswordOptionScreen:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordListScreen(
            passwordResetOptionEntity:
                settings.arguments as PasswordResetOptionEntity,
          ),
          settings: settings,
        );

      case AppRouter.newPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => NewPasswordScreen(
            newPasswordScreenEntity:
                settings.arguments as NewPasswordScreenEntity,
          ),
          settings: settings,
        );

      case AppRouter.otpScreen:
        return MaterialPageRoute(
          builder: (context) => OTPScreen(
            otpScreenEntity: settings.arguments as OtpScreenEntity,
          ),
          settings: settings,
        );

      case AppRouter.secondaryOtpScreen:
        return MaterialPageRoute(
          builder: (context) => SecondaryOtpScreen(
            secondaryOtpEntityScreen:
                settings.arguments as SecondaryOtpEntityScreen,
          ),
          settings: settings,
        );

//==========================Events====================================
      case AppRouter.eventDetailScreen:
        return MaterialPageRoute(
          builder: (context) => const EventDetailScreen(),
          settings: settings,
        );

      case AppRouter.myEventScreen:
        return MaterialPageRoute(
          builder: (context) => const MyEventsScreen(),
          settings: settings,
        );

      case AppRouter.eventDetailScreenTwo:
        return MaterialPageRoute(
          builder: (context) => const MyEventDetailScreenTwo(),
          settings: settings,
        );

      case AppRouter.eventPreviewScreen:
        return MaterialPageRoute(
          builder: (context) => const EventPreviewScreen(),
          settings: settings,
        );

      case AppRouter.myEventForm:
        return MaterialPageRoute(
          builder: (context) => EventFormScreen(
            formType: settings.arguments as EventFormType,
          ),
          settings: settings,
        );

      //=========================Hightlight====================================
      case AppRouter.myAnnoucementScreen:
        return MaterialPageRoute(
          builder: (context) => const MyAnnoucementScreen(),
          settings: settings,
        );
      case AppRouter.myAnnoucementDetailScreen:
        return MaterialPageRoute(
          builder: (context) => const MyAnnoucementDetailScreen(),
          settings: settings,
        );
      case AppRouter.newsPaperScreen:
        return MaterialPageRoute(
          builder: (context) => const NewsPaperScreen(),
          settings: settings,
        );
      case AppRouter.myNewsScreen:
        return MaterialPageRoute(
          builder: (context) => const MyNewsScreen(),
          settings: settings,
        );
      case AppRouter.newsDetailScreen:
        return MaterialPageRoute(
          builder: (context) => const NewsDetailScreen(),
          settings: settings,
        );
      case AppRouter.addAnnoucementScreen:
        return MaterialPageRoute(
          builder: (context) => AddAnnoucementScreen(
            addAnnoucementFormType:
                settings.arguments as AddAnnoucementFormType,
          ),
          settings: settings,
        );

      //=================================MLM===========================================
      case AppRouter.joinAndEarnScreen:
        return MaterialPageRoute(
          builder: (context) => const JoinAndEarnForeverScreen(),
          settings: settings,
        );
      case AppRouter.joinAndEarnScreenTwo:
        return MaterialPageRoute(
          builder: (context) => const JoinAndEarnScreenTwo(),
          settings: settings,
        );
      case AppRouter.inviteAndEarnScreen:
        return MaterialPageRoute(
          builder: (context) => const InviteAndEarnScreen(),
          settings: settings,
        );
      case AppRouter.inviteFriendsToLeft:
        return MaterialPageRoute(
          builder: (context) => const InviteFriendsToLeftScreen(),
          settings: settings,
        );
      case AppRouter.myTeamScreen:
        return MaterialPageRoute(
          builder: (context) => const MyTeamScreen(),
          settings: settings,
        );
      case AppRouter.myBonusScreen:
        return MaterialPageRoute(
          builder: (context) => const MyBonusScreen(),
          settings: settings,
        );
      case AppRouter.withdrawBonusScreen:
        return MaterialPageRoute(
          builder: (context) => const WithDrawBonusScreen(),
          settings: settings,
        );
      case AppRouter.salesHistoryScreen:
        return MaterialPageRoute(
          builder: (context) => const SalesHistoryScreen(),
          settings: settings,
        );

      //================================Profile===================================

      case AppRouter.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const MyProfileScreen(),
          settings: settings,
        );

      case AppRouter.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
          settings: settings,
        );

      case AppRouter.basicDetails:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
          settings: settings,
        );

      case AppRouter.preferences:
        return MaterialPageRoute(
          builder: (context) => const EditPreferencesScreen(),
          settings: settings,
        );

      case AppRouter.mlmDetails:
        return MaterialPageRoute(
          builder: (context) => const EditMlmDetailScreen(),
          settings: settings,
        );

      case AppRouter.bankDetails:
        return MaterialPageRoute(
          builder: (context) => const EditBankDetailsScreen(),
          settings: settings,
        );

      case AppRouter.adDesigner:
        return MaterialPageRoute(
          builder: (context) => const AdDesignerScreen(),
          settings: settings,
        );

      //=================================Help and Support===========================

      case AppRouter.ticketsScreen:
        return MaterialPageRoute(
          builder: (context) => const TicketDetailScreen(),
          settings: settings,
        );

      case AppRouter.createTicketScreen:
        return MaterialPageRoute(
          builder: (context) => CreateTicketScreen(
            entity: settings.arguments as CreateTicketScreenEntity,
          ),
          settings: settings,
        );

      case AppRouter.termsAndConditionsScreen:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditionScreen(),
          settings: settings,
        );
      case AppRouter.faqsScreen:
        return MaterialPageRoute(
          builder: (context) => const FaqScreen(),
          settings: settings,
        );
      case AppRouter.myTicketsScreen:
        return MaterialPageRoute(
          builder: (context) => const MyTicketsScreen(),
          settings: settings,
        );
      case AppRouter.contactScreen:
        return MaterialPageRoute(
          builder: (context) => const ContactScreen(),
          settings: settings,
        );
      case AppRouter.dailyPrizesScreen:
        return MaterialPageRoute(
          builder: (context) => const DailyPrizeScreen(),
          settings: settings,
        );
      case AppRouter.newFeatureScreen:
        return MaterialPageRoute(
            builder: (context) => const NewFeatureScreen(), settings: settings);
      case AppRouter.addNewsPaperScreen:
        return MaterialPageRoute(
            builder: (context) => const AddNewsPaperScreen(),
            settings: settings);
      case AppRouter.myNewsPaperDetailScreen:
        return MaterialPageRoute(
            builder: (context) => const MyNewsDetailScreen(),
            settings: settings);
      // case AppRouter.notificationScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const NotificationSc(),
      //     settings: settings,
      //   );
      case AppRouter.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
          settings: settings,
        );

      case AppRouter.favoriteScreen:
        return MaterialPageRoute(
          builder: (context) => const FavouritesScreen(),
          settings: settings,
        );

      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushNamedAndRemoveUntil(
      context,
      strPageName,
      (route) => false,
      arguments: arguments,
    );
  }
}
