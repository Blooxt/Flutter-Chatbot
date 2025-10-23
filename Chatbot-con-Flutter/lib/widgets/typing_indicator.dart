import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TypingIndicator extends StatelessWidget {
  final String text;
  const TypingIndicator({super.key, this.text = 'Preparando respuesta espere...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          const SpinKitThreeBounce(size: 18.0, color: Colors.blueAccent,),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}