import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:undo/undo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController input = new TextEditingController();
  String text = "";

  reverseStringUsingCodeUnits(String input) {
    setState(() {
      text = String.fromCharCodes(input.codeUnits.reversed);
      context.bloc<UndoBloc>().add(Increment(text));
    });
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIMPLE APP RICF"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
                keyboardType: TextInputType.text,
                controller: input,
                decoration:
                    InputDecoration(labelText: "Silahkan Masukan text Disini")),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Output Reverse : " + text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    reverseStringUsingCodeUnits(input.text);
                  },
                  child: Text(
                    "Reverse",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlue,
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.lightBlue,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        input.clear();
                      });
                    },
                    onDoubleTap: () {
                      setState(() {
                        context.bloc<UndoBloc>().redo();
                      });
                    },
                    child: Text(
                      "Undo/Redo",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UndoBloc extends ReplayBloc<UndoEvent, UndoState> {
  UndoBloc() : super(UndoInitial());

  @override
  Stream<UndoState> mapEventToState(
    UndoEvent event,
  ) async* {
    if (event is Increment) {
      if (event is UndoInitial) {
        yield InitializedCounter("");
      } else {
        yield InitializedCounter(event.text);
      }
    }
  }
}

@immutable
abstract class UndoEvent extends ReplayEvent {}

class Increment extends UndoEvent {
  final String text;
  Increment(this.text);
}

@immutable
abstract class UndoState {}

class UndoInitial extends UndoState {}

class InitializedCounter extends UndoState {
  final String text;

  InitializedCounter(this.text);
}
