import 'dart:math';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String datos = "";
  String resultado = "";

  void _handleButtonPress(String valor) {
    setState(() {
      if (valor == "C") {
        datos = "";
        resultado = "";
      } else if (valor == "+" || valor == "-" || valor == "*" || valor == "/") {
        if (datos.isNotEmpty) {
          if (resultado.isNotEmpty) {
            datos = resultado + " $valor ";
            resultado = "";
          } else {
            datos += " $valor ";
          }
        }
      } else if (valor == "=") {
        try {
          final evalResult = operaciones(datos);
          resultado = evalResult.toString();
        } catch (e) {
          resultado = "Error";
        }
      } else if (valor == "⌫") {
        if (datos.isNotEmpty) {
          datos = datos.substring(0, datos.length - 1);
        }
      } else if (valor == ".") {
        if (!datos.contains(".")) {
          datos += valor;
        }
      } else if (valor == "%") {
        try {
          final evalResult = operaciones(datos);
          resultado = (evalResult / 100).toString();
        } catch (e) {
          resultado = "Error";
        }
      } else if (valor == "√") {
        try {
          final evalResult = operaciones(datos);
          resultado = sqrt(evalResult).toString();
        } catch (e) {
          resultado = "Error";
        }
      } else {
        datos += valor;
      }
    });
  }

  double operaciones(String expression) {
    List<String> tokens = expression.split(" ");
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double operand = double.parse(tokens[i + 1]);
      if (operator == "+") {
        result += operand;
      } else if (operator == "-") {
        result -= operand;
      } else if (operator == "*") {
        result *= operand;
      } else if (operator == "/") {
        result /= operand;
      }
    }
    return result;
  }

  Widget botones(String label,
      {int flex = 1,
      Color labelColor = Colors.white,
      Color backgroundColor = Colors.black}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => _handleButtonPress(label),
          style: ElevatedButton.styleFrom(
            foregroundColor: labelColor,
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.all(20.0),
            minimumSize: Size.zero,
          ),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 24.0,
                fontFamily: 'Oldenburg'), // Aplicar la fuente Oldenburg
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(
              fontFamily: 'Oldenburg',
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 199, 24, 24)),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFF000000),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 12.0),
                      child: Text(
                        datos,
                        style: const TextStyle(
                            fontSize: 48.0,
                            color: Colors.white,
                            fontFamily:
                                'Oldenburg'), // Aplicar la fuente Oldenburg
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      child: Text(
                        resultado,
                        style: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.white,
                            fontFamily:
                                'Oldenburg'), // Aplicar la fuente Oldenburg
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0),
              Row(
                children: [
                  botones("C",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                  botones("⌫",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                  botones("√",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                  botones("/",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                ],
              ),
              Row(
                children: [
                  botones("7"),
                  botones("8"),
                  botones("9"),
                  botones("*",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                ],
              ),
              Row(
                children: [
                  botones("4"),
                  botones("5"),
                  botones("6"),
                  botones("-",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                ],
              ),
              Row(
                children: [
                  botones("1"),
                  botones("2"),
                  botones("3"),
                  botones("+",
                      labelColor: const Color.fromARGB(255, 199, 24, 24)),
                ],
              ),
              Row(
                children: [
                  botones("."),
                  botones("0",
                      labelColor: Colors.white, backgroundColor: Colors.black),
                  botones("=",
                      flex: 2,
                      labelColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 199, 24, 24)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
