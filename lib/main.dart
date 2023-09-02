import 'package:app/center_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_top/scroll_to_top.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  static const List<Map<String, dynamic>> centres = [
    {
      "Name": "Metro Coaching Center",
      "Rating": 4.3,
      "Distance": 3.0,
      "Colleagues": 2,
      "Tags": ["Physics", "Maths", "Chemistry", "JEE"],
      "Discount": 30,
      'Location': 'Kalkaji, New Delhi',
      'Image':
          'https://images.pexels.com/photos/3316924/pexels-photo-3316924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    },
    {
      "Name": "Noida Coaching Center",
      "Rating": 4.2,
      "Distance": 2.5,
      "Colleagues": 0,
      "Tags": ["Physics", "Maths", "Chemistry", "JEE", "NEET"],
      "Discount": 0,
      'Location': 'Sector 32, Noida',
      'Image':
          'https://images.pexels.com/photos/3316924/pexels-photo-3316924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    },
    {
      "Name": "Metro Coaching Center",
      "Rating": 3.9,
      "Distance": 3.0,
      "Colleagues": 2,
      "Tags": ["Physics", "Maths", "Chemistry", "JEE"],
      "Discount": 30,
      'Location': 'Kalkaji, New Delhi',
      'Image':
          'https://images.pexels.com/photos/3316924/pexels-photo-3316924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    },
    {
      "Name": "Metro Coaching Center",
      "Rating": 3.8,
      "Distance": 3.0,
      "Colleagues": 2,
      "Tags": ["Physics", "Maths", "Chemistry", "JEE"],
      "Discount": 30,
      'Location': 'Kalkaji, New Delhi',
      'Image':
          'https://images.pexels.com/photos/3316924/pexels-photo-3316924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    },
    {
      "Name": "Noida Coaching Center",
      "Rating": 4.7,
      "Distance": 2.5,
      "Colleagues": 0,
      "Tags": ["Physics", "Maths", "Chemistry", "JEE", "NEET"],
      "Discount": 0,
      'Location': 'Sector 45, Noida',
      'Image':
          'https://images.pexels.com/photos/3316924/pexels-photo-3316924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    },
  ];

  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState(centres);
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _textEditingController = TextEditingController();
  late List<Map<String, dynamic>> _centres;
  late List<Map<String, dynamic>> _searchResults;
  String _searched = '';
  FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late List<String> _selectedTags;
  final _tags = ['JEE', 'NEET', '<2Km', 'Offer'];
  String _sortField = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
    _sortField = '';
    _selectedTags = [];
    _searchResults = _centres;
  }

  _MyWidgetState(List<Map<String, dynamic>> centres) {
    _centres = centres;
  }

  void _searchCentre(String centreName) {
    List<Map<String, dynamic>> _results = [];
    if (centreName.isEmpty) {
      _results = _centres;
    } else {
      _results = _centres
          .where(
              (element) => element['Name'].toLowerCase().contains(centreName))
          .toList();
    }
    print(centreName);
    setState(() {
      _searchResults = _results;
    });
  }

  void _selectTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag))
        _selectedTags.remove(tag);
      else
        _selectedTags.insert(0, tag);
    });
  }

  void _sortCenters(String field, bool asc) {
    List<Map<String, dynamic>> resC = new List.from(_searchResults);

    setState(() {
      _sortField = field;
      if (asc)
        resC.sort((a, b) => a[_sortField].compareTo(b[_sortField]));
      else
        resC.sort((a, b) => b[_sortField].compareTo(a[_sortField]));
      _searchResults = resC;
    });
  }

  void _micSearch(String search) {
    setState(() {
      _searched = search;
    });
    _textEditingController.text = search;
  }

  void sortResults() {
    setState(() {
      _searchResults = _searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _firstCenters = [];
    List<dynamic> _secondCenters = [];

    if (_sortField != '') {
      sortResults();
    }

    if (!_selectedTags.isEmpty) {
      List<dynamic> res = [];
      for (final center in _searchResults) {
        if (center['Tags'].every((element) => _selectedTags.contains(element)))
          res.insert(0, center);
      }
      _firstCenters = res;
    } else {
      if (_searchResults.length >= 4)
        _firstCenters = _searchResults.take(4).toList();
      else
        _firstCenters = _searchResults;
      if (_searchResults.length > 4)
        _secondCenters = _searchResults.skip(4).toList();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  SystemNavigator.pop();
                },
                borderRadius:
                    BorderRadius.circular(5.0), // Adjust the radius as needed
                child: Container(
                  width: 20.0, // Adjust the width and height to create a circle
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 15,
                  ),
                )),
            title: const Text(
              'For JEE-Mains',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: Container(
            width: screenWidth,
            height: screenHeight,
            child: ScrollToTop(
              btnColor: const Color(0xFF7D23E0),
              scrollController: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                onEditingComplete: () {
                                  _searchCentre(_searched);
                                },
                                focusNode: _focusNode,
                                onChanged: (centerName) {
                                  if (centerName.length < _searched.length) {
                                    setState(() {
                                      _searched = centerName;
                                    });
                                    _searchCentre(centerName);
                                    return;
                                  }
                                  setState(() {
                                    _searched = centerName;
                                  });
                                  if (centerName.isEmpty) {
                                    setState(() {
                                      _searchCentre(_searched);
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search for UPSC Coaching',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                _searchCentre(_searched);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.mic),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BottomDialog(callback: _micSearch);
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.025),
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenWidth,
                        child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Color(0xFF7D23E0))),
                                        child: InkWell(
                                          onTap: () {
                                            final RenderBox overlay =
                                                Overlay.of(context)
                                                        .context
                                                        .findRenderObject()
                                                    as RenderBox;
                                            final RenderBox inkWellBox =
                                                context.findRenderObject()
                                                    as RenderBox;
                                            final Offset inkWellPosition =
                                                inkWellBox.localToGlobal(
                                                    Offset.zero,
                                                    ancestor: overlay);

                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                  screenWidth * 0.05,
                                                  screenHeight * 0.35,
                                                  screenWidth * 0.95,
                                                  screenHeight *
                                                      0.65 // Adjust as needed
                                                  ),
                                              items: [
                                                PopupMenuItem(
                                                  onTap: () {
                                                    _sortCenters(
                                                        'Distance', true);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      'Distance' == _sortField
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_checked_rounded,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0))
                                                          : Icon(
                                                              Icons
                                                                  .circle_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: const Text(
                                                            'Distance'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {
                                                    _sortCenters(
                                                        'Rating', false);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      'Rating' != _sortField
                                                          ? Icon(
                                                              Icons
                                                                  .circle_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0))
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked_rounded,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0)),
                                                      Padding(
                                                        child: const Text(
                                                            'Rating'),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      'Relevance' != _sortField
                                                          ? Icon(
                                                              Icons
                                                                  .circle_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0))
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked_rounded,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0)),
                                                      Padding(
                                                        child: const Text(
                                                            'Relevance'),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      'Price' != _sortField
                                                          ? Icon(
                                                              Icons
                                                                  .circle_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0))
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_checked_rounded,
                                                              size: 15,
                                                              color: Color(
                                                                  0xFF7D23E0)),
                                                      Padding(
                                                        child:
                                                            const Text('Price'),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Sort',
                                                  style: TextStyle(
                                                      color: Color(0xFF7D23E0)),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: Color(0xFF7D23E0),
                                                  size: 17,
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Color(0xFF7D23E0))),
                                        child: InkWell(
                                          onTap: () {
                                            final RenderBox overlay =
                                                Overlay.of(context)
                                                        .context
                                                        .findRenderObject()
                                                    as RenderBox;
                                            final RenderBox inkWellBox =
                                                context.findRenderObject()
                                                    as RenderBox;
                                            final Offset inkWellPosition =
                                                inkWellBox.localToGlobal(
                                                    Offset.zero,
                                                    ancestor: overlay);

                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                  screenWidth * 0.35,
                                                  screenHeight * 0.35,
                                                  screenWidth * 0.65,
                                                  screenHeight *
                                                      0.65 // Adjust as needed
                                                  ),
                                              items: [
                                                for (final tag in _tags)
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      _selectTag(tag);
                                                    },
                                                    child: Text(tag),
                                                  )
                                              ],
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Filter',
                                                  style: TextStyle(
                                                      color: Color(0xFF7D23E0)),
                                                ),
                                                Icon(
                                                  Icons.tune_rounded,
                                                  color: Color(0xFF7D23E0),
                                                  size: 17,
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    for (final tag in _tags)
                                      if (!_selectedTags.contains(tag))
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.02),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Color(0xFF7D23E0))),
                                            child: InkWell(
                                              onTap: () {
                                                _selectTag(tag);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      tag,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF7D23E0)),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.02),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(0xFF7D23E0)),
                                            child: InkWell(
                                              onTap: () {
                                                _selectTag(tag);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      tag,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (final center in _firstCenters)
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.02),
                          child: CenterCard(
                              center['Colleagues'],
                              center['Name'],
                              center['Rating'],
                              center['Distance'].toDouble(),
                              center['Image'],
                              center['Discount'],
                              center['Tags'],
                              center['Location'])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/image2.png',
                              width: screenWidth * 0.2,
                            ),
                            Container(
                              width: screenWidth * 0.45,
                              child: Text(
                                'Having a tough time navigating through your career roadmap?',
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF7D23E0),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenHeight * 0.01),
                                child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ask Ostello',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ],
                        )),
                    for (final center in _secondCenters)
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.02),
                          child: CenterCard(
                              center['Colleagues'],
                              center['Name'],
                              center['Rating'],
                              center['Distance'].toDouble(),
                              center['Image'],
                              center['Discount'],
                              center['Tags'],
                              center['Location'])),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class BottomDialog extends StatefulWidget {
  final Function(String) callback;

  BottomDialog({required this.callback});

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  BottomDialog get widgetInstance => widget;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () {
              _listen();
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: Text(
              _text,
              style: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widgetInstance.callback(_text);
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
