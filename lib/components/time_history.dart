import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TimeHistory extends StatefulWidget {
  const TimeHistory({super.key});

  @override
  State<TimeHistory> createState() => _TimeHistoryState();
}

class _TimeHistoryState extends State<TimeHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 3,
                                dashPattern: [5, 5],
                                borderType: BorderType.RRect,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 300,
                                  height: 120,
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "9:42",
                                            style: TextStyle(fontSize: 60),
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            size: 70,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "KIND OF BLUE",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Color(0xff59644c)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              );
  }
}