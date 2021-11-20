import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessais/models/conta.dart';

Widget cardConta(BuildContext context, Conta contas) {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
              color: Color(0x100000),
              blurRadius: 10,
              spreadRadius: 4,
              offset: Offset(0.0, 8.0))
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 14,
            right: 14,
            child: Text(
              contas.titulo,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          const Positioned(
            top: 63,
            left: 16,
            child: Text(
              "Saldo em conta",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 81,
            left: 16,
            child: Text(
              "R\$" + contas.saldo.toString(),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}
