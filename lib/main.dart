import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
//          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: const TextStyle(fontSize: 8),)),
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: const TextStyle(fontSize: 8),)),
//          BottomNavigationBarItem(icon: Icon(Icons.stars), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.video_library), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('Home')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
        iconSize: 24.0,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _pushSaved () {
    Navigator.of(context).push(
        _myNavigation1()
    );
  }

  Route _myNavigation1() {
    return new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
              print(123);
              return new ListTile(title: new Text(pair.asPascalCase, style: _biggerFont,));
            }
          );
          print(tiles);
          final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();
          return new Scaffold(
            appBar: new AppBar(title: new Text('Saved Suggestions')
          ),
            body: new ListView(children: divided),
          );
        }
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}