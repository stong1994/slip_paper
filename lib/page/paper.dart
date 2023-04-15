import 'package:flutter/material.dart';
import 'package:slip_paper/db/card.dart';
import 'package:slip_paper/model/shape.dart';
import 'package:slip_paper/model/card.dart';

import 'card.dart';

class Paper extends StatefulWidget {
  late PaperType type;

  Paper({required this.type});

  @override
  State<StatefulWidget> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardModel>>(
        future: CardData().getCards(widget.type),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}}"),
            );
          }
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            print('height ' + height.toString());
            print('width ' + width.toString());
            return Scaffold(
              body: Stack(
                children: List.generate(snapshot.data!.length,
                    (index) => RandomShapeCard(snapshot.data![index])),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    CardData().addCard(CardModel().random(
                        widget.type, height / 2 - 50, width / 2 - 75)); // todo
                  });
                },
                child: Icon(Icons.add),
              ),
            );
          });
        });
  }
}
