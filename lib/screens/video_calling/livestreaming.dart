import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softec_app/screens/video_calling/agora_manager.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';

class LiveStreaming extends StatefulWidget {
  final ProductName selectedProduct;
  final bool isBroadcaster;

  const LiveStreaming(
      {Key? key, required this.selectedProduct, required this.isBroadcaster})
      : super(key: key);

  @override
  LiveStreamingState createState() => LiveStreamingState();
}

class LiveStreamingState extends State<LiveStreaming> {
  late AgoraManager agoraManager;
  bool isAgoraManagerInitialized = false;

  // Build UI
  @override
  Widget build(BuildContext context) {
    if (!isAgoraManagerInitialized) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live stream page'),
      ),
      body: Stack(
        children: [
          mainVideoView(), // The main video frame
          if (agoraManager.isJoined)
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  await leave();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 75,
                  width: 75,
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.call_end,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          // scrollVideoView(), // Scroll view with multiple videos
          // radioButtons(), // Choose host or audience
          // const SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  void initState() {
    initialize();

    super.initState();
  }

  Future<void> initialize() async {
    // Set up an instance of AgoraManager
    agoraManager = await AgoraManager.create(
      currentProduct: widget.selectedProduct,
      messageCallback: showMessage,
      eventCallback: eventCallback,
    );

    setState(() {
      initializeUiHelper(agoraManager, setStateCallback);
      isAgoraManagerInitialized = true;
    });

    _handleRadioValueChange(widget.isBroadcaster);
    join();
  }

  Future<void> join() async {
    await agoraManager.join();
  }

  // Release the resources when you leave
  @override
  Future<void> dispose() async {
    agoraManager.dispose();
    super.dispose();
  }

  void eventCallback(String eventName, Map<String, dynamic> eventArgs) {
    // Handle the event based on the event name and named arguments
    switch (eventName) {
      case 'onConnectionStateChanged':
        // Connection state changed
        if (eventArgs["reason"] ==
            ConnectionChangedReasonType.connectionChangedLeaveChannel) {
          setState(() {});
        }
        break;

      case 'onJoinChannelSuccess':
        setState(() {});
        break;

      case 'onUserJoined':
        onUserJoined(eventArgs["remoteUid"]);
        break;

      case 'onUserOffline':
        onUserOffline(eventArgs["remoteUid"]);
        break;

      default:
        // Handle unknown event or provide a default case

        showMessage(
          'Event Name: $eventName, Event Args: $eventArgs',
          success: true,
        );
        break;
    }
  }

  showMessage(String message, {bool success = false}) {
    // if (success) {
    SnackBars.success(context, message);
    // } else {
    //   SnackBars.failure(context, message);
    // }
  }

  void setStateCallback() {
    setState(() {});
  }

  late AgoraManager _agoraManager;
  late VoidCallback _setStateCallback;
  int mainViewUid = -1;
  List<int> scrollViewUids = [];

  void initializeUiHelper(
      AgoraManager agoraManager, VoidCallback setStateCallback) {
    _agoraManager = agoraManager;
    _setStateCallback = setStateCallback;
  }

  Future<void> leave() async {
    await _agoraManager.leave();
    mainViewUid = -1;
    scrollViewUids.clear();
  }

  // Display local video preview
  Widget mainVideoView() {
    if (_agoraManager.currentProduct == ProductName.voiceCalling) {
      return Container();
    } else if (_agoraManager.isJoined) {
      if (mainViewUid == -1 && _agoraManager.isBroadcaster) {
        // Initialize local video in the main view
        mainViewUid = 0;
      } else if (mainViewUid == -1) {
        return textContainer("Waiting for a host to join", 240);
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: mainViewUid == 0
              ? _agoraManager.localVideoView()
              : _agoraManager.remoteVideoView(mainViewUid),
        ),
      );
    } else {
      return textContainer('Live stream is starting', 500);
    }
  }

  Widget textContainer(String text, double height) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(text, textAlign: TextAlign.center),
          ),
          15.verticalSpace,
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget scrollVideoView() {
    if (_agoraManager == null ||
        _agoraManager.currentProduct != ProductName.videoCalling) {
      return Container();
    } else if (_agoraManager.remoteUids.isEmpty) {
      return textContainer(
          _agoraManager.isJoined
              ? 'Waiting for a remote user to join'
              : 'Join a channel',
          120);
    } else if (_agoraManager.isBroadcaster &&
        (_agoraManager.currentProduct == ProductName.interactiveLiveStreaming ||
            _agoraManager.currentProduct == ProductName.broadcastStreaming)) {
      return Container();
    }

    if (_agoraManager.agoraEngine == null) return textContainer("", 240);

    // Create a list of Uids for videos in the scroll view
    scrollViewUids.clear();
    scrollViewUids.addAll(_agoraManager.remoteUids);
    scrollViewUids
        .remove(mainViewUid); // This video is displayed in the main view
    if (mainViewUid > 0) {
      scrollViewUids.add(0); // Add local video to scroll view
    }

    return Container(
      height: 120, // Set the desired height
      decoration: BoxDecoration(border: Border.all()),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: scrollViewUids.length,
        itemBuilder: (context, index) {
          final uid = scrollViewUids[index]; // Get the remoteUid
          return GestureDetector(
            onTap: () {
              // Handle the onTap event for the container
              handleVideoTap(uid);
            },
            child: Container(
              width: 120, // Set the desired width
              margin: const EdgeInsets.fromLTRB(0, 3, 5, 3),
              child: uid == 0
                  ? _agoraManager.localVideoView()
                  : _agoraManager.remoteVideoView(uid),
            ),
          );
        },
      ),
    );
  }

  void handleVideoTap(int remoteUid) {
    mainViewUid = remoteUid;
    _setStateCallback();
  }

  Widget radioButtons() {
    // Radio Buttons
    if (_agoraManager.currentProduct == ProductName.interactiveLiveStreaming ||
        _agoraManager.currentProduct == ProductName.broadcastStreaming) {
      return Row(children: <Widget>[
        Radio<bool>(
          value: true,
          groupValue: _agoraManager.isBroadcaster,
          onChanged: (value) => _handleRadioValueChange(value),
        ),
        const Text('Host'),
        Radio<bool>(
          value: false,
          groupValue: _agoraManager.isBroadcaster,
          onChanged: (value) => _handleRadioValueChange(value),
        ),
        const Text('Audience'),
      ]);
    } else {
      return Container();
    }
  }

  void onUserOffline(int remoteUid) {
    if (mainViewUid == remoteUid) {
      mainViewUid = -1;
    }
    _setStateCallback();
  }

  void onUserJoined(int remoteUid) {
    if (!_agoraManager.isBroadcaster) {
      mainViewUid = remoteUid;
    }
    _setStateCallback();
  }

  // Set the client role when a radio button is selected
  void _handleRadioValueChange(bool? value) async {
    _agoraManager.isBroadcaster = (value == true);
    _setStateCallback();
    if (_agoraManager.isJoined) leave();
  }
}
