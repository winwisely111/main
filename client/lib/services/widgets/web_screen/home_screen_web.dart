import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/news/news.dart';

import '../../bloc/app_nav.dart';
import './drawer.dart';

class WebHomeScreen extends StatelessWidget {
  final PageController _controller = PageController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final AppNavigation _nav = Provider.of<AppNavigation>(context);

    final List<Widget> _tabs = <Widget>[
      const NewsFeed(
        key: ValueKey<String>('/news'),
      ),
      const ConversationsFeed(
        key: ValueKey<String>('/conversations'),
      ),
      const Text(
        'Enrollments',
        style: optionStyle,
      ),
      const Text(
        'Profile',
        style: optionStyle,
      ),
    ];

    final Widget drawer = ChangeNotifierProvider<AppNavigation>.value(
      value: Provider.of<AppNavigation>(context),
      child: const LeftDrawer(),
    );
    final Widget body = PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: _tabs,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/icon/icon-old.png'),
          ),
        ),
        title: const Text('Winwisely99'),
      ),
      body: ResponsiveListScaffold.builder(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text("News"),
            ),
          ),
        ],
        detailBuilder: (
          BuildContext context,
          int index,
          bool flag,
        ) {
          return DetailsScreen(
            appBar: AppBar(
              title: Text(index.toString()),
            ),
            body: _tabs[index],
          );
        },
        //drawer: AppDrawer(),
        tabletSideMenu: (kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
            ? Flexible(
                flex: 0,
                child: drawer,
                fit: FlexFit.tight,
              )
            : null,
        tabletFlexListView: 4,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return const Text(
            'Items',
            style: optionStyle,
          );
        },
      ),
    );
  }
}