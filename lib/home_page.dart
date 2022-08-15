import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_collection/models/test_dataset.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

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

  List<TestDataset> _testDataCollection;
  List<DocumentSnapshot> _testDatasetDocument;
  Stream _testDatasetStream;

  @override
  void initState() {
    _testDatasetStream = FirebaseFirestore.instance.collection("test_dataset").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _testDatasetStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Waiting foir Connection");
                    }
                    _testDatasetDocument = snapshot.data.docs;
                    _testDataCollection = _testDatasetDocument.map((DocumentSnapshot testDataCollectionFields) {
                      return TestDataset.fromMap(testDataCollectionFields.data());
                    }).toList();
                    print(_testDataCollection);
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Text(_testDataCollection[index].name),
                            Text(_testDataCollection[index].age.toString()),
                            Text(_testDataCollection[index].company)
                          ],
                        );
                      },
                      itemCount: _testDataCollection.length,
                    );
                  }),
            )
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
}
