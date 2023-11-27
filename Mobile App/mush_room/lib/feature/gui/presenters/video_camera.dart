import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class VideoCameraPage extends StatefulWidget {
  const VideoCameraPage({super.key});

  @override
  State<VideoCameraPage> createState() => _VideoCameraPageState();
}

class _VideoCameraPageState extends State<VideoCameraPage> {
  bool hasError = true;
  // VideoPlayerController videoPlayerController;
  // late VideoPlayerController _videoPlayerController;
  late Stream<Uint8List> frameStream;
  // late Future<Response> _videoFeedFuture;

  List<int> imageBytes = [];

  // Define the URL of your Flask server.
  final String flaskServerUrl = "http://192.168.254.103:5000/api/video";

  late WebViewController controller;
  String formattedDateTime = "";
  WebResourceErrorType errorResource = WebResourceErrorType.connect;
  String initialMessage = "Server is trying to connect";

  void _loadWebViewContent() async {
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..enableZoom(true)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              setState(() {
                if (errorResource != WebResourceErrorType.timeout) {
                  initialMessage = 'Camera is loading (progress : $progress%)';
                } else {
                  initialMessage =
                      "Camera is unable to open because the server is down";
                }
              });
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
              if (errorResource != WebResourceErrorType.timeout) {
                setState(() {
                  hasError = false;
                });
              }
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
              if (errorResource != WebResourceErrorType.timeout) {
                hasError = false;
              }
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                hasError = true;
                errorResource = error.errorType!;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error encountered: ${error.description}")));
              debugPrint('''
                    Page resource error:
                      code: ${error.errorCode}
                      description: ${error.description}
                      errorType: ${error.errorType}
                      isForMainFrame: ${error.isForMainFrame}
                              ''');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                debugPrint('blocking navigation to ${request.url}');
                return NavigationDecision.prevent;
              }
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) {
              debugPrint('url change to ${change.url}');
            },
          ),
        )
        ..loadRequest(Uri.parse(flaskServerUrl));
    } on Exception catch (e) {
      print("Error loading WebView: $e");
      setState(() {
        hasError = true;
      });
    }
    controller.clearCache();
  }

  @override
  void initState() {
    super.initState();

    _loadWebViewContent();

    DateTime currentDateTime = DateTime.now();
    formattedDateTime = DateFormat('yyyy-MM-dd').format(currentDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Monitoring"),
          actions: [
            IconButton(
                onPressed: () async {
                  // print();
                  // controller.
                },
                icon: Icon(Icons.camera_alt_rounded))
          ],
        ),
        body: SafeArea(
            child: Stack(
          children: [
            hasError
                ? Container(
                    child: Center(child: Text(initialMessage)),
                  )
                : WebViewWidget(controller: controller),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  // alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            hasError ? Icons.videocam_off : Icons.videocam,
                            color: hasError
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            hasError ? "Offline" : "Online",
                            style: TextStyle(
                                color: hasError
                                    ? Colors.redAccent
                                    : Colors.greenAccent),
                          ),
                        ],
                      ),
                      Text(formattedDateTime),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(),
            )
          ],
        )));
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController.dispose();
    // controller.dispose()
    // controller.clearCache();
    if (controller != null && controller!.currentUrl != null) {
      controller.clearCache();
    }
  }
}
