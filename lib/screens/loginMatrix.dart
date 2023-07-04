import 'package:Socialxmatch/controller/initialController.dart';
import 'package:Socialxmatch/screens/chatbot_screen.dart';
import 'package:Socialxmatch/screens/events_notification_screen.dart';
import 'package:Socialxmatch/screens/login_screen.dart';
import 'package:Socialxmatch/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  int _currentIndex = 0;
  var _accessToken = '';
  String StringtoMatch = '';
  InitialStatusController controller = Get.find();
  String eventstring = '';
  String timestring = '';
  String placestring = '';
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      StringtoMatch =
          ' ${controller.mostFrequentGenree} ${controller.mostUsedSocialMedia} ${controller.nofSteps.value} ${controller.locationText2} ';

      print("hfsjfhsfh :$StringtoMatch"); // Prints after 1 second.

      setState(() {});
    });
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _logout() async {
    final client = Provider.of<Client>(context, listen: false);
    await client.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  void _join(Room room) async {
    if (room.membership != Membership.join) {
      await room.join();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RoomPage(room: room),
      ),
    );
  }

  void creatRoom() {
    final client = Provider.of<Client>(context, listen: false);
    Map<String, dynamic> params = {
      "event": "Birthday Celeberation",
      "time": "2pm today",
      "place": "223 street lahore, pakistan",
    };
    client.createRoom(
        name: "Birthday Celeberation",
        topic: "Decide birthday venue",
        creationContent: params);
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                  disabledColor: Colors.black,
                  color: Colors.black,
                  icon: Icon(
                    Icons.notifications,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventNotificationScreen()),
                    );
                  },
                )),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotScreen()),
                );
              },
              child: CircleAvatar(
                maxRadius: 26,
                minRadius: 26,
                child: Icon(
                  Icons.chat,
                  size: 12,
                ),
              ),
            ),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                )),
            label: 'Settings',
          ),
        ],
      ),
      body: StringtoMatch == ''
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: client.onSync.stream,
              builder: (context, _) => ListView.builder(
                itemCount: client.rooms.length,
                itemBuilder: (context, i) {
                  // Get the creation content of the room.
                  var createEvent = client.rooms[i].getState("m.room.create");

// Check if the create event exists.
                  if (createEvent != null) {
                    // Get the content of the create event.
                    Map<String, dynamic>? creationContent = createEvent.content;

                    // Check if the creation content exists and contains the desired fields.
                    if (creationContent != null &&
                        creationContent.containsKey('event') &&
                        creationContent.containsKey('time') &&
                        creationContent.containsKey('place')) {
                      // Access the individual fields.
                      eventstring = creationContent['event'];
                      timestring = creationContent['time'];
                      placestring = creationContent['place'];

                      // Print the values.
                      print('Event: $eventstring');
                      print('Time: $timestring');
                      print('Place: $placestring');
                    }
                  }
                  return StringtoMatch.toLowerCase()
                              .contains(eventstring.toLowerCase()) ||
                          StringtoMatch.toLowerCase()
                              .contains(timestring.toLowerCase()) ||
                          StringtoMatch.toLowerCase()
                              .contains(placestring.toLowerCase())
                      ? ListTile(
                          leading: CircleAvatar(
                            foregroundImage: client.rooms[i].avatar == null
                                ? null
                                : NetworkImage(client.rooms[i].avatar!
                                    .getThumbnail(
                                      client,
                                      width: 56,
                                      height: 56,
                                    )
                                    .toString()),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                  child: Text(client.rooms[i].displayname)),
                              if (client.rooms[i].notificationCount > 0)
                                Material(
                                    borderRadius: BorderRadius.circular(99),
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(client
                                          .rooms[i].notificationCount
                                          .toString()),
                                    ))
                            ],
                          ),
                          subtitle: Text(
                            client.rooms[i].lastEvent?.body.toString() ==
                                    "m.room.create"
                                ? "No message"
                                : client.rooms[i].lastEvent!.body.toString(),
                            maxLines: 1,
                          ),
                          onTap: () => _join(client.rooms[i]),
                        )
                      : Container();
                },
              ),
            ),
    );
  }
}

class RoomPage extends StatefulWidget {
  final Room room;
  const RoomPage({required this.room, Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final Future<Timeline> _timelineFuture;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _count = 0;

  @override
  void initState() {
    _timelineFuture = widget.room.getTimeline(onChange: (i) {
      print('on change! $i');
      _listKey.currentState?.setState(() {});
    }, onInsert: (i) {
      print('on insert! $i');
      _listKey.currentState?.insertItem(i);
      _count++;
    }, onRemove: (i) {
      print('On remove $i');
      _count--;
      _listKey.currentState?.removeItem(i, (_, __) => const ListTile());
    }, onUpdate: () {
      print('On update');
    });
    super.initState();
  }

  final TextEditingController _sendController = TextEditingController();

  void _send() {
    widget.room.sendTextEvent(_sendController.text.trim());
    _sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.displayname),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Timeline>(
                future: _timelineFuture,
                builder: (context, snapshot) {
                  final timeline = snapshot.data;
                  if (timeline == null) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  _count = timeline.events.length;
                  return Column(
                    children: [
                      Center(
                        child: TextButton(
                            onPressed: timeline.requestHistory,
                            child: const Text('Load more...')),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: AnimatedList(
                          key: _listKey,
                          reverse: true,
                          initialItemCount: timeline.events.length > 6
                              ? timeline.events.length - 7
                              : timeline.events.length - 6,
                          itemBuilder: (context, i, animation) => timeline
                                      .events[i].relationshipEventId !=
                                  null
                              ? Container()
                              : ScaleTransition(
                                  scale: animation,
                                  child: Opacity(
                                    opacity: timeline.events[i].status.isSent
                                        ? 1
                                        : 0.5,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        foregroundImage: timeline.events[i]
                                                    .sender.avatarUrl ==
                                                null
                                            ? null
                                            : NetworkImage(timeline
                                                .events[i].sender.avatarUrl!
                                                .getThumbnail(
                                                  widget.room.client,
                                                  width: 56,
                                                  height: 56,
                                                )
                                                .toString()),
                                      ),
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(timeline
                                                .events[i].sender
                                                .calcDisplayname()),
                                          ),
                                          Text(
                                            timeline.events[i].originServerTs
                                                .toIso8601String(),
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(timeline.events[i]
                                          .getDisplayEvent(timeline)
                                          .body),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _sendController,
                    decoration: const InputDecoration(
                      hintText: 'Send message',
                    ),
                  )),
                  IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: _send,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
