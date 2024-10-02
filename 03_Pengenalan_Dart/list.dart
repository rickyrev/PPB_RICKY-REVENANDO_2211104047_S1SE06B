// List Statement
void main() {
  // // 6. Fixed-Length List
  // // Membuat fixed-length list dengan panjang 3
  // List<int> fixedList = List.filled(3, 0); // List dengan 3 elemen, semua diinisialisasi ke 0

  // // Mengubah elemen dalam list
  // fixedList[0] = 10;
  // fixedList[1] = 20;
  // fixedList[2] = 30;

  // print('Fixed Length List: $fixedList'); // Output: [10, 20, 0, 0, 0]

  // // Menambah atau menghapus elemen tidak diperbolehkan
  // // fixedList.add(30);  // Ini akan menimbulkan error
  // // fixedList.removeAt(0); // Ini juga akan menimbulkan error

  // 7. Growable List
  List<int> growableList = [];

  growableList.add(10);
  growableList.add(20);
  growableList.add(30);
  growableList.add(40);
  growableList.add(50);
  growableList.add(60);

  print("List awal : $growableList");

  growableList.remove(20);
  print("List setelah 20 dihilangkan : $growableList");
}
