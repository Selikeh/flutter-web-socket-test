import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_client/web_socket_client.dart';

class MeessagePage extends StatefulWidget {
  MeessagePage({super.key});

  @override
  State<MeessagePage> createState() => _MeessagePageState();
  WebSocketChannel channel =
      HtmlWebSocketChannel.connect("ws://localhost:3001/");
}

class _MeessagePageState extends State<MeessagePage> {
  TextEditingController messageFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Messages"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
                child: Container(
              child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                  );
                },
              ),
            )),
            Row(
              children: [
                SizedBox(
                  width: 32,
                  child: TextField(
                    controller: messageFieldController,
                    decoration: InputDecoration(labelText: "Send message"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.add))
              ],
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (messageFieldController.text.isNotEmpty) {
      widget.channel.sink.add(messageFieldController.text);
    }
  }
}
