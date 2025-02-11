import 'package:alarmui/screens/custom_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> daysOfWeek = ['MON', 'TUE', 'WES', 'THU', 'SAT', 'SUN'];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffa8c889),
      child: Scaffold(
        backgroundColor: const Color(0xffa8c889),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55),
                          topRight: Radius.circular(55),
                          bottomLeft: Radius.circular(55),
                          bottomRight: Radius.circular(55))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          const Text(
                            "10:00",
                            style: TextStyle(
                                height: 0,
                                fontSize: 150,
                                color: Color(0xffa8c889)),
                          ),
                          const Text(
                            "NEXT ALARM CLOCK IN 19 MIN",
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff69745f)),
                          ),
                        ],
                      ),
                      CustomPaint(
                        painter: ProgressPainter(5),
                        size: const Size(double.infinity, 150),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: daysOfWeek
                    .map((day) => Text(
                          day,
                          style: TextStyle(
                              fontSize: 22,
                              color: DateTime.now().weekday ==
                                      daysOfWeek.indexOf(day) + 1
                                  ? Colors.black
                                  : Color(0xff59644c)),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
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
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(60, 60),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month,
                  color: Color(0xffa8c889),
                ),
              ),
              SizedBox(
                  width: 200,
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: const Text(
                      "10:00",
                      style: TextStyle(fontSize: 30, color: Color(0xffa8c889)),
                    ),
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.black,
                    foregroundColor: Color(0xffa8c889),
                  )),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(60, 60),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CustomTimePicker()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Color(0xffa8c889),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final int totalBar = 40;
  final int currentProgress;

  ProgressPainter(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    double barSpacing = size.width / totalBar;
    for (int i = 0; i < totalBar; i++) {
      paint.color = i < currentProgress
          ? const Color(0xff33333)
          : const Color(0xffa8c889);
      canvas.drawLine(Offset(i * barSpacing, size.height),
          Offset(i * barSpacing, 0), paint);
      if (i % 5 == 0 && i != currentProgress) {
        paint
          ..style = PaintingStyle.fill
          ..color = const Color(0xffa8c889);
        canvas.drawCircle(Offset(i * barSpacing, -30), 3, paint);
        paint.style = PaintingStyle.stroke;
      }
      paint.color = Colors.red;
      canvas.drawLine(Offset(currentProgress * barSpacing, size.height),
          Offset(currentProgress * barSpacing, 0), paint);
      paint.strokeWidth = 3;

      paint
        ..style = PaintingStyle.fill
        ..color = Colors.red;

      final path = Path();
      final arrowx = currentProgress * barSpacing;
      path.moveTo(arrowx, -20);
      path.lineTo(arrowx - 10, -40);
      path.lineTo(arrowx - 10, 40);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
