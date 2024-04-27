import 'package:flutter/material.dart';
import 'package:kalpas_assign/Screens/favorites.dart';
import 'package:kalpas_assign/Screens/news.dart';
import 'package:kalpas_assign/Widgets/app_bar.dart';
import 'package:provider/provider.dart';

import 'Service/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  int headlinePage = 1;
  bool isMoreLoading = false;
  final scrollController1 = ScrollController();
  final scrollController2 = ScrollController();
  final searchController = TextEditingController();
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    scrollController1.addListener(_scrollListener1);
    scrollController2.addListener(_scrollListener2);
    _loadData(page);
    _loadHeadline(headlinePage);
  }

  Future<void> _loadData(int page) async {
    await context.read<ApiService>().getArticles(page);
    setState(() {
      _dataLoaded = true;
    });
  }

  Future<void> _loadHeadline(int page) async {
    await context.read<ApiService>().getFavorites(page);
    setState(() {
      _dataLoaded = true;
    });
  }

  void _scrollListener1() async {
    if (isMoreLoading || !_dataLoaded) return;
    if (scrollController1.position.pixels ==
        scrollController1.position.maxScrollExtent) {
      setState(() {
        isMoreLoading = true;
      });
      page = page + 1;
      await _loadData(page);
      setState(() {
        isMoreLoading = false;
      });
    }
  }

  void _scrollListener2() async {
    if (isMoreLoading || !_dataLoaded) return;
    if (scrollController2.position.pixels ==
        scrollController2.position.maxScrollExtent) {
      setState(() {
        isMoreLoading = true;
      });
      headlinePage = headlinePage + 1;
      await _loadHeadline(headlinePage);
      setState(() {
        isMoreLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // length
        child: Scaffold(
          appBar: appBar(context, searchController),
          body: TabBarView(children: [
            !_dataLoaded
                ? Center(child: CircularProgressIndicator())
                : trending(
                    context: context,
                    scrollController: scrollController1,
                    articles: context.watch<ApiService>().filterList.length == 0
                        ? context.watch<ApiService>().articles
                        : context.watch<ApiService>().filterList,
                    isMoreLoading: isMoreLoading),
            !_dataLoaded
                ? Center(child: CircularProgressIndicator())
                : favorites(
                    context: context,
                    scrollController: scrollController1,
                    articles: context.watch<ApiService>().favorites,
                    isMoreLoading: isMoreLoading),
          ]),
        ));
  }
}
