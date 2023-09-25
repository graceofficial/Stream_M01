import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class contoh2 extends StatefulWidget {
  const contoh2({Key? key}) : super(key: key);

  @override
  State<contoh2> createState() => _contoh2State();
}

class _contoh2State extends State<contoh2> {
  late StreamSubscription _sub;
  final Stream _myStream =
      Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  String Textstatus = "";
  int percent = 100;
  int getSteam = 0;
  int _Persen = 100;
  double circular = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream")),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double avaWidth = constraints.maxWidth;
            final double avaHeight = constraints.maxHeight;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: CircularPercentIndicator(
                    radius: avaHeight / 5,
                    lineWidth: 10,
                    percent: circular,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$_Persen %",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Textstatus,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ), //yg di modul percent di ubah jadi _Persen, makanya angka yg didalam persen berkurang
                  ))
                ]);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Tombol Reset
              setState(() {
                Textstatus = "";
                _Persen = 100;
                circular = 1.0;
              });
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              // Tombol Stop
              if (_sub != null) {
                _sub.cancel();
              }
              setState(() {
                Textstatus = "Stopped";
              });
            },
            backgroundColor: Colors.orange,
            child: Icon(Icons.stop),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              // Tombol Play
              final cekBil = _Persen % 2 == 0;
              if (cekBil) {
                _sub = _myStream.listen((event) {
                  getSteam = int.parse(event.toString());
                  setState(() {
                    if (_Persen - getSteam <= 0) {
                      _sub.cancel();
                      _Persen = 0;
                      circular = 0;
                      Textstatus = "Empty";
                    } else {
                      _Persen = _Persen - getSteam;
                      circular = _Persen / 100;
                      Textstatus = _Persen == 100 ? "Full" : "";
                    }
                  });
                });
              } else {
                setState(() {
                  if (circular == 1.0) {
                    Textstatus = "Full";
                  } else if (circular == 0.0) {
                    Textstatus = "Empty";
                  } else {
                    Textstatus = "";
                  }
                });
              }
            },
            backgroundColor: Colors.green, // Warna untuk tombol Play
            child: Icon(Icons.play_arrow), // Icon untuk tombol Play
          ),
        ],
      ),
    );
  }
}
