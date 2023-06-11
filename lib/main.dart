import 'package:blug_club/article.dart';
import 'package:blug_club/gen/fonts.gen.dart';
import 'package:blug_club/home.dart';
import 'package:blug_club/profile.dart';
import 'package:blug_club/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryTextColor = Color(0xff0d253c);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const secondaryTextColor = Color(0xff2d4379);
    const primaryColor = Color(0xff376aed);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              background: Color(0xfffbfcff),
              surface: Colors.white,
              onSurface: primaryTextColor,
              onBackground: primaryTextColor),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: primaryTextColor,
              elevation: 0,
              titleSpacing: 32),
          snackBarTheme: const SnackBarThemeData(backgroundColor: primaryColor),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontFamily: FontFamily.avenir,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)))),
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: secondaryTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              titleLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor),
              bodySmall: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7b8bb2),
                  fontSize: 10),
              bodyLarge: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: primaryTextColor,
                  fontSize: 14),
              bodyMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: secondaryTextColor,
                  fontSize: 12),
              headlineMedium: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor))),
      /*    home: Stack(children: [
        const Positioned.fill(child: HomeScreen()),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _BottomNavigation(),
        )
      ]), */
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;
const int articleIndex = 1;
const int searcheIndex = 2;
const int menuIndex = 3;
const double bottomNavigaitionHeight = 65;
List<int> _history = [];

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articlesKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex:_homeKey,
    articleIndex:_articlesKey,
    searcheIndex:_searchKey,
    menuIndex:_profileKey
  };
  Future<bool> _onWillPop() async{
    NavigatorState currentSelectedTabNavigatorState = map[selectedScreenIndex]!.currentState!;
    if(currentSelectedTabNavigatorState.canPop()){
      currentSelectedTabNavigatorState.pop();
      return false;
    }else if(_history.isNotEmpty){
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(children: [
          Positioned.fill(
            bottom: bottomNavigaitionHeight,
            child: IndexedStack(
              index: selectedScreenIndex,
              children: [
                
                _navigator(_homeKey,homeIndex,const HomeScreen()),
                _navigator(_articlesKey,articleIndex,const ArticleScreen()),
                _navigator(_searchKey,searcheIndex,const _SearchScreen()),
                _navigator(_profileKey,menuIndex,const ProfileScreen()),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _BottomNavigation(
              onTap: (index) {
                setState(() {
                  _history.remove(selectedScreenIndex);
                  _history.add(selectedScreenIndex);
                  selectedScreenIndex = index;
          
                });
              },
              selectedIndex: selectedScreenIndex,
            ),
          )
        ]),
      ),
    );
  }

  Widget _navigator(GlobalKey key , int index, Widget child) {
    return key.currentState==null && selectedScreenIndex!=index ? Container(): Navigator(
                key: key,
                onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => Offstage(offstage: selectedScreenIndex!=index,child:  child)),
              );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Screen',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex;
  const _BottomNavigation(
      {super.key, required this.onTap, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: bottomNavigaitionHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: const Color(0x009b8487).withOpacity(0.3))
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _BottomNavigaitionItem(
                      title: 'Home',
                      iconFileName: 'Home.png',
                      activeFileName: 'HomeActive.png',
                      onTap: () {
                        onTap(homeIndex);
                      },
                      isActive: selectedIndex == homeIndex,
                    ),
                    _BottomNavigaitionItem(
                      title: 'Articles',
                      iconFileName: 'Articles.png',
                      activeFileName: 'ArticlesActive.png',
                      onTap: () {
                        onTap(articleIndex);
                      },
                      isActive: selectedIndex == articleIndex,
                    ),
                    const Expanded(child: SizedBox()),
                    _BottomNavigaitionItem(
                      title: 'Search',
                      iconFileName: 'Search.png',
                      activeFileName: 'SearchActive.png',
                      onTap: () {
                        onTap(searcheIndex);
                      },
                      isActive: selectedIndex == searcheIndex,
                    ),
                    _BottomNavigaitionItem(
                      title: 'Menu',
                      iconFileName: 'Menu.png',
                      activeFileName: 'MenuActive.png',
                      onTap: () {
                        onTap(menuIndex);
                      },
                      isActive: selectedIndex == menuIndex,
                    )
                  ]),
            ),
          ),
          Center(
            child: Container(
              width: 65,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.5),
                    color: const Color(0xff376aed),
                    border: Border.all(color: Colors.white, width: 4)),
                child: Image.asset('assets/img/icons/plus.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomNavigaitionItem extends StatelessWidget {
  final String iconFileName;
  final String activeFileName;
  final String title;
  final bool isActive;
  final Function() onTap;

  const _BottomNavigaitionItem(
      {super.key,
      required this.iconFileName,
      required this.activeFileName,
      required this.title,
      required this.onTap,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/img/icons/${isActive ? activeFileName : iconFileName}'),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).textTheme.bodySmall!.color),
            )
          ],
        ),
      ),
    );
  }
}
