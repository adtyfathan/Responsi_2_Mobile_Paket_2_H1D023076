class Item {
  final int id;
  final String nama;
  final int harga;
  final int jumlah;
  final String tanggalMasuk;
  final String tanggalKedaluwarsa;

  Item({
    required this.id,
    required this.nama,
    required this.harga,
    required this.jumlah,
    required this.tanggalMasuk,
    required this.tanggalKedaluwarsa,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      jumlah: json['jumlah'],
      tanggalMasuk: json['tanggal_masuk'],
      tanggalKedaluwarsa: json['tanggal_kedaluwarsa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
      'tanggal_kedaluwarsa': tanggalKedaluwarsa,
    };
  }
}
