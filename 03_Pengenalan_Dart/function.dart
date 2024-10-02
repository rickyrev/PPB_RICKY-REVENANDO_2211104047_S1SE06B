// 8. Fungsi
void cetakPesan(String pesan) {
  print(pesan); // Mencetak pesan
}

int perkalian(int a, int b) {
  return a * b;
}

// Fungsi dipanggil untuk cetak output
void main() {
  int hasil = perkalian(5, 7);
  print("Hasil perkalian fungsi : $hasil");

  cetakPesan("Halo, Guys!");
}
