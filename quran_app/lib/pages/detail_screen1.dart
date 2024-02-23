import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/viewmodel/ayah_viewmodel.dart';

class DetailScreen1 extends StatefulWidget {
  static const routeName = 'detail_screen';
  final String id_surah;
  const DetailScreen1({super.key, required this.id_surah});

  @override
  State<DetailScreen1> createState() => _DetailScreen1State();
}

class _DetailScreen1State extends State<DetailScreen1> {
  late final AudioPlayer _player;
  late bool _isAudioLoaded;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _isAudioLoaded = false;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: AyahViewModel().getListAyah(widget.id_surah),
      builder: (context, AsyncSnapshot<AyahModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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

  Widget _itemList({required BuildContext context, required Ayat ayat}) =>
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/svg/nomor_surah.svg'),
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
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ayat.ar.toString(),
                      style: GoogleFonts.amiriQuran(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 2.5,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ayat.tr.toString(),
                        style: GoogleFonts.amiri(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

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
                      } else if (processingState != ProcessingState.completed) {
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
}
