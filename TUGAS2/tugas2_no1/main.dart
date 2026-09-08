void main() {
  
  final Map<String, Map<String, dynamic>> mahasiswa = {
    'mahasiswa1': {
      'nama': 'Budi Santoso',
      'nilai': [85, 90, 78, 92, 88],
      'absensi': 1,
    },
    'mahasiswa2': {
      'nama': 'Siti Rahayu',
      'nilai': [55, 60, 58, 52, 45],
      'absensi': 2,
    },
    'mahasiswa3': {
      'nama': 'Andi Pratama',
      'nilai': [75, 80, 70, 85, 78],
      'absensi': 1,
    },
    'mahasiswa4': {
      'nama': 'Dewi Lestari',
      'nilai': [90, 85, 95, 88, 92],
      'absensi': 0,
    },
    'mahasiswa5': {
      'nama': 'Rizky Ramadhan',
      'nilai': [65, 70, 58, 62, 60],
      'absensi': 4,
    },
  };

  // List untuk menyimpan seluruh nilai ujian.
  final List<int> semuaNilai = [];

  // List untuk menyimpan rata-rata setiap mahasiswa.
  final List<double> semuaRataRata = [];

  // Menampilkan judul laporan.
  print('=== LAPORAN NILAI MAHASISWA ===');

  // Mengolah data mahasiswa satu per satu.
  for (final data in mahasiswa.values) {
    // Mengambil nama mahasiswa dari Map.
    final String nama = data['nama'] as String;

    // Mengambil nilai mahasiswa sebagai List<int>.
    final List<int> nilai = List<int>.from(
      data['nilai'] as List,
    );

    // Mengambil jumlah absensi mahasiswa.
    final int absensi = data['absensi'] as int;

    // Menghitung rata-rata nilai mahasiswa.
    final double rataRata = hitungRataRata(nilai);

    // Menentukan grade berdasarkan rata-rata.
    final String grade = tentukanGrade(rataRata);

    // Mengecek status kelulusan mahasiswa.
    final bool lulus = cekKelulusan(
      rataRata: rataRata,
      absensi: absensi,
    );

    // Menambahkan nilai mahasiswa ke data kelas.
    semuaNilai.addAll(nilai);

    // Menambahkan rata-rata mahasiswa ke data kelas.
    semuaRataRata.add(rataRata);

    // Menampilkan laporan lengkap mahasiswa.
    print('Nama : $nama');
    print('Nilai : $nilai');
    print('Rata-rata: ${rataRata.toStringAsFixed(1)}');
    print('Grade : $grade');
    print('Status : ${lulus ? 'LULUS' : 'TIDAK LULUS'}');
    print('');
  }

  // Mencari nilai tertinggi dari seluruh nilai ujian.
  final int nilaiTertinggi = semuaNilai.reduce(
    (nilaiPertama, nilaiKedua) {
      return nilaiPertama > nilaiKedua
          ? nilaiPertama
          : nilaiKedua;
    },
  );

  // Mencari nilai terendah dari seluruh nilai ujian.
  final int nilaiTerendah = semuaNilai.reduce(
    (nilaiPertama, nilaiKedua) {
      return nilaiPertama < nilaiKedua
          ? nilaiPertama
          : nilaiKedua;
    },
  );

  // Menghitung rata-rata kelas.
  //
  // Rata-rata kelas dihitung dari rata-rata setiap mahasiswa.
  final double rataRataKelas =
      semuaRataRata.reduce(
        (total, rataRataMahasiswa) {
          return total + rataRataMahasiswa;
        },
      ) /
      semuaRataRata.length;

  // Menampilkan statistik kelas.
  print('=== STATISTIK KELAS ===');
  print('Nilai Tertinggi : $nilaiTertinggi');
  print('Nilai Terendah : $nilaiTerendah');
  print('Rata-rata Kelas : ${rataRataKelas.toStringAsFixed(1)}');
}


// Fungsi untuk menghitung rata-rata nilai.
double hitungRataRata(List<int> nilai) {
  // Jika List kosong, kembalikan 0.0.
  
  if (nilai.isEmpty) {
    return 0.0;
  }

  // Menjumlahkan semua nilai dalam List.
  final int total = nilai.reduce(
    (nilaiPertama, nilaiKedua) {
      return nilaiPertama + nilaiKedua;
    },
  );

  // Mengembalikan hasil rata-rata.
  return total / nilai.length;
}


// Fungsi untuk menentukan grade.
String tentukanGrade(double rataRata) {
  if (rataRata >= 80) {
    return 'A';
  } else if (rataRata >= 70) {
    return 'B';
  } else if (rataRata >= 60) {
    return 'C';
  } else if (rataRata >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}


// Fungsi untuk menentukan kelulusan.
bool cekKelulusan({
  required double rataRata,
  required int absensi,
}) {
  // Operator && berarti "dan".

  return rataRata >= 60 && absensi <= 3;
}