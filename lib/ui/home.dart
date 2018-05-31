import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController _idadeController = new TextEditingController();
  final TextEditingController _alturaController = new TextEditingController();
  final TextEditingController _pesoController = new TextEditingController();
  double _imc = 0.0;
  String _resultadoIMC = "";

  void _calculoIMC() {
    setState(() {
      double peso = 0.0;
      double altura = 0.0;

      // Se não for informado o peso ou altura não faz o calculo.
      if (_pesoController.text.isEmpty || _alturaController.text.isEmpty) {
        _imc = 0.0;
      } else {
        peso = double.parse(_pesoController.text.toString().replaceAll(',', '.'));
        altura = double.parse(_alturaController.text.toString().replaceAll(',', '.'));

        _imc = (peso / (altura * altura));
      }

      //Oculta o teclado ao finalizar o calculo
      FocusScope.of(context).requestFocus(new FocusNode());

      if (_imc < 16) {
        _resultadoIMC = "Magreza grave";
      } else if (_imc >= 16 && _imc < 17) {
        _resultadoIMC = "Magreza moderada";
      } else if (_imc >= 17 && _imc < 18.5) {
        _resultadoIMC = "Magreza leve";
      } else if (_imc >= 18.5 && _imc < 25) {
        _resultadoIMC = "Saudável";
      } else if (_imc >= 25 && _imc < 30) {
        _resultadoIMC = "Sobrepeso";
      } else if (_imc >= 30 && _imc < 35) {
        _resultadoIMC = "Obesidade grau I";
      } else if (_imc >= 35 && _imc < 40) {
        _resultadoIMC = "Obesidade grau II";
      } else if (_imc >= 40) {
        _resultadoIMC = "Obesidade grau II";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Massa Corporal"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            //Imagem Logo
            new Image.asset(
              'images/bmilogo.png',
              height: 90.0,
              width: 200.0,
            ),

            // Edits...Idade, Peso e Altura
            new Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  //Idade
                  Container(
                    width: 250.0,
                    child: TextField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Informe sua idade',
                        labelText: 'Idade',
                        icon: Icon(Icons.person_outline),
                      ),
                    ),
                  ), // Fim Idade

                  // Altura
                  Container(
                    width: 250.0,
                    child: TextField(
                      controller: _alturaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Informe a sua altura',
                          labelText: 'Altura',
                          icon: Icon(Icons.present_to_all)),
                    ),
                  ), // Fim Altura

                  //Peso
                  Container(
                    width: 250.0,
                    child: TextField(
                      controller: _pesoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Informe seu peso',
                          labelText: 'Peso',
                          icon: Icon(Icons.line_weight)),
                    ),
                  ),
                  // Fim Peso
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),

                  // Botão Calcular
                  Container(
                    width: 110.0,
                    color: Colors.pinkAccent,
                    child: RaisedButton(
                      onPressed: _calculoIMC,
                      color: Colors.pinkAccent,
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ), // Fim Botao Calcular

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),

                  Container(
                    child: Text(
                      _imc> 0.0 ? "IMC: ${_imc.toStringAsFixed(1)}" : "Informe peso e alturar para calcular o seu IMC.",
                      style: TextStyle(
                          fontSize: _imc> 0.0 ? 25.0 : 14.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                  ),

                  Container(
                    child: Text(
                      _imc> 0.0 ? "$_resultadoIMC" : "",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
