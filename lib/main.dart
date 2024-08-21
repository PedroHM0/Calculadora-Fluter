import 'package:flutter/material.dart';

void main() {
  // Ponto de entrada da aplicação.
  runApp(CalculadoraApp());
}

// Classe principal da aplicação que define o tema e a estrutura básica.
class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de depuração.
      title: 'Calculadora', // Título da aplicação.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Esquema de cores azul.
        brightness: Brightness.dark, // Define o tema escuro.
      ),
      home: Calculadora(), // Define a tela inicial.
    );
  }
}

// Classe Stateful que representa a calculadora.
class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

// Classe que mantém o estado da calculadora.
class _CalculadoraState extends State<Calculadora> {
  String output = "0"; // Armazena o valor mostrado na tela.
  String _output = "0"; // Armazena o valor atual sendo calculado.
  double num1 = 0.0; // Armazena o primeiro número.
  double num2 = 0.0; // Armazena o segundo número.
  String operand = ""; // Armazena o operador (+, -, *, /).

  // Função chamada quando um botão é pressionado.
  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      // Limpa todos os valores se o botão "C" for pressionado.
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" ||
        buttonText == "/" || buttonText == "*") {
      // Se um operador for pressionado, armazena o primeiro número e o operador.
      num1 = double.parse(_output);
      operand = buttonText;
      _output += buttonText;
    } else if (buttonText == ".") {
      // Adiciona um ponto decimal se não houver nenhum.
      if (_output.contains(".")) {
        return;
      } else {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      // Se o botão "=" for pressionado, realiza o cálculo com base no operador.
      num2 = double.parse(_output.split(operand).last);
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          _output = (num1 / num2).toString();
          break;
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      // Adiciona o número pressionado ao valor atual.
      _output += buttonText;
    }

    // Atualiza o estado para refletir as mudanças na interface.
    setState(() {
      output = _output;
    });
  }

  // Função que constrói um botão.
  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.blueAccent, // Cor do botão.
            textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // Estilo do texto.
          ),
          child: Text(buttonText),
          onPressed: () => buttonPressed(buttonText), // Associa o botão à função.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'), // Título da barra de aplicação.
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold, // Estilo do texto do display.
              ),
            ),
          ),
          Expanded(
            child: Divider(), // Linha divisória entre o display e os botões.
          ),
          Column(children: [
            Row(children: [
              buildButton("7"), // Cria o botão "7".
              buildButton("8"), // Cria o botão "8".
              buildButton("9"), // Cria o botão "9".
              buildButton("/"), // Cria o botão "/".
            ]),
            Row(children: [
              buildButton("4"), // Cria o botão "4".
              buildButton("5"), // Cria o botão "5".
              buildButton("6"), // Cria o botão "6".
              buildButton(""), // Cria o botão "".
            ]),
            Row(children: [
              buildButton("1"), // Cria o botão "1".
              buildButton("2"), // Cria o botão "2".
              buildButton("3"), // Cria o botão "3".
              buildButton("-"), // Cria o botão "-".
            ]),
            Row(children: [
              buildButton("."), // Cria o botão ".".
              buildButton("0"), // Cria o botão "0".
              buildButton("00"), // Cria o botão "00".
              buildButton("+"), // Cria o botão "+".
            ]),
            Row(children: [
              buildButton("C"), // Cria o botão "C".
              buildButton("="), // Cria o botão "=".
            ]),
          ])
        ],
     ),
    );
  }
}