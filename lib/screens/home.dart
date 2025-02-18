import 'package:alarmui/provider/time_provider.dart';
import 'package:alarmui/screens/custom_time_picker.dart';
import 'package:alarmui/utils/custom_snackbar.dart';
import 'package:alarmui/utils/daysofweek.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void onTimeCheck(int minutes, int seconds) {
    print({"minutes": minutes, "seconds": seconds});
    final timerProvider = Provider.of<TimeProvider>(context, listen: false);
    timerProvider.setTime(minutes, seconds);
  }

  void startTimer() {
    final timerProvider = Provider.of<TimeProvider>(context, listen: false);
    if (timerProvider.minutes > 0 || timerProvider.seconds > 0) {
      timerProvider.startTime();
    } else {
     customSnackBar(context, "Please select time first");
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimeProvider>(context);
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
                        //  bottomLeft: Radius.circular(55),
                          //bottomRight: Radius.circular(55)
                          )
                          ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}",
                            style: const TextStyle(
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
                        painter: ProgressPainter(timerProvider.progress),
                        size: const Size(double.infinity, 150),
                      ),
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
                                  : const Color(0xff59644c)),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(60, 60),
                ),
                onPressed: () {
                  startTimer();
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Color(0xffa8c889),
                ),
              ),
              const SizedBox(width: 10,),
              IconButton(
                  style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(60, 60),
                ),
                onPressed: () {
                  timerProvider.isRuning ? timerProvider.pauseTimer() : customSnackBar(context, "Timer is not running");
                },
                icon: const Icon(Icons.pause, color: Color(0xffa8c889)),
              ),
                ],
              )
            ]
          ),
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 200,
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text(
                      "${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                          fontSize: 30, color: Color(0xffa8c889)),
                    ),
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.black,
                    foregroundColor: const Color(0xffa8c889),
                  )),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(60, 60),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CustomTimePicker(
                                onTimeSelected: onTimeCheck,
                              )));
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

/*class ProgressPainter extends CustomPainter {
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
}*/
class ProgressPainter extends CustomPainter {
  final double progress;
  final int totalBars = 40;

  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double barSpacing = size.width / totalBars;
    double barHeight = size.height * 0.8; 
    int currentProgress = (progress * totalBars).toInt();

    for (int i = 0; i < totalBars; i++) {
      paint.color = i < currentProgress ? Colors.red : const Color(0xffa8c889);
     /* canvas.drawLine(Offset(i * barSpacing, size.height),
          Offset(i * barSpacing, 0), paint);*/
          canvas.drawLine(
          Offset(i * barSpacing, size.height),  // Start from bottom
          Offset(i * barSpacing, size.height - barHeight), // Reduce height
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
