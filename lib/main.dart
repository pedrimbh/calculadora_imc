import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  String infoText = 'Informe seus dados';

  void _resetFields(){
    weightController.text = '';
    heightController.text = '';
    setState(() {
      infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
    double weight = double.tryParse( weightController.text) ?? 1.0;
    double height = double.tryParse( heightController.text)/100 ?? 1.0;
    double imc = weight / (height * height);
    if(imc < 18.6){
        infoText = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
    }else if(imc >= 18.6 && imc < 24.9){
      infoText = "Peso ideal ${imc.toStringAsPrecision(3)}";
    }else if(imc >= 24.9 && imc < 29.9){
      infoText = "Levemente acima do peso ${imc.toStringAsPrecision(3)}";
    }else if(imc >= 29.9 && imc < 34.9){
      infoText = "Obesidade Grau I ${imc.toStringAsPrecision(3)}";
    }else if(imc >= 34.9 && imc < 39.9){
      infoText = "Obesidade Grau II ${imc.toStringAsPrecision(3)}";
    }else if(imc >= 39.9){
      infoText = "Obesidade Grau III ${imc.toStringAsPrecision(3)}";
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu Peso!";
                    }
                    return null;
                  },
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                    return null;
                  },
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green, onPrimary: Colors.white),
                    ),
                  ),
                ),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
