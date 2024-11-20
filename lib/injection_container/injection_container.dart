import 'package:divyam_flutter/core/network/network_info.dart';
import 'package:divyam_flutter/features/authentication/data/data_sources/auth_remote_data_sources.dart';
import 'package:divyam_flutter/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:divyam_flutter/features/authentication/domain/repository/auth_repository.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/forgot_password_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/generate_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/get_my_account_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/register_user_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/reset_password_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/secondary_otp_use_case.dart';
import 'package:divyam_flutter/features/authentication/domain/usecases/signin_use_case.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/datasources/local/business_directory_local_data_sources.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/datasources/remote/business_directory_remote_data_sources.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/repository/business_directory_repository_impl.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/repository/business_directory_repository.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/add_business_to_favorite_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/create_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/delete_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_all_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_categories_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_my_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_product_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_states_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/rate_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/share_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/update_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/verify_business_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/data_sources/offer_remote_data_sources.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/repository/offer_remote_repository_impl.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/repository/offer_remote_repository.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/add_offers_to_favorite_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/create_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/delete_offer_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_all_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_my_offers_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_offer_by_id_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/get_user_wallet_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/domain/usecases/view_offer_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/features/favourites/data/data_sources/favourite_data_sources.dart';
import 'package:divyam_flutter/features/favourites/data/repository/favourite_repository.dart';
import 'package:divyam_flutter/features/favourites/domain/use_cases/get_all_favourite_business_use_case.dart';
import 'package:divyam_flutter/features/favourites/domain/use_cases/get_all_favourite_offers.dart';
import 'package:divyam_flutter/features/favourites/presentation/cubit/favourite_cubit.dart';
import 'package:divyam_flutter/features/tickets/data/data_sources/ticket_data_sources.dart';
import 'package:divyam_flutter/features/tickets/data/repository/ticket_repository_impl.dart';
import 'package:divyam_flutter/features/tickets/domain/repository/ticket_repository.dart';
import 'package:divyam_flutter/features/tickets/domain/usecases/create_ticket_use_case.dart';
import 'package:divyam_flutter/features/tickets/presentation/cubit/ticket_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  general();
  auth();
  businessDirectory();
  offers();
  favourites();
  ticket();
}

void favourites() {
  sl.registerLazySingleton(() => FetchFavouriteBusinessUseCase(
        favouritesRepository: sl(),
      ));
  sl.registerLazySingleton(() => FetchFavouriteOffersUseCase(
        favouritesRepository: sl(),
      ));
  sl.registerLazySingleton(() => FavouritesRepository(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton(() => FavouriteCubit(
        fetchFavouriteBusinessUseCase: sl(),
        fetchFavouriteOffersUseCase: sl(),
      ));

  sl.registerLazySingleton(() => FavouritesRemoteDataSources());
}

void general() {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void businessDirectory() {
  // Register data sources before the repository that depends on them.
  sl.registerLazySingleton(() => BusinessDirectoryLocalDataSources());
  sl.registerLazySingleton(() => BusinessDirectoryRemoteDataSources());

  // Register repository that uses data sources.
  sl.registerFactory<BusinessDirectoryRepository>(
      () => BusinessDirectoryRepositoryImpl(
            businessDirectoryLocalDataSources: sl(),
            businessDirectoryRemoteDataSources: sl(),
            networkInfo: sl(),
          ));

  // Register Use Cases.
  sl.registerSingleton<GetAllBusinessUseCase>(
      GetAllBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<GetStatesUseCase>(
      () => GetStatesUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<UpdateBusinessUseCase>(
      () => UpdateBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<GetMyBusinessUseCase>(
      () => GetMyBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<CreateBusinessUseCase>(
      () => CreateBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<VerifyBusinessUseCase>(
      () => VerifyBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<RateBusinessUseCase>(
      () => RateBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<ShareBusinessUseCase>(
      () => ShareBusinessUseCase(businessDirectoryRepository: sl()));
  sl.registerLazySingleton<AddBusinessToFavoriteUseCase>(
      () => AddBusinessToFavoriteUseCase(businessDirectoryRepository: sl()));

  sl.registerLazySingleton<DeleteMyBusinessUseCase>(
      () => DeleteMyBusinessUseCase(businessDirectoryRepository: sl()));

  // Register Cubits.
  sl.registerFactory<BusinessDirectoryCubit>(
    () => BusinessDirectoryCubit(
      addBusinessToFavoriteUseCase: sl(),
      updateBusinessUseCase: sl(),
      createBusinessUseCase: sl(),
      getAllBusinessUseCase: sl(),
      getMyBusinessUseCase: sl(),
      verifyBusinessUseCase: sl(),
      rateBusinessUseCase: sl(),
      shareBusinessUseCase: sl(),
      deleteMyBusinessUseCase: sl(),
    ),
  );
  sl.registerSingleton<BusinessCategoryCubit>(
    BusinessCategoryCubit(
      getCategoriesUseCase: sl(),
      getProductUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => StateSelectorCubit(getStatesUseCase: sl()));
}

void auth() {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl(), repo: sl()));
  sl.registerLazySingleton<AuthRemoteDataSources>(
      () => AuthRemoteDataSources());
  sl.registerLazySingleton(() => GenerateOtpUse(authRepository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SecondaryOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetMyAccountUseCase(authRepository: sl()));

  sl.registerLazySingleton(
      () => ForgotPasswordOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
        secondaryOtpUseCase: sl(),
        generateOtpUse: sl(),
        signInUseCase: sl(),
        forgotPasswordUseCase: sl(),
        registerUserUseCase: sl(),
        forgotPasswordOtpUseCase: sl(),
        resetPasswordUseCase: sl(),
        getMyAccountUseCase: sl()),
  );
}

void offers() {
  sl.registerFactory<OfferRemoteRepository>(() => OfferRemoteRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerFactory<OffersCubit>(() => OffersCubit(
        allOffersUseCase: sl(),
        getMyOffersUseCase: sl(),
        getMyBusinessUseCase: sl(),
        createOfferUseCase: sl(),
        viewOfferUseCase: sl(),
        addOffersToFavouriteUseCase: sl(),
        getOfferByIdUseCase: sl(),
        getUserWalletBalanceUseCase: sl(),
        deleteOfferUseCase: sl(),
      ));

  sl.registerLazySingleton<GetAllOffersUseCase>(
      () => GetAllOffersUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<GetMyOffersUseCase>(
      () => GetMyOffersUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<CreateOfferUseCase>(
      () => CreateOfferUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<ViewOfferUseCase>(
      () => ViewOfferUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<AddOffersToFavouriteUseCase>(
      () => AddOffersToFavouriteUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<GetOfferByIdUseCase>(
      () => GetOfferByIdUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<GetUserWalletBalanceUseCase>(
      () => GetUserWalletBalanceUseCase(offerRemoteRepository: sl()));
  sl.registerLazySingleton<DeleteOfferUseCase>(
      () => DeleteOfferUseCase(repository: sl()));
  sl.registerLazySingleton<OfferRemoteDataSource>(
      () => OfferRemoteDataSource());
}

void ticket() {
  sl.registerFactory<TicketRepository>(() => TicketRepositoryImpl(
        ticketDataSources: sl(),
        networkInfo: sl(),
      ));

  sl.registerFactory<TicketCubit>(() => TicketCubit(createTicketUseCase: sl()));

  sl.registerLazySingleton<CreateTicketUseCase>(
      () => CreateTicketUseCase(ticketRepository: sl()));
  sl.registerLazySingleton<TicketDataSources>(() => TicketDataSources());
}
