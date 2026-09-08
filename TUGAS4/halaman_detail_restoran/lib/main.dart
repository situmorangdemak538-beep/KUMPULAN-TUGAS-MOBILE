import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRestoran());
}

// =====================================================
// APLIKASI UTAMA
// =====================================================

class AplikasiRestoran extends StatelessWidget {
  const AplikasiRestoran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detail Restoran',

      // Tema aplikasi
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF168B6B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAF9),
      ),

      home: const HalamanDetailRestoran(),
    );
  }
}

// =====================================================
// HALAMAN DETAIL RESTORAN
// =====================================================

class HalamanDetailRestoran extends StatelessWidget {
  const HalamanDetailRestoran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // Tombol kembali
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),

        // Judul
        title: const Text(
          'Nusantara Rasa',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Tombol share
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Link restoran berhasil dibagikan',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),

      // =================================================
      // TOMBOL RESERVASI
      // =================================================

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Reservasi berhasil dipilih!',
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF128C70),
        foregroundColor: Colors.white,
        icon: const Icon(
          Icons.calendar_month_outlined,
        ),
        label: const Text(
          'Reservasi Sekarang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =================================================
      // ISI HALAMAN
      // =================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =================================================
            // GAMBAR RESTORAN
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 245,
              child: Image.network(
                'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=80',

                fit: BoxFit.cover,

                // Jika gambar gagal dimuat
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 70,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // =================================================
            // INFORMASI RESTORAN
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                15,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // Nama restoran
                  const Text(
                    'Nusantara Rasa',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rating
                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFB400),
                        size: 19,
                      ),

                      const SizedBox(width: 5),

                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        '(1.250 ulasan)',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Kategori
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xFFE4F5EE),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        child: const Text(
                          'Indonesia',
                          style: TextStyle(
                            color: Color(0xFF128C70),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  // Alamat
                  Row(
                    children: [

                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          'Jl. Sudirman No. 25, Jakarta Selatan',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // =================================================
            // STATISTIK RESTORAN
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.symmetric(
                  vertical: 17,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15),

                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),

                child: Row(
                  children: [

                    Expanded(
                      child: StatistikRestoran(
                        icon: Icons.near_me_outlined,
                        nilai: '2.5 km',
                        label: 'Jarak',
                      ),
                    ),

                    Container(
                      height: 42,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),

                    Expanded(
                      child: StatistikRestoran(
                        icon: Icons.access_time,
                        nilai: '10.00 - 22.00',
                        label: 'Waktu Buka',
                      ),
                    ),

                    Container(
                      height: 42,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),

                    Expanded(
                      child: StatistikRestoran(
                        icon: Icons.payments_outlined,
                        nilai: 'Rp100.000',
                        label: 'Harga Rata-rata',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // TENTANG RESTORAN
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15),

                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Tentang Restoran',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Nusantara Rasa menghadirkan pengalaman '
                      'bersantap dengan cita rasa khas Indonesia. '
                      'Kami menyediakan berbagai macam makanan '
                      'tradisional dan modern dengan bahan-bahan '
                      'segar serta pilihan menu yang beragam.',

                      maxLines: 4,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Selengkapnya ↓',
                      style: TextStyle(
                        color: const Color(0xFF128C70),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // =================================================
            // JUDUL MENU POPULER
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    'Menu Populer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Lihat Semua  ›',
                    style: TextStyle(
                      color: const Color(0xFF128C70),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 13),

            // =================================================
            // DAFTAR MENU
            // =================================================

            SizedBox(
              height: 215,

              child: ListView(
                scrollDirection:
                    Axis.horizontal,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                children: const [

                  // MENU 1
                  KartuMenu(
                    nama: 'Sate Maranggi',
                    harga: 'Rp45.000',
                    gambar:
                        'https://images.unsplash.com/photo-1529563021893-cc83c992d75d?auto=format&fit=crop&w=500&q=80',
                  ),

                  SizedBox(width: 12),

                  // MENU 2
                  KartuMenu(
                    nama: 'Nasi Goreng',
                    harga: 'Rp35.000',
                    gambar:
                        'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=500&q=80',
                  ),

                  SizedBox(width: 12),

                  // MENU 3
                  KartuMenu(
                    nama: 'Ikan Bakar',
                    harga: 'Rp55.000',
                    gambar:
                        'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?auto=format&fit=crop&w=500&q=80',
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

// =====================================================
// WIDGET STATISTIK RESTORAN
// =====================================================

class StatistikRestoran extends StatelessWidget {
  final IconData icon;
  final String nilai;
  final String label;

  const StatistikRestoran({
    super.key,
    required this.icon,
    required this.nilai,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 17,
              color: const Color(0xFF168B6B),
            ),

            const SizedBox(width: 5),

            Flexible(
              child: Text(
                nilai,

                textAlign:
                    TextAlign.center,

                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          label,

          textAlign:
              TextAlign.center,

          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// =====================================================
// KARTU MENU MAKANAN
// =====================================================
//
// StatefulWidget digunakan karena tombol Love
// harus bisa berubah ketika diklik.
//
// =====================================================

class KartuMenu extends StatefulWidget {
  final String nama;
  final String harga;
  final String gambar;

  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.gambar,
  });

  @override
  State<KartuMenu> createState() =>
      _KartuMenuState();
}

// =====================================================
// STATE KARTU MENU
// =====================================================

class _KartuMenuState extends State<KartuMenu> {

  // Menyimpan kondisi makanan disukai atau tidak
  bool disukai = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 155,

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15),
        ),

        elevation: 2,

        clipBehavior:
            Clip.antiAlias,

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =================================================
            // GAMBAR + TOMBOL LOVE
            // =================================================

            SizedBox(
              height: 120,

              child: Stack(
                children: [

                  // Gambar makanan
                  Positioned.fill(
                    child: Image.network(
                      widget.gambar,

                      fit: BoxFit.cover,

                      // Jika gambar gagal
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          color: Colors.grey.shade300,

                          child: const Center(
                            child: Icon(
                              Icons.fastfood,
                              size: 45,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // =================================================
                  // TOMBOL LOVE
                  // =================================================

                  Positioned(
                    top: 8,
                    right: 8,

                    child: GestureDetector(
                      onTap: () {

                        // Mengubah status Love
                        setState(() {
                          disukai = !disukai;
                        });

                        // Menampilkan pesan
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            duration:
                                const Duration(
                              milliseconds: 1200,
                            ),

                            content: Text(
                              disukai
                                  ? '${widget.nama} ditambahkan ke favorit ❤️'
                                  : '${widget.nama} dihapus dari favorit',
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: 34,
                        height: 34,

                        decoration:
                            const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          // Jika disukai tampil Love penuh
                          // Jika belum disukai tampil Love kosong
                          disukai
                              ? Icons.favorite
                              : Icons.favorite_border,

                          size: 19,

                          color: disukai
                              ? Colors.red
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // NAMA DAN HARGA MAKANAN
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                8,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    widget.nama,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    widget.harga,

                    style: const TextStyle(
                      color: Color(0xFF128C70),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
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