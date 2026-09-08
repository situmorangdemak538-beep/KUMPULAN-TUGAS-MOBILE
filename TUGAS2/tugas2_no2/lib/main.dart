import 'package:flutter/material.dart';

final List<Map<String, dynamic>> daftarBuku = [

  // BUKU 1
  {
    'judul': 'Laskar Pelangi',       
    'pengarang': 'Andrea Hirata',    
    'tahunTerbit': 2005,              
    'rating': 4.8,                   
    'tersedia': true,                
    'genre': 'Novel',
  },

  // BUKU 2
  {
    'judul': 'Bumi',
    'pengarang': 'Tere Liye',
    'tahunTerbit': 2014,
    'rating': 4.5,
    'tersedia': true,
    'genre': 'Fantasi',
  },

  // BUKU 3
  {
    'judul': 'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahunTerbit': 2009,
    'rating': 4.2,
    'tersedia': false,
    'genre': 'Novel',
  },

  // BUKU 4
  {
    'judul': 'Filosofi Kopi',
    'pengarang': 'Dee Lestari',
    'tahunTerbit': 2006,
    'rating': 3.8,
    'tersedia': true,
    'genre': 'Cerpen',
  },

  // BUKU 5
  {
    'judul': 'Dilan 1990',
    'pengarang': 'Pidi Baiq',
    'tahunTerbit': 2014,
    'rating': 3.9,
    'tersedia': false,
    'genre': 'Romansa',
  },

  // BUKU 6
  {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahunTerbit': 2018,
    'rating': 4.7,
    'tersedia': true,
    'genre': 'Pengembangan Diri',
  },
];

// 2. FUNGSI kategoriRating()

String kategoriRating(double rating) {

  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

// 3. FUNGSI formatRating()

String formatRating(double rating) {
  return '${rating.toStringAsFixed(1)} / 5.0';
}

// 4. SET UNTUK GENRE

Set<String> ambilGenreUnik() {

  // Membuat Set kosong untuk menyimpan genre
  Set<String> genreUnik = {};

  // for = mengulang semua data buku
  for (var buku in daftarBuku) {

    // add = menambahkan data ke Set
    genreUnik.add(buku['genre']);
  }

  // return = mengembalikan hasil
  return genreUnik;
}

// 5. PROGRAM UTAMA

void main() {
  runApp(const PerpustakaanApp());
}

// 6. WIDGET UTAMA

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      // Menghilangkan tulisan DEBUG di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // Nama aplikasi
      title: 'Perpustakaan Mini',

      // Halaman pertama yang dibuka
      home: const HalamanUtama(),
    );
  }
}

// 7. HALAMAN UTAMA

class HalamanUtama extends StatefulWidget {

  const HalamanUtama({super.key});

  @override

  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {

  // CONTROLLER PENCARIAN

  final TextEditingController searchController =
      TextEditingController();

  String kataPencarian = '';


  @override
  Widget build(BuildContext context) {

    // FILTER BUKU

    List<Map<String, dynamic>> bukuHasilFilter =
        daftarBuku.where((buku) {

      String judul =
          buku['judul'].toString().toLowerCase();

      return judul.contains(
        kataPencarian.toLowerCase(),
      );

    }).toList();


    // Mengambil genre yang unik
    Set<String> genreUnik = ambilGenreUnik();

    // SCAFFOLD

    return Scaffold(

      // APPBAR
  
      appBar: AppBar(
        title: const Text('📚 Perpustakaan Mini'),
      ),

      // BODY

      body: Column(
        children: [

          // TEXTFIELD PENCARIAN

          Padding(
            // padding = memberikan jarak di sekitar widget
            padding: const EdgeInsets.all(12),

            child: TextField(

              // controller = menghubungkan TextField
              // dengan searchController
              controller: searchController,


              // onChanged = dijalankan setiap kali
              // isi TextField berubah.
              onChanged: (value) {

                // setState() = memberi tahu Flutter
                // bahwa data berubah dan tampilan
                // harus diperbarui.

                setState(() {

                  // Menyimpan teks yang diketik
                  kataPencarian = value;
                });
              },


              // decoration = mengatur tampilan TextField
              decoration: InputDecoration(

                // Tulisan label
                labelText: 'Cari judul buku',

                // Contoh tulisan di dalam TextField
                hintText: 'Contoh: Laskar Pelangi',

                // Icon pencarian
                prefixIcon: const Icon(Icons.search),

                // Membuat garis kotak pada TextField
                border: OutlineInputBorder(

                  // Membuat sudut kotak menjadi bulat
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // DAFTAR GENRE

          // SizedBox = memberi ukuran tertentu
          SizedBox(
            height: 45,

            child: Wrap(

              // spacing = jarak antar item
              spacing: 8,

              children: genreUnik.map((genre) {

                return Chip(
                  label: Text(genre),
                );

              // toList() = mengubah hasil map menjadi List
              }).toList(),
            ),
          ),


          // Memberikan jarak 10 pixel
          const SizedBox(height: 10),

          // DAFTAR BUKU
  
          Expanded(
            child: ListView.builder(

              itemCount: bukuHasilFilter.length,

              itemBuilder: (context, index) {

                final buku = bukuHasilFilter[index];

                // CARD

                return Card(

                  // margin = jarak Card dengan widget lain
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),


                  child: ListTile(

                    // leading = widget yang berada di sebelah kiri
                    leading: const CircleAvatar(
                      child: Icon(Icons.book),
                    ),

                    // JUDUL BUKU

                    title: Text(
                      buku['judul'],

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // DETAIL BUKu

                    subtitle: Column(

                      // Membuat teks dimulai dari kiri
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        // Pengarang
                        Text(
                          'Pengarang: ${buku['pengarang']}',
                        ),

                        // Tahun terbit
                        Text(
                          'Tahun: ${buku['tahunTerbit']}',
                        ),

                        // Rating
                        Text(
                          'Rating: ${formatRating(buku['rating'])}',
                        ),

                        // Kategori rating
                        Text(
                          'Kategori: ${kategoriRating(buku['rating'])}',
                        ),

                        // Genre
                        Text(
                          'Genre: ${buku['genre']}',
                        ),


                        const SizedBox(height: 5),

                        // STATUS BUKU

                        Container(

                          // Jarak di dalam Container
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),


                          decoration: BoxDecoration(

                            // Jika true → hijau
                            // Jika false → merah

                            color: buku['tersedia']
                                ? Colors.green
                                : Colors.red,

                            // Membuat sudut menjadi bulat
                            borderRadius:
                                BorderRadius.circular(20),
                          ),


                          child: Text(

                            buku['tersedia']
                                ? 'Tersedia'
                                : 'Dipinjam',

                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // KETIKA BUKU DIKLIK

                    onTap: () {

                      // Navigator = mengatur perpindahan halaman

                      Navigator.push(
                        context,

                        // MaterialPageRoute = membuat perpindahan ke halaman baru.

                        MaterialPageRoute(
                          builder: (context) {

                            // Membuka halaman detail
                            // dan mengirim data buku.

                            return HalamanDetail(
                              buku: buku,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // DISPOSE


  @override
  void dispose() {

    // Menghapus searchController dari memori
    searchController.dispose();

    super.dispose();
  }
}

// 8. HALAMAN DETAIL BUKU

class HalamanDetail extends StatefulWidget {

  // Menyimpan data buku yang dikirim dari halaman utama

  final Map<String, dynamic> buku;


  // required = data buku WAJIB dikirim
  const HalamanDetail({
    super.key,
    required this.buku,
  });


  @override
  State<HalamanDetail> createState() =>
      _HalamanDetailState();
}


// State untuk halaman detail
class _HalamanDetailState extends State<HalamanDetail> {

  // NULL SAFETY

  String? catatanPeminjam;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // APPBAR

      appBar: AppBar(
        title: const Text('Detail Buku'),
      ),

      // BODY

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // JUDUL

            Text(
              widget.buku['judul'],

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),


            // Pengarang
            Text(
              'Pengarang : ${widget.buku['pengarang']}',
            ),

            // Tahun terbit
            Text(
              'Tahun Terbit : ${widget.buku['tahunTerbit']}',
            ),

            // Rating
            Text(
              'Rating : ${widget.buku['rating']}',
            ),

            // Genre
            Text(
              'Genre : ${widget.buku['genre']}',
            ),


            const SizedBox(height: 20),

            // OPERATOR ??

            Text(
              'Catatan Peminjam: '
              '${catatanPeminjam ?? "(Tidak ada catatan)"}',
            ),


            const SizedBox(height: 20),

            // TOMBOL

            ElevatedButton(

              // onPressed = kode yang dijalankan
              // ketika tombol ditekan.

              onPressed: () {

                // setState = memberi tahu Flutter
                // bahwa data berubah.

                setState(() {

                  // Sekarang catatanPeminjam
                  // memiliki nilai.

                  catatanPeminjam =
                      'Buku sedang dipinjam';
                });
              },


              child: const Text(
                'Tambah Catatan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}