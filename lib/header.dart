import 'package:flutter/material.dart';
import 'package:gs_reloj_binario/back_clock.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HeaderPage extends StatefulWidget {
  const HeaderPage({super.key});

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
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
    final carta = InkWell(
      child: Container(
        margin: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20,
        ),
        //height: 50.0,
        //width: 180.0,
        //decoration: BoxDecoration(
        //boxShadow: const [
        //BoxShadow(
        //color: Color(0xFF023535),
        // offset: Offset(1.0, 1.0),
        // blurRadius: 30.0)
        //],
        // borderRadius: BorderRadius.circular(30.0),
        // color: Color(0xFFeb800),
        //),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
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
                                ? Color(0xFF0FC2C0) // color de numero
                                : Colors.transparent,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 37,
                          color: horaBits[i] ? Color(0xFF0FC2C0) : Colors.white,
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
                                ? Color(0xFF0CABA8)
                                : Colors.transparent,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 30,
                          color: minutoBits[i]
                              ? const Color(0xFF0CABA8)
                              : Colors.white,
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
                                ? Color(0xFF0FC2C0) // color de numero
                                : Colors.transparent,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 30,
                          color:
                              segundoBits[i] ? Color(0xFF0FC2C0) : Colors.white,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
    Timer.periodic(const Duration(seconds: 1), (timer) {
      actualizarHora();
    });
    return Scaffold(
      body: Stack(
        children: [
          BackClock(),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                const Text(
                  "RELOJ BINARIO",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFF0FC2C0),
                      fontWeight: FontWeight.w600),
                ),
                carta
              ],
            ),
          )
        ],
      ),
    );
  }
}
