
// 1. CUSTOM EXCEPTION

// Error jika stok produk habis
class StokHabisException implements Exception {
  String pesan;

  StokHabisException(this.pesan);

  @override
  String toString() {
    return pesan;
  }
}

// Error jika produk tidak ditemukan
class ProdukTidakAda implements Exception {
  String pesan;

  ProdukTidakAda(this.pesan);

  @override
  String toString() {
    return pesan;
  }
}

// 2. ABSTRACT CLASS PRODUK

abstract class Produk {
  String id;
  String nama;
  double harga;
  int stok;
  Produk(this.id, this.nama, this.harga, this.stok);

  // Abstract method.
  String deskripsi();
}

// 3. MIXIN BISA DISKON

mixin BisaDiskon {

  // Menghitung harga setelah diskon
  double hitungHargaDiskon(double persen) {

    return hargaProduk - (hargaProduk * persen / 100);
  }

  // Validasi diskon
  bool validasiDiskon(double persen) {

    // Diskon harus lebih dari 0 dan maksimal 100
    if (persen > 0 && persen <= 100) {
      return true;
    }

    return false;
  }

  // Harga produk yang digunakan oleh mixin
  double get hargaProduk;
}

// 4. PRODUK DIGITAL

class ProdukDigital extends Produk with BisaDiskon {

  // Properti tambahan sesuai soal
  double ukuranMB;
  String formatFile;

  ProdukDigital(
    String id,
    String nama,
    double harga,
    int stok,
    this.ukuranMB,
    this.formatFile,
  ) : super(id, nama, harga, stok);

  // Implementasi abstract method deskripsi()
  @override
  String deskripsi() {

    return 'Produk Digital | Ukuran: $ukuranMB MB | Format: $formatFile';
  }

  // Mengambil harga dari Produk
  @override
  double get hargaProduk {
    return harga;
  }
}

// 5. PRODUK FISIK

class ProdukFisik extends Produk with BisaDiskon {

  // Properti tambahan sesuai soal
  int beratGram;
  String dimensi;

  ProdukFisik(
    String id,
    String nama,
    double harga,
    int stok,
    this.beratGram,
    this.dimensi,
  ) : super(id, nama, harga, stok);

  // Implementasi abstract method deskripsi()
  @override
  String deskripsi() {

    return 'Produk Fisik | Berat: $beratGram gram | Dimensi: $dimensi';
  }

  // Mengambil harga dari Produk
  @override
  double get hargaProduk {
    return harga;
  }
}

// 6. CLASS KERANJANG

class Keranjang {

  // List untuk menyimpan produk
  List<Produk> daftarProduk = [];

  // Method tambah()

  void tambah(Produk produk) {

    // Cek apakah stok habis
    if (produk.stok <= 0) {
      throw StokHabisException(
        'Stok ${produk.nama} habis!',
      );
    }

    // Tambahkan produk ke keranjang
    daftarProduk.add(produk);

    // Kurangi stok
    produk.stok--;

    print('${produk.nama} berhasil ditambahkan.');
  }

  // Method hapus()

  void hapus(String nama) {

    // Mencari posisi produk berdasarkan nama
    int index = daftarProduk.indexWhere(
      (produk) => produk.nama.toLowerCase() == nama.toLowerCase(),
    );

    // Jika produk tidak ditemukan
    if (index == -1) {
      throw ProdukTidakAda(
        'Produk $nama tidak ada di keranjang!',
      );
    }

    // Ambil produk
    Produk produk = daftarProduk[index];

    // Kembalikan stok
    produk.stok++;

    // Hapus produk dari keranjang
    daftarProduk.removeAt(index);

    print('$nama berhasil dihapus.');
  }

  double totalHarga() {

    double total = 0;

    for (Produk produk in daftarProduk) {
      total += produk.harga;
    }

    return total;
  }
}

// 7. CLASS TOKO SERVICE

class TokoService {

  List<Produk> daftarProduk;

  TokoService(this.daftarProduk);

  // cariProduk()

  Future<Produk> cariProduk(String nama) async {

    await Future.delayed(
      Duration(seconds: 1),
    );

    for (Produk produk in daftarProduk) {

      if (produk.nama.toLowerCase() == nama.toLowerCase()) {
        return produk;
      }
    }

    // Jika tidak ditemukan
    throw ProdukTidakAda(
      'Produk "$nama" tidak ditemukan!',
    );
  }

  // prosesCheckout()

  Future<void> prosesCheckout(Keranjang keranjang) async {

    await Future.delayed(
      Duration(seconds: 1),
    );

    if (keranjang.daftarProduk.isEmpty) {
      throw ProdukTidakAda(
        'Keranjang masih kosong!',
      );
    }

    print('\nCheckout berhasil!');
    print(
      'Total pembayaran: Rp ${keranjang.totalHarga().toStringAsFixed(0)}',
    );
  }
}

// 8. MAIN

Future<void> main() async {

  print('==========================================');
  print('          TOKO ONLINE SEDERHANA');
  print('==========================================');

  // Membuat produk digital

  ProdukDigital ebook = ProdukDigital(
    'D001',
    'Belajar Dart',
    75000,
    5,
    10.5,
    'PDF',
  );

  // Membuat produk fisik

  ProdukFisik laptop = ProdukFisik(
    'F001',
    'Laptop ASUS',
    8000000,
    3,
    1500,
    '35 x 23 x 2 cm',
  );


  ProdukFisik mouse = ProdukFisik(
    'F002',
    'Mouse Logitech',
    300000,
    5,
    100,
    '11 x 6 x 4 cm',
  );

  // Membuat List produk toko

  List<Produk> produkToko = [
    ebook,
    laptop,
    mouse,
  ];

  TokoService toko = TokoService(produkToko);

  // MENAMPILKAN PRODUK

  print('\n========== DAFTAR PRODUK ==========');

  for (Produk produk in produkToko) {

    print('\nID       : ${produk.id}');
    print('Nama     : ${produk.nama}');
    print('Harga    : Rp ${produk.harga.toStringAsFixed(0)}');
    print('Stok     : ${produk.stok}');
    print('Deskripsi: ${produk.deskripsi()}');
  }

  // MENGGUNAKAN MIXIN DISKON

  print('\n========== DISKON ==========');

  double persenDiskon = 10;

  try {

    if (laptop.validasiDiskon(persenDiskon)) {

      double hargaBaru =
          laptop.hitungHargaDiskon(persenDiskon);

      print('Produk        : ${laptop.nama}');
      print('Harga awal    : Rp ${laptop.harga.toStringAsFixed(0)}');
      print('Diskon        : $persenDiskon%');
      print('Harga diskon  : Rp ${hargaBaru.toStringAsFixed(0)}');

    } else {

      print('Diskon tidak valid.');
    }

  } catch (e) {

    print('Error diskon: $e');
  }

  // MENCARI PRODUK
  // Menggunakan async/await + try/catch

  print('\n========== CARI PRODUK ==========');

  try {

    Produk hasil = await toko.cariProduk('Laptop ASUS');

    print('Produk ditemukan: ${hasil.nama}');

  } catch (e) {

    print('Error: $e');
  }
  // MEMBUAT KERANJANG

  print('\n========== KERANJANG ==========');

  Keranjang keranjang = Keranjang();

  try {

    keranjang.tambah(laptop);

  } catch (e) {

    print('Error: $e');
  }

  try {

    keranjang.tambah(mouse);

  } catch (e) {

    print('Error: $e');
  }

  print('\nIsi keranjang:');

  for (Produk produk in keranjang.daftarProduk) {

    print('- ${produk.nama}');
  }

  print(
    'Total: Rp ${keranjang.totalHarga().toStringAsFixed(0)}',
  );

  // HAPUS PRODUK

  print('\n========== HAPUS PRODUK ==========');

  try {

    keranjang.hapus('Mouse Logitech');

  } catch (e) {

    print('Error: $e');
  }

  // CHECKOUT

  print('\n========== CHECKOUT ==========');

  try {

    await toko.prosesCheckout(keranjang);

  } catch (e) {

    print('Error checkout: $e');
  }

  // TEST PRODUK TIDAK DITEMUKAN
  // Untuk membuktikan Custom Exception bekerja.

  print('\n========== TEST ERROR ==========');

  try {

    await toko.cariProduk('Kamera Canon');

  } catch (e) {

    print('Error: $e');
  }


  print('\n==========================================');
  print('             PROGRAM SELESAI');
  print('==========================================');
}