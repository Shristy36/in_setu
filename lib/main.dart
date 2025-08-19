import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ConnectivityService.dart';
import 'package:in_setu/screens/cash_details_view/cash_repo/cash_book_repository.dart';
import 'package:in_setu/screens/chat/bloc/chats_bloc.dart';
import 'package:in_setu/screens/chat/chats_repo/chats_repo.dart';
import 'package:in_setu/screens/home_page/home_repo/home_repository.dart';
import 'package:in_setu/screens/login_view/bloc/signin_bloc.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/repository/signin_repo.dart';
import 'package:in_setu/screens/login_view/sign_in_screen.dart';
import 'package:in_setu/screens/material_view/material_repo/material_repository.dart';
import 'package:in_setu/screens/plans_view/bloc/plans_bloc.dart';
import 'package:in_setu/screens/plans_view/plan_repo/plans_repo.dart';
import 'package:in_setu/screens/project_list/bloc/sites_bloc.dart';
import 'package:in_setu/screens/project_list/project_list_screen.dart';
import 'package:in_setu/screens/project_list/repository/all_sites_repository.dart';
import 'package:in_setu/screens/user/bloc/profile_bloc.dart';
import 'package:in_setu/screens/user/profile_repo/profile_repository.dart';
import 'package:in_setu/screens/walkthrough_screen/onboarding_screen.dart';
import 'package:in_setu/screens/walkthrough_screen/walkthrough_screen.dart';
import 'package:in_setu/supports/DialogManager.dart';

import 'constants/app_colors.dart';
import 'screens/mainpower_screen/bloc/man_power_bloc.dart';
import 'screens/mainpower_screen/mainpower_repo/main_power_repository.dart';
import 'screens/material_view/bloc/material_stock_bloc.dart';
import 'supports/share_preference_manager.dart';
import 'screens/cash_details_view/bloc/cashbook_bloc.dart';
import 'screens/home_page/bloc/home_bloc.dart';

void main() async{
  /*SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary50, // Different from AppBar
      statusBarIconBrightness: Brightness.light, // Light icons (for dark bg)
    ),
  );*/
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SignInRepository>(create: (context) => SignInRepository()),
          RepositoryProvider<AllSitesRepository>(create: (context) => AllSitesRepository()),
          RepositoryProvider<HomeRepository>(create: (context) => HomeRepository()),
          RepositoryProvider<ProfileRepository>(create: (context) => ProfileRepository()),
          RepositoryProvider<CashbookRepository>(create: (context) => CashbookRepository()),
          RepositoryProvider<ChatsRepository>(create: (context) => ChatsRepository()),
          RepositoryProvider<ManPowerRepository>(create: (context) => ManPowerRepository()),
          RepositoryProvider<MaterialRepository>(create: (context) => MaterialRepository()),
          RepositoryProvider<PlansRepository>(create: (context) => PlansRepository()),
        ],

        child: MultiBlocProvider(
            providers: [
              BlocProvider<SigninBloc>(create: (context) => SigninBloc(signInRepository: SignInRepository())),
              BlocProvider<SitesBloc>(create: (context) => SitesBloc(sitesRepository: AllSitesRepository())),
              BlocProvider<HomeBloc>(create: (context) => HomeBloc(homeRepository: HomeRepository())),
              BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(profileRepository: ProfileRepository())),
              BlocProvider<CashbookBloc>(create: (context) => CashbookBloc(cashbookRepository: CashbookRepository())),
              BlocProvider<ChatsBloc>(create: (context) => ChatsBloc(chatsRepository: ChatsRepository())),
              BlocProvider<ManPowerBloc>(create: (context) => ManPowerBloc(manPowerRepository: ManPowerRepository())),
              BlocProvider<MaterialStockBloc>(create: (context) => MaterialStockBloc(materialRepository: MaterialRepository())),
              BlocProvider<PlansBloc>(create: (context) => PlansBloc(plansRepository: PlansRepository())),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: const SplashScreen(),
            )));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasSeenOnboarding = false;
  final connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    connectivityService.connectivityStream.stream.listen((result) {
      if (result == ConnectivityResult.none) {
        DialogManager.showInternetDialog(context, noInternetConnection);
      } else {
        print("Connected via $result");
        Future.delayed(const Duration(seconds: 3), () {
          _checkOnboardingStatus();
        });
      }
    });
  }
  Future<void> _checkOnboardingStatus() async {
    bool hasSeenOnboarding = await SharedPreferenceManager.getFirstCallOnboarding();
    setState(() {
      _hasSeenOnboarding = hasSeenOnboarding;
    });

    if (!hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    } else {
      final LoginAuthModel? savedAuth = await SharedPreferenceManager.getOAuth();

      if (savedAuth != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectListScreen(user: savedAuth.user!),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }

    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo or animation
            Image.asset("assets/images/splash_logo.jpg", width: 100, height: 100,),
            const SizedBox(height: 20),
            const Text('Welcome to InSetu App', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/*// Existing MyHomePage remains unchanged
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primary, // Status bar color
      statusBarIconBrightness: Brightness.light, // Icons color
      statusBarBrightness: Brightness.dark, // For iOS
      systemNavigationBarColor: AppColors.primary, // Optional: bottom nav color
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}*/
