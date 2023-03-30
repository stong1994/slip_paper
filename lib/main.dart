import 'package:flutter/material.dart';

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
            tabs: [
              Tab(text: 'Be digested'),
              Tab(text: 'Program'),
              Tab(text: 'Remain to be evaluated'),
              Tab(text: 'Tricky'),
              Tab(text: 'Garbage'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Implement the list view for the 'Be digested' tab here
          // ...
          // Implement the list view for the 'Garbage' tab here
          // ...
        ],
      ),
    );
  }
}

class Idea {
  String title;
  String description;
  String category;
  DateTime dateCreated;
  bool isCompleted;

  Idea({
    required this.title,
    required this.description,
    required this.category,
    required this.dateCreated,
    this.isCompleted = false,
  });
}

List<Idea> _beDigestedIdeas = [];

// Widget _buildBeDigestedListView() {
//   return ListView.builder(
//     itemCount: _beDigestedIdeas.length,
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text(_beDigestedIdeas[index].title),
//         subtitle: Text(_beDigestedIdeas[index].description),
//         trailing: IconButton(
//           icon: Icon(Icons.check_circle_outline),
//           onPressed: () {
//             setState(() {
//               _beDigestedIdeas[index].isCompleted = true;
//             });
//           },
//         ),
//       );
//     },
//   );
// }

class AddIdeaScreen extends StatefulWidget {
  @override
  _AddIdeaScreenState createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Idea')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    Idea newIdea = Idea(
                      title: _title!,
                      description: _description!,
                      category: _category!,
                      dateCreated: DateTime.now(),
                    );
                    // Add the new idea to the appropriate list
                    // ...
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
