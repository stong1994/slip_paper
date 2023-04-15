import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slip_paper/model/shape.dart';
import 'package:slip_paper/page/paper.dart';

import 'page/card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // debugPrint(RendererBinding.instance.renderView.toStringDeep());
    return MaterialApp(
      title: 'Slip Paper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0.0,
          // title: Text('My Piecemeal Ideas'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: List.generate(PaperType.values.length,
                (index) => Tab(text: PaperType.values[index].name)),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(PaperType.values.length,
            (index) => Paper(type: PaperType.values[index])),
      ),
    );
  }
}
