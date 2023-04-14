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
        primarySwatch: Colors.blue,
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

// class AddIdeaScreen extends StatefulWidget {
//   @override
//   _AddIdeaScreenState createState() => _AddIdeaScreenState();
// }

// class _AddIdeaScreenState extends State<AddIdeaScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _title;
//   String? _description;
//   String? _category;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add New Idea')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Title'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _title = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _description = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Category'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a category';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _category = value;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 child: Text('Save'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState?.save();
//                     Idea newIdea = Idea(
//                       title: _title!,
//                       description: _description!,
//                       category: _category!,
//                       dateCreated: DateTime.now(),
//                     );
//                     // Add the new idea to the appropriate list
//                     // ...
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
