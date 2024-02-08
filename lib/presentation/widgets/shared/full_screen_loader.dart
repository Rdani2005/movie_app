import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    'Just buying popcorns',
    'Wait... Where\'s my girlfriend?',
    'Just waiting movie to begin',
    'Turn off your phone!',
    'Movie is starting soon!',
    'Turn on the TV please... Wait, What?',
    'Stop laughing now!',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Wait for a sec"),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading');
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
