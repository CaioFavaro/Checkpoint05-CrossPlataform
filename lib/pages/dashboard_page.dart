import 'package:expense_tracker/components/user_drawer.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var height, width;

  List imgData = [
    "images/pix.png",
    "images/consorcio.png",
    "images/investimento.png",
    "images/emprestimo.png",
    "images/seguro.png",
    "images/pagamento.png",
  ];

  List titles = [
    "Pix",
    "Consorcio",
    "Investimento",
    "Emprestimo",
    "Seguro",
    "Pagamento"
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      drawer: const UserDrawer(),
      body: Container(
          color: Colors.purple,
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.300,
                width: width,
                child: const Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('images/icone.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "DashBoard",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            "Ultima atualização 21 Outubro 2023",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                )
                              ]),
                          child: Column(
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 150,
                                alignment: Alignment.bottomCenter,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
