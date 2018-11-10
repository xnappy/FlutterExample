import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(OverviewPage());

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codalin',
      theme: ThemeData.dark(),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Codalin Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(20));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage()),
        );

        /*setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });*/
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    )
                  );
                }
            );
            final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved Words'),
              ),
              body: new ListView(children: divided),
            );
          }
      )
    );
  }
}

///////////////// SECOND PAGE //////////////////

class DetailsPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codalin',
      theme: ThemeData.dark(),
      home: Details(),
    );
  }
}

class Details extends StatefulWidget {
  @override
  RandomWordDescriptionState createState() => new RandomWordDescriptionState();
}

class RandomWordDescriptionState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Codalin Name Generator'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
