import 'package:flutter/material.dart';
import 'package:my_app/view/dashboard/provider/tabbar_provider.dart';
import 'package:my_app/view/home/home_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

// ignore: prefer_mixin
class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => TabBarProvider(),
      builder: (context, index) {
        return WillPopScope(
            onWillPop: () async {
              context.read<TabBarProvider>().switchTo(0);
              return Future.value(false);
            },
            child: Scaffold(
              body: IndexedStack(
                index: context.watch<TabBarProvider>().index,
                children: [
                  HomeView(),
                  Container(),
                ],
              ),
              bottomNavigationBar: Theme(
                data: ThemeData(
                  splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                  highlightColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                ),
                child: BottomNavigationBar(
                  currentIndex: context.watch<TabBarProvider>().index,
                  onTap: (index) {
                    context.read<TabBarProvider>().switchTo(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).accentColor,
                  unselectedItemColor: Colors.black,
                  items: const [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: "Category",
                      icon: Icon(Icons.category),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState _state) async {
    switch (_state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      default:
        break;
    }
  }

  void resumeCallBack() {
    debugPrint('App resume call back');
  }
}
