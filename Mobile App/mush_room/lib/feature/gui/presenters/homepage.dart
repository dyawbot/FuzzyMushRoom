import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mush_room/feature/gui/components/widgets/app_router.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double gauzeSize = 250;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Column(
            children: [
              Container(
                width: width,
                alignment: Alignment.centerRight,
                child: IconButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      AutoRouter.of(context).navigate(VideoCameraRoute());
                    },
                    icon: Icon(Icons.videocam)),
              ),
              SizedBox(
                height: gauzeSize,
                width: 250,
                child: SfRadialGauge(
                    title: GaugeTitle(
                      text: 'Temperature (°C)',
                    ),
                    axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 50, color: Colors.green),
                        GaugeRange(
                            startValue: 50,
                            endValue: 100,
                            color: Colors.orange),
                        GaugeRange(
                            startValue: 100, endValue: 150, color: Colors.red)
                      ], pointers: <GaugePointer>[
                        NeedlePointer(value: 28)
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('28.0',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: gauzeSize,
                width: 250,
                child: SfRadialGauge(
                    title: GaugeTitle(text: 'Humidity (%)'),
                    axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 50, color: Colors.green),
                        GaugeRange(
                            startValue: 50,
                            endValue: 100,
                            color: Colors.orange),
                        GaugeRange(
                            startValue: 100, endValue: 150, color: Colors.red)
                      ], pointers: <GaugePointer>[
                        NeedlePointer(value: 80)
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('80.0',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    const Text("Light Intensity (LUX)"),
                    const SizedBox(
                      height: 12,
                    ),
                    SfLinearGauge(
                      ranges: const [
                        LinearGaugeRange(
                          startValue: 0,
                          endValue: 50,
                        ),
                      ],
                      markerPointers: const [
                        LinearShapePointer(
                          value: 50,
                        ),
                      ],
                      barPointers: const [LinearBarPointer(value: 80)],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
