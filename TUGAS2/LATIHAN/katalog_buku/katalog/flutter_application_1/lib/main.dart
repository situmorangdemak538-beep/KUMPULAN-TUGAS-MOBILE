import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= DATA BUKU =================
List<Map<String, dynamic>> buku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahunTerbit': 2005,
    'rating': 4.8,
    'tersedia': true,
    'genre': 'Novel',
    'catatan': null,
  },
  {
    'judul': 'Bumi Manusia',
    'pengarang': 'Pramoedya Ananta Toer',
    'tahunTerbit': 1980,
    'rating': 4.7,
    'tersedia': false,
    'genre': 'Sejarah',
    'catatan': 'Dikembalikan minggu depan',
  },
  {
    'judul': 'Belajar Flutter',
    'pengarang': 'Andi Wijaya',
    'tahunTerbit': 2024,
    'rating': 4.6,
    'tersedia': true,
    'genre': 'Teknologi',
    'catatan': null,
  },
  {
    'judul': 'Pemrograman Dart',
    'pengarang': 'Rizky Pratama',
    'tahunTerbit': 2023,
    'rating': 4.2,
    'tersedia': true,
    'genre': 'Teknologi',
    'catatan': null,
  },
  {
    'judul': 'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahunTerbit': 2009,
    'rating': 4.3,
    'tersedia': false,
    'genre': 'Novel',
    'catatan': 'Sedang dipinjam',
  },
  {
    'judul': 'Sejarah Indonesia',
    'pengarang': 'M. Yamin',
    'tahunTerbit': 2019,
    'rating': 3.4,
    'tersedia': true,
    'genre': 'Sejarah',
    'catatan': null,
  },
];

// ================= FUNGSI =================
String kategoriRating(double rating) {
  if (rating > 4.5) {
    return 'Sangat Baik';
  } else if (rating > 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

// ================= APLIKASI =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const KatalogPage(),
    );
  }
}

// ================= HALAMAN UTAMA =================
class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {
    // Set untuk genre unik
    Set<String> genre = buku
        .map((b) => b['genre'] as String)
        .toSet();

    // Filter menggunakan .where()
    List<Map<String, dynamic>> hasil = buku.where((b) {
      return b['judul']
          .toString()
          .toLowerCase()
          .contains(pencarian.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📚 Katalog Buku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // ================= SEARCH =================
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  pencarian = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari judul buku...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          // ================= GENRE =================
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Genre Buku',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Wrap(
            spacing: 8,
            children: genre.map((g) {
              return Chip(
                label: Text(g),
                avatar: const Icon(Icons.book, size: 18),
              );
            }).toList(),
          ),

          const SizedBox(height: 5),

          // ================= DAFTAR BUKU =================
          Expanded(
            child: hasil.isEmpty
                ? const Center(
                    child: Text('Buku tidak ditemukan'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: hasil.length,
                    itemBuilder: (context, index) {
                      final b = hasil[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),

                          leading: const Icon(
                            Icons.menu_book,
                            size: 40,
                            color: Colors.indigo,
                          ),

                          title: Text(
                            b['judul'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(b['pengarang']),
                              Text(
                                'Tahun: ${b['tahunTerbit']}',
                              ),
                              Text(
                                '⭐ ${b['rating']} - '
                                '${kategoriRating(b['rating'])}',
                              ),

                              const SizedBox(height: 5),

                              // Ternary
                              Text(
                                b['tersedia']
                                    ? '🟢 Tersedia'
                                    : '🔴 Dipinjam',
                                style: TextStyle(
                                  color: b['tersedia']
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(buku: b),
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
}

// ================= HALAMAN DETAIL =================
class DetailPage extends StatefulWidget {
  final Map<String, dynamic> buku;

  const DetailPage({
    super.key,
    required this.buku,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  // Nullable String
  String? catatanPeminjam;

  @override
  void initState() {
    super.initState();
    catatanPeminjam =
        widget.buku['catatan'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.buku;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Center(
              child: Icon(
                Icons.menu_book,
                size: 100,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              b['judul'],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text('Pengarang: ${b['pengarang']}'),
            Text('Tahun Terbit: ${b['tahunTerbit']}'),
            Text('Genre: ${b['genre']}'),
            Text('Rating: ⭐ ${b['rating']}'),
            Text(
              'Kategori: ${kategoriRating(b['rating'])}',
            ),

            const SizedBox(height: 15),

            Text(
              b['tersedia']
                  ? '🟢 Tersedia'
                  : '🔴 Dipinjam',
              style: TextStyle(
                color: b['tersedia']
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Catatan Peminjam:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 8),

            // Operator ??
            Text(
              catatanPeminjam ??
                  'Tidak ada catatan',
            ),
          ],
        ),
      ),
    );
  }
}