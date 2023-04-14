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

  // Future<List<CardModel>> getCards()  => CardData().getCards(widget.type);

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
          
          return Scaffold(
            body: Stack(
              children: List.generate(snapshot.data!.length,
              (index) => RandomShapeCard(snapshot.data![index])),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // setState(() {
                //   cards.add(RandomShapeCard());
                // });
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
