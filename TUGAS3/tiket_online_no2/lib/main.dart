import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTiket());
}


// CUSTOM EXCEPTION


class TiketHabisException implements Exception {
  final String pesan;

  TiketHabisException(this.pesan);

  @override
  String toString() => pesan;
}

// ============================================================
// ABSTRACT CLASS
// ============================================================

abstract class Tiket {
  final String nama;
  final double harga;

  Tiket({
    required this.nama,
    required this.harga,
  });

  String deskripsi();

  String formatRupiah(double nilai) {
    final angka = nilai.toInt().toString();
    final hasil = angka.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    );

    return 'Rp$hasil';
  }
}

// MIXIN

mixin BisaDiskon on Tiket {
  double hitungHargaDiskon(double persen) {
    return harga - (harga * persen / 100);
  }

  bool validasiDiskon() {
    return harga > 0;
  }
}

// SUBCLASS 1


class TiketEkonomi extends Tiket {
  final String fasilitas;

  TiketEkonomi({
    required super.nama,
    required super.harga,
    required this.fasilitas,
  });

  @override
  String deskripsi() {
    return 'Tiket dengan fasilitas standar dan harga terjangkau.';
  }
}

// SUBCLASS 2


class TiketVIP extends Tiket with BisaDiskon {
  final String fasilitas;

  TiketVIP({
    required super.nama,
    required super.harga,
    required this.fasilitas,
  });

  @override
  String deskripsi() {
    return 'Tiket VIP dengan fasilitas premium dan tempat duduk '
        'yang lebih nyaman.';
  }
}


// FUTURE - MENGAMBIL DAFTAR TIKET


Future<List<Tiket>> ambilDaftarTiket() async {
  await Future.delayed(const Duration(seconds: 2));

  return [
    TiketEkonomi(
      nama: 'Tiket Ekonomi',
      harga: 180000,
      fasilitas: 'Fasilitas standar',
    ),
    TiketEkonomi(
      nama: 'Tiket Ekonomi Premium',
      harga: 250000,
      fasilitas: 'Fasilitas lebih nyaman',
    ),
    TiketVIP(
      nama: 'Tiket VIP',
      harga: 300000,
      fasilitas: 'Fasilitas premium',
    ),
    TiketVIP(
      nama: 'Tiket VIP Premium',
      harga: 500000,
      fasilitas: 'Fasilitas terbaik',
    ),
  ];
}


// FUTURE - PESAN TIKET


Future<String> pesanTiket(Tiket tiket) async {
  await Future.delayed(const Duration(seconds: 3));

  final random = Random();

  // Simulasi kemungkinan tiket habis.
  if (random.nextInt(4) == 0) {
    throw TiketHabisException(
      'Maaf, tiket saat ini sedang habis.',
    );
  }

  return 'Pemesanan ${tiket.nama} berhasil diproses.';
}


// APLIKASI

class AplikasiTiket extends StatelessWidget {
  const AplikasiTiket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiket Perjalanan',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6425D0),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}


// SPLASH SCREEN


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HalamanDaftarTiket(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF251266),
              Color(0xFF4320A2),
              Color(0xFF24105C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 105,
                height: 105,
                decoration: BoxDecoration(
                  color: const Color(0xFF5C2DB8),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: const Icon(
                  Icons.flight,
                  color: Colors.white,
                  size: 58,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'TIKET PERJALANAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Temukan perjalanan impianmu\nbersama kami!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _titik(false),
                  const SizedBox(width: 8),
                  _titik(true),
                  const SizedBox(width: 8),
                  _titik(false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titik(bool aktif) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: aktif ? Colors.white : Colors.white54,
      ),
    );
  }
}

// ============================================================
// HALAMAN DAFTAR TIKET
// ============================================================

class HalamanDaftarTiket extends StatefulWidget {
  const HalamanDaftarTiket({super.key});

  @override
  State<HalamanDaftarTiket> createState() =>
      _HalamanDaftarTiketState();
}

class _HalamanDaftarTiketState
    extends State<HalamanDaftarTiket> {
  late Future<List<Tiket>> daftarTiket;

  @override
  void initState() {
    super.initState();
    daftarTiket = ambilDaftarTiket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: const Icon(
          Icons.menu,
          color: Color(0xFF5B25C5),
        ),

        title: const Text(
          'Daftar Tiket',
          style: TextStyle(
            color: Color(0xFF25212A),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications_none,
              color: Color(0xFF6425D0),
            ),
          ),
        ],
      ),

      // FutureBuilder untuk loading, error, dan data.
      body: FutureBuilder<List<Tiket>>(
        future: daftarTiket,

        builder: (context, snapshot) {
         
          // LOADING
       

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const HalamanLoading();
          }

      
          // ERROR
   

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Gagal mengambil data tiket.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        daftarTiket = ambilDaftarTiket();
                      });
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

        
          // DATA
         

          final data = snapshot.data ?? [];

          return IsiDaftarTiket(tiket: data);
        },
      ),
    );
  }
}


// HALAMAN LOADING


class HalamanLoading extends StatelessWidget {
  const HalamanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 18, 22, 8),
          child: CountdownPromo(),
        ),

        const Spacer(),

        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE5FF),
            borderRadius: BorderRadius.circular(27),
          ),
          child: const Icon(
            Icons.business_center,
            color: Color(0xFF7135D2),
            size: 60,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Sedang mengambil\ndata tiket...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 25),

        const SizedBox(
          width: 140,
          child: LinearProgressIndicator(
            minHeight: 7,
          ),
        ),

        const Spacer(),
      ],
    );
  }
}


// ISI DAFTAR


class IsiDaftarTiket extends StatelessWidget {
  final List<Tiket> tiket;

  const IsiDaftarTiket({
    super.key,
    required this.tiket,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 17, 22, 10),
          child: CountdownPromo(),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 25),
            itemCount: tiket.length,

            itemBuilder: (context, index) {
              return KartuTiket(
                tiket: tiket[index],
              );
            },
          ),
        ),
      ],
    );
  }
}


// STREAMBUILDER COUNTDOWN


class CountdownPromo extends StatefulWidget {
  const CountdownPromo({super.key});

  @override
  State<CountdownPromo> createState() =>
      _CountdownPromoState();
}

class _CountdownPromoState
    extends State<CountdownPromo> {
  late Stream<int> streamCountdown;

  @override
  void initState() {
    super.initState();

    streamCountdown = Stream.periodic(
      const Duration(seconds: 1),
      (nilai) => 30 - nilai - 1,
    ).take(31);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: streamCountdown,
      initialData: 30,

      builder: (context, snapshot) {
        final waktu = snapshot.data ?? 0;

        final menit = waktu ~/ 60;
        final detik = waktu % 60;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: const Color(0xFFD9F1DB),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFA7DCA9),
            ),
          ),

          child: Row(
            children: [
              const Icon(
                Icons.access_alarm,
                color: Color(0xFF43AD4B),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Waktu tersisa promo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

              Text(
                '$menit'.padLeft(2, '0'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                ' : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '$detik'.padLeft(2, '0'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


// KARTU TIKET


class KartuTiket extends StatelessWidget {
  final Tiket tiket;

  const KartuTiket({
    super.key,
    required this.tiket,
  });

  @override
  Widget build(BuildContext context) {
    final bool vip = tiket is TiketVIP;

    final TiketVIP? tiketVIP = vip
        ? tiket as TiketVIP
        : null;

    final String fasilitas;

    if (tiket is TiketVIP) {
      fasilitas = tiketVIP!.fasilitas;
    } else {
      fasilitas = (tiket as TiketEkonomi).fasilitas;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: vip
            ? Border.all(
                color: const Color(0xFFD9BFFF),
              )
            : null,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(13),

        child: Row(
          children: [
       
            // IKON PESAWAT / VIP
          

            Container(
              width: 57,
              height: 57,

              decoration: BoxDecoration(
                color: vip
                    ? const Color(0xFFFFF0C7)
                    : const Color(0xFFEDE5FF),
                borderRadius: BorderRadius.circular(14),
              ),

              child: Icon(
                vip
                    ? Icons.workspace_premium
                    : Icons.flight,

                color: vip
                    ? const Color(0xFFFF9D00)
                    : const Color(0xFF6730D2),

                size: 30,
              ),
            ),

            const SizedBox(width: 13),

     
            // INFORMASI
        

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    tiket.nama,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Harga: ${tiket.formatRupiah(tiket.harga)}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    fasilitas,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF88828A),
                    ),
                  ),

                  if (vip) ...[
                    const SizedBox(height: 4),

                    Text(
                      'Promo 10%: '
                      '${tiket.formatRupiah(tiketVIP!.hitungHargaDiskon(10))}',
                      style: const TextStyle(
                        color: Color(0xFF2BAE3C),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 7),

            // ==========================================
            // TOMBOL PESAN
            // ==========================================

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HalamanPemesanan(
                      tiket: tiket,
                    ),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                elevation: 2,

                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 12,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              child: const Text(
                'Pesan',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN PEMESANAN
// ============================================================

class HalamanPemesanan extends StatefulWidget {
  final Tiket tiket;

  const HalamanPemesanan({
    super.key,
    required this.tiket,
  });

  @override
  State<HalamanPemesanan> createState() =>
      _HalamanPemesananState();
}

class _HalamanPemesananState
    extends State<HalamanPemesanan> {
  bool sedangMemesan = false;
  bool berhasil = false;
  String? hasilPesanan;

  @override
  Widget build(BuildContext context) {
    // ==========================================
    // PROSES PEMESANAN
    // ==========================================

    if (sedangMemesan) {
      return const HalamanProsesPemesanan();
    }

    // ==========================================
    // HASIL PESANAN
    // ==========================================

    if (hasilPesanan != null) {
      return HalamanHasilPesanan(
        berhasil: berhasil,
        pesan: hasilPesanan!,

        onCobaLagi: () {
          setState(() {
            hasilPesanan = null;
            berhasil = false;
          });
        },

        onKembali: () {
          Navigator.pop(context);
        },
      );
    }

    final bool vip = widget.tiket is TiketVIP;

    final TiketVIP? tiketVIP = vip
        ? widget.tiket as TiketVIP
        : null;

    final double hargaPromo = vip
        ? tiketVIP!.hitungHargaDiskon(10)
        : widget.tiket.harga;

    String fasilitas;

    if (vip) {
      fasilitas = tiketVIP!.fasilitas;
    } else {
      fasilitas =
          (widget.tiket as TiketEkonomi).fasilitas;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
          ),
        ),

        title: const Text(
          'Pemesanan Tiket',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 17),
            child: Icon(
              Icons.favorite,
              color: Color(0xFFE91E63),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          21,
          27,
          21,
          30,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==========================================
            // HEADER
            // ==========================================

            Row(
              children: [
                Container(
                  width: 73,
                  height: 73,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF682BD0),
                  ),

                  child: Icon(
                    vip
                        ? Icons.workspace_premium
                        : Icons.flight,
                    color: Colors.white,
                    size: 35,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        widget.tiket.nama,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        fasilitas,
                        style: const TextStyle(
                          color: Color(0xFF817A84),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ==========================================
            // HARGA
            // ==========================================

            if (vip)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE0CBFF),
                  ),
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Harga Asli'),
                        ),

                        Text(
                          widget.tiket.formatRupiah(
                            widget.tiket.harga,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Diskon (10%)',
                            style: TextStyle(
                              color: Color(0xFF28A83A),
                            ),
                          ),
                        ),

                        Text(
                          '-${widget.tiket.formatRupiah(
                            widget.tiket.harga * 0.10,
                          )}',
                          style: const TextStyle(
                            color: Color(0xFF28A83A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF6E9FF),
                        borderRadius:
                            BorderRadius.circular(9),
                      ),

                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Harga Promo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Text(
                            widget.tiket.formatRupiah(
                              hargaPromo,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF571BB7),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE0CBFF),
                  ),
                ),

                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Harga Tiket',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Text(
                      widget.tiket.formatRupiah(
                        widget.tiket.harga,
                      ),
                      style: const TextStyle(
                        color: Color(0xFF571BB7),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // ==========================================
            // DESKRIPSI
            // ==========================================

            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              widget.tiket.deskripsi(),
              style: const TextStyle(
                fontSize: 14,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              vip
                  ? 'Nikmati perjalanan premium dengan fasilitas terbaik.'
                  : 'Nikmati perjalanan dengan fasilitas standar.',
              style: const TextStyle(
                color: Color(0xFF817B83),
                fontSize: 14,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 35),

            // ==========================================
            // TOMBOL KONFIRMASI
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                onPressed: prosesPesanan,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6223D0),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  'Konfirmasi Pesanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROSES PESANAN
  // ==========================================================

  Future<void> prosesPesanan() async {
    setState(() {
      sedangMemesan = true;
    });

    try {
      final hasil = await pesanTiket(widget.tiket);

      if (!mounted) return;

      setState(() {
        hasilPesanan = hasil;
        berhasil = true;
      });
    } on TiketHabisException catch (error) {
      if (!mounted) return;

      setState(() {
        hasilPesanan = error.toString();
        berhasil = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        hasilPesanan =
            'Terjadi kesalahan saat memesan tiket.';
        berhasil = false;
      });
    } finally {
      if (!mounted) return;

      setState(() {
        sedangMemesan = false;
      });
    }
  }
}

// ============================================================
// HALAMAN PROSES PEMESANAN
// ============================================================

class HalamanProsesPemesanan extends StatelessWidget {
  const HalamanProsesPemesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: const Icon(
          Icons.arrow_back,
        ),

        title: const Text(
          'Pemesanan Tiket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            SizedBox(
              width: 62,
              height: 62,

              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: Color(0xFF682BD0),
              ),
            ),

            SizedBox(height: 28),

            Text(
              'Memproses pemesanan...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Mohon tunggu sebentar',
              style: TextStyle(
                color: Color(0xFF77727A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN HASIL
// ============================================================

class HalamanHasilPesanan extends StatelessWidget {
  final bool berhasil;
  final String pesan;
  final VoidCallback onCobaLagi;
  final VoidCallback onKembali;

  const HalamanHasilPesanan({
    super.key,
    required this.berhasil,
    required this.pesan,
    required this.onCobaLagi,
    required this.onKembali,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: onKembali,
          icon: const Icon(Icons.arrow_back),
        ),

        title: const Text(
          'Pemesanan Tiket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              // ==========================================
              // ICON HASIL
              // ==========================================

              Container(
                width: 88,
                height: 88,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: berhasil
                      ? const Color(0xFF21B957)
                      : const Color(0xFFFF3038),
                ),

                child: Icon(
                  berhasil
                      ? Icons.check
                      : Icons.close,

                  color: Colors.white,
                  size: 55,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                berhasil ? 'Berhasil!' : 'Gagal!',

                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,

                  color: berhasil
                      ? const Color(0xFF1BA848)
                      : const Color(0xFFFF3038),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                pesan,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed:
                      berhasil ? onKembali : onCobaLagi,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: berhasil
                        ? const Color(0xFF20B957)
                        : const Color(0xFFFF3038),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(9),
                    ),
                  ),

                  child: Text(
                    berhasil
                        ? 'Kembali ke Daftar Tiket'
                        : 'Coba Lagi',

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}