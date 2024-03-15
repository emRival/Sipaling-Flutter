import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/pages/DetailScreenRetry.dart';
import 'package:quran_app/pages/bookmark/bookmark_util.dart';

import 'package:quran_app/viewmodel/ayah_viewmodel.dart';

class DetailScreen1 extends StatefulWidget {
  static const routeName = 'detail_screen';
  final String id_surah;
  final Key? refreshKey; // Parameter tambahan untuk memuat ulang halaman

  const DetailScreen1({required this.id_surah, this.refreshKey})
      : super(key: refreshKey);

  @override
  State<DetailScreen1> createState() => _DetailScreen1State();
}

class _DetailScreen1State extends State<DetailScreen1> {
  late Future<AyahModel> _ayahModelFuture;
  late final AudioPlayer _player;
  late bool _isAudioLoaded;

  late double _arrfontSize;
  bool _latinCheck = true;
  bool _terjemahCheck = true;

  @override
  void initState() {
    super.initState();
    _arrfontSize = 20.0;
    _loadData(); // Panggil _loadData() di sini
    _player = AudioPlayer();
    _isAudioLoaded = false;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _loadData() {
    setState(() {
      _ayahModelFuture = AyahViewModel().getListAyah(widget.id_surah);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(child: _buildBody()),
    );
  }

  AppBar _appBar() => AppBar(
        elevation: 0,
        title: FutureBuilder(
          future: _ayahModelFuture,
          builder: (context, AsyncSnapshot<AyahModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Icon(Icons
                  .all_inclusive_rounded); // Placeholder text ketika data masih dimuat
            } else if (snapshot.hasData) {
              final ayahModel = snapshot.data!;
              return Text(
                ayahModel.nama.toString(),
                style: GoogleFonts.amiriQuran(),
              ); // Tampilkan namaLatin pada AppBar
            } else {
              return const Text(
                  'Detail Screen'); // Default text jika tidak ada data
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showSettingDialog(context);
            },
            icon: const Icon(Icons.settings, color: Colors.grey),
          ),
        ],
      );

  Widget _buildBody() {
    return FutureBuilder(
      future: _ayahModelFuture,
      builder: (context, AsyncSnapshot<AyahModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return DetailScreenRetry(onRetry: _loadData);
        } else if (snapshot.hasData) {
          final ayahModel = snapshot.data!;
          final link = ayahModel.audio.toString();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _banner(ayat: ayahModel, link: link),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => _itemList(
                    context: context,
                    ayat: ayahModel.ayat![index],
                    surah: snapshot.data!,
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.1),
                    height: 1,
                  ),
                  itemCount: ayahModel.ayat!.length,
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _itemList({
    required BuildContext context,
    required Ayat ayat,
    required AyahModel surah,
  }) {
    final bookmarksBox = Hive.box('bookmarks_quran');
    final String bookmarkKey = '${ayat.surah}_${ayat.nomor}';
    final bool bookmarkExists = bookmarksBox.containsKey(bookmarkKey);

    return InkWell(
      onLongPress: () {
        _showLongPressOptionsDialog(
            context, surah, ayat.nomor!, ayat, bookmarkExists, bookmarkKey);
      },
      child: Container(
        color: _getColorForLastReadItem(ayat, surah),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildNumberIcon(bookmarkExists, ayat),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildArabicText(ayat),
                  const SizedBox(height: 15),
                  _latinCheck ? _buildLatinText(ayat) : const SizedBox.shrink(),
                  _terjemahCheck
                      ? _buildTerjemahText(ayat)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForLastReadItem(Ayat ayat, AyahModel surah) {
    final lastReadBox = Hive.box('last_read_quran');
    final int? lastReadSurahId = lastReadBox.get('last_read')?['id'];
    final int? lastReadAyatNumber = lastReadBox.get('last_read')?['nomor_ayat'];
    final bool isLastRead =
        lastReadSurahId == surah.nomor && lastReadAyatNumber == ayat.nomor;

    return isLastRead ? Colors.yellow : Colors.transparent;
  }

  Widget _buildNumberIcon(bool bookmarkExists, Ayat ayat) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/nomor_surah.svg',
          color: bookmarkExists ? Colors.green : Colors.purple,
        ),
        SizedBox(
          height: 36,
          width: 36,
          child: Center(
            child: Text(
              ayat.nomor.toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildArabicText(Ayat ayat) {
    return Text(
      ayat.ar.toString(),
      style: GoogleFonts.amiriQuran(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: _arrfontSize.toDouble(),
        height: 2.5,
      ),
      textAlign: TextAlign.end,
    );
  }

  Widget _buildLatinText(Ayat ayat) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      child: Text(
        ayat.tr.toString(),
        style: GoogleFonts.amiri(
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.w300,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildTerjemahText(Ayat ayat) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      child: Text(
        ayat.idn.toString(),
        textAlign: TextAlign.justify,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 11,
        ),
      ),
    );
  }

  Stack _banner({required AyahModel ayat, required String link}) => Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffdf98fa), Color(0xff9055ff)],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            bottom: 0,
            child: Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff9055ff),
                      Color(0xffdf98fa),
                    ],
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    var connectivityResult =
                        await Connectivity().checkConnectivity();

                    if (connectivityResult == ConnectivityResult.none) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      // Tampilkan Snackbar jika tidak ada koneksi internet
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tidak ada koneksi internet.'),
                          backgroundColor: Colors.red,
                        ),
                      );

                      if (_player.playing) {
                        _player.pause();
                      } else {
                        _player.play();
                      }
                      return;
                    }

                    if (!_isAudioLoaded) {
                      await _setupAudioPlayer(link: link);
                      _isAudioLoaded = true;
                    }

                    if (_player.playing) {
                      _player.pause();
                    } else {
                      _player.play();
                    }
                  },
                  icon: StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final processingState = snapshot.data?.processingState;
                      final playing = snapshot.data?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else if (playing != true) {
                        return const Icon(Icons.play_arrow,
                            size: 30, color: Colors.white);
                      } else if (processingState != ProcessingState.completed &&
                          _isAudioLoaded == true) {
                        return const Icon(Icons.pause,
                            size: 30, color: Colors.white);
                      } else {
                        return const Icon(Icons.replay,
                            size: 30, color: Colors.white);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/book.svg'),
                    const SizedBox(width: 10),
                    Text(
                      ayat.nama.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  ayat.namaLatin.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ayat.arti.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Future<void> _setupAudioPlayer({required String link}) async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stacktrace) {
      print("A Stream Error Occurred: $e");
    });
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(link)));
    } catch (e) {
      print("Error Loading Audio Source: $e");
    }
  }

  void _showLongPressOptionsDialog(BuildContext context, AyahModel surah,
      int ayat, Ayat ayah, bool bookmarkCheck, String bookmarkKey) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Save Last Read'),
              onTap: () {
                // Tindakan ketika opsi "Bagikan" dipilih
                _saveLastRead(surah, ayat);
                Navigator.of(context).pop();
                // Lakukan sesuatu...
              },
            ),
            ListTile(
              leading: bookmarkCheck
                  ? const Icon(Icons.bookmark_remove)
                  : const Icon(Icons.bookmark_add),
              title: bookmarkCheck
                  ? const Text('Delete Bookmark')
                  : const Text('Save Bookmark'),
              onTap: bookmarkCheck
                  ? () {
                      deleteBookmark(context, bookmarkKey);
                      Navigator.of(context).pop();
                    }
                  : () {
                      saveBookmark(context, ayah, surah);
                      Navigator.of(context).pop();
                    },
            )
          ],
        );
      },
    );
  }

  void _saveLastRead(AyahModel surah, int ayat) {
    final lastReadBox = Hive.box('last_read_quran');

    // Check if the data already exists
    if (lastReadBox.containsKey('last_read')) {
      // If it exists, get the current data
      final Map<dynamic, dynamic>? currentData = lastReadBox.get('last_read');

      // Update the relevant fields with the new data
      currentData?['id'] = surah.nomor;
      currentData?['nama_surah'] = surah.namaLatin;
      currentData?['nomor_ayat'] = ayat;

      // Put the updated data back into the box
      lastReadBox.put('last_read', currentData);
    } else {
      // If the data does not exist, create a new entry
      Map<dynamic, dynamic> lastReadData = {
        "id": surah.nomor,
        "nama_surah": surah.namaLatin,
        "nomor_ayat": ayat,
      };

      lastReadBox.put('last_read', lastReadData);
    }
  }

  void _updateFontSize(double value) {
    setState(() {
      _arrfontSize = value;
    });
  }

  void _updateLatinCheck(bool value) {
    setState(() {
      _latinCheck = value;
    });
  }

  void _updateTerjemahCheck(bool value) {
    setState(() {
      _terjemahCheck = value;
    });
  }

  void _showSettingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Font Size: ${_arrfontSize.toInt()}"),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.format_size,
                        size: 18, // Ukuran ikon kecil
                      ),
                      Expanded(
                        child: Slider(
                          value: _arrfontSize,
                          min: 16.0,
                          max: 30.0,
                          divisions: 100,
                          onChanged: (double value) {
                            setState(() {
                              _updateFontSize(value);
                            });
                          },
                        ),
                      ),
                      const Icon(
                        Icons.format_size,
                        size: 25, // Ukuran ikon besar
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Text("Checkbox List"),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text('Latin'),
                          value: _latinCheck,
                          onChanged: (newValue) {
                            setState(() {
                              _updateLatinCheck(newValue!);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text('Terjemah'),
                          value: _terjemahCheck,
                          onChanged: (newValue) {
                            setState(() {
                              _updateTerjemahCheck(newValue!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
