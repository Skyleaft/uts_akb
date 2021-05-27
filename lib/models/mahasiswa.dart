final String tableMahasiswa = 'mahasiswa';

class MahasiswaFields {
  static final List<String> values = [id, nim, namaLengkap, kelas, prodi];

  static final String id = '_id';
  static final String nim = 'nim';
  static final String namaLengkap = 'namaLengkap';
  static final String kelas = 'kelas';
  static final String prodi = 'prodi';
}

class Mahasiswa {
  final int id;
  final String nim;
  final String namaLengkap;
  final String kelas;
  final String prodi;

  const Mahasiswa({
    this.id,
    this.nim,
    this.namaLengkap,
    this.kelas,
    this.prodi,
  });

  Mahasiswa copy({
    int id,
    String nim,
    String namaLengkap,
    String kelas,
    String prodi,
  }) =>
      Mahasiswa(
        id: id ?? this.id,
        nim: nim ?? this.nim,
        namaLengkap: namaLengkap ?? this.namaLengkap,
        kelas: kelas ?? this.kelas,
        prodi: prodi ?? this.prodi,
      );

  static Mahasiswa fromJson(Map<String, Object> json) => Mahasiswa(
        id: json[MahasiswaFields.id] as int,
        nim: json[MahasiswaFields.nim] as String,
        namaLengkap: json[MahasiswaFields.namaLengkap] as String,
        kelas: json[MahasiswaFields.kelas] as String,
        prodi: json[MahasiswaFields.prodi] as String,
      );

  Map<String, Object> toJson() => {
        MahasiswaFields.id: id,
        MahasiswaFields.nim: nim,
        MahasiswaFields.namaLengkap: namaLengkap,
        MahasiswaFields.kelas: kelas,
        MahasiswaFields.prodi: prodi,
      };
}
