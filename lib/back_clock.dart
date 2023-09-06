import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class BackClock extends StatefulWidget {
  const BackClock({Key? key}) : super(key: key);

  @override
  State<BackClock> createState() => _BackClockState();
}

class _BackClockState extends State<BackClock> {
  late Timer _timer;
  bool _obscureText = false;

  List<bool> obtenerBits(int value, int size) {
    List<bool> bits = [];
    for (int i = 0; i < size; i++) {
      int valorBit = 1 << i;
      bits.add((value & valorBit) != 0);
    }
    return bits;
  }

  String formatearHora = '';
  List<bool> horaBits = [];
  List<bool> minutoBits = [];
  List<bool> segundoBits = [];

  @override
  void initState() {
    super.initState();
    actualizarHora();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => actualizarHora());
  }

  void actualizarHora() {
    DateTime now = DateTime.now();
    horaBits = obtenerBits(now.hour, 5);
    minutoBits = obtenerBits(now.minute, 6);
    segundoBits = obtenerBits(now.second, 6);
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    setState(() {
      formatearHora = formattedTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBack(),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: _obscureText,
                        child: Text(
                          formatearHora,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Oldenburg',
                            color: Color(0xFF023535),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _obscureText
                              ? Color(0xFF023535)
                              : Color(
                                  0xFF015958), // Cambia el color a rojo cuando el texto está oculto
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientBack extends StatelessWidget {
  const GradientBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF015958), Color(0xFF023535)],
          begin: FractionalOffset(1.0, 0.1),
          end: FractionalOffset(1.0, 0.9),
        ),
      ),
    );
  }
}
