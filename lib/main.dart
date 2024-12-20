import 'package:bookly/constants.dart';
import 'package:bookly/core/app_router.dart';
import 'package:bookly/core/functions/setup_service_locator.dart';
import 'package:bookly/core/utils/simple_bloc_oberserver.dart';
import 'package:bookly/features/home/data_layer/repos/home_repo_impl.dart';
import 'package:bookly/features/home/domain_layer/entities/book_entity.dart';
import 'package:bookly/features/home/domain_layer/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/features/home/domain_layer/use_cases/fetch_newest_books_use_case.dart';
import 'package:bookly/features/home/presenation/manager/cubit/featured_books_cubit.dart';
import 'package:bookly/features/home/presenation/manager/cubit/newest_books_cubit.dart';
import 'package:bookly/features/home/presenation/manager/cubit/shared_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setupServiceLocator();
  await Hive.openBox<BookEntity>(kHiveFeaturebBox);
  await Hive.openBox<BookEntity>(kHiveNewsetBox);
  Bloc.observer = SimpleBlocOberserver();
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SharedDataCubit(),
        ),
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            featuredBooksUseCase: FetchFeaturedBooksUseCase(
              homeRepo: getIt.get<HomeRepoImpl>(),
            ),
          )..fetchFeaturedBook(
              topic: BlocProvider.of<SharedDataCubit>(context).topic),
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            fetchNewestdBooksUseCase: FetchNewestdBooksUseCase(
              homeRepo: getIt.get<HomeRepoImpl>(),
            ),
          )..fetchNewestBooks(
              topic: BlocProvider.of<SharedDataCubit>(context).topic),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: kPrimaryColor),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
