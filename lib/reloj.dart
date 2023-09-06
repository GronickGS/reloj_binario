import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class RelojBinario extends StatefulWidget {
  const RelojBinario({Key? key}) : super(key: key);

  @override
  State<RelojBinario> createState() => _RelojBinarioState();
}

class _RelojBinarioState extends State<RelojBinario> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      actualizarHora();
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'Reloj binario',
          style: TextStyle(
            fontFamily: 'Oldenburg',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 26, 54, 92),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatearHora,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oldenburg',
                color: Color.fromARGB(255, 26, 54, 92),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < horaBits.length; i++)
                  Column(
                    children: [
                      Text(
                        '${1 << i}', // Cambio en el cálculo del valor
                        style: TextStyle(
                          fontSize: 18,
                          color: horaBits[i]
                              ? Color.fromARGB(255, 43, 74, 92)
                              : Colors.transparent,
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 37,
                        color: horaBits[i]
                            ? Color.fromARGB(255, 74, 110, 131)
                            : Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < minutoBits.length; i++)
                  Column(
                    children: [
                      Text(
                        '${1 << i}', // Cambio en el cálculo del valor
                        style: TextStyle(
                          fontSize: 18,
                          color: minutoBits[i]
                              ? Color.fromARGB(255, 69, 124, 156)
                              : Colors.transparent,
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 30,
                        color: minutoBits[i]
                            ? const Color.fromARGB(255, 69, 124, 156)
                            : Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < segundoBits.length; i++)
                  Column(
                    children: [
                      Text(
                        '${1 << i}', // Cambio en el cálculo del valor
                        style: TextStyle(
                          fontSize: 18,
                          color: segundoBits[i]
                              ? Color.fromARGB(255, 73, 151, 179)
                              : Colors.transparent,
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 30,
                        color: segundoBits[i]
                            ? Color.fromARGB(255, 73, 151, 179)
                            : Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
