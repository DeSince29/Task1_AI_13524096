# Explodation! - Proof of Concept (PoC)

Repositori ini berisi *Proof of Concept* (PoC) untuk permainan **Explodation!**, sebuah *text-based logic game* yang dikembangkan menggunakan **GNU Prolog**.

---

## Struktur Direktori
Proyek ini dipecah menjadi beberapa modul spesifik:
*   `main.pl` - *Entry point* yang memuat seluruh modul dan inisialisasi awal.
*   `state.pl` - Manajemen memori dan deklarasi fakta dinamis (*player, map states*).
*   `map.pl` - Data spasial statis (tembok) dan algoritma visualisasi peta 2D.
*   `movement.pl` - Logika pergerakan kartesian dan sistem *stamina*.
*   `inventory.pl` - Manajemen kapasitas tas (*list*) dan aksi memungut barang.
*   `alchemy.pl` - Basis pengetahuan (*knowledge base*) resep dan manipulasi *list* rekursif.
*   `save_load.pl` - Sistem *I/O Stream* untuk menyimpan dan memuat *progress*.

---

## Implementasi Konsep Prolog

Spesifikasi mewajibkan implementasi konsep utama. Berikut adalah pembuktian implementasinya di dalam kode:

### 1. Rekurens (Recursion)
Digunakan secara ekstensif pada sistem **Alchemy** untuk menelusuri isi tas dan menghapus bahan baku yang spesifik.
**Cuplikan Kode (`alchemy.pl`):**
```prolog
% Menghapus item X pertama yang ditemukan di dalam List
del_item(X, [X|T], T) :- !.
del_item(X, [Y|T], [Y|T1]) :- del_item(X, T, T1).
```

### 2. List
Digunakan sebagai struktur data dinamis untuk menyimpan barang bawaan pemain di dalam fakta `inventory/1`.
**Cuplikan Kode (`inventory.pl`):**
```prolog
take :-
    player_pos(X, Y), item_at(X, Y, Item),
    inventory(Inv), length(Inv, Len), Len < 6, !,
    retract(item_at(X, Y, Item)),
    append(Inv, [Item], NewInv), % Manipulasi List
    retract(inventory(Inv)), asserta(inventory(NewInv)),
    format('Berhasil mengambil [~w].~n', [Item]).
```

### 3. Cut (`!`)
Digunakan untuk melakukan *pruning* (memotong pencarian kemungkinan lain) pada validasi pergerakan agar program lebih efisien.
**Cuplikan Kode (`movement.pl`):**
```prolog
move(DX, DY) :-
    player_pos(X, Y),
    NX is X + DX, NY is Y + DY,
    is_wall(NX, NY), !, % Cut: Berhenti mencari aturan move/2 lainnya
    write('Gagal: Jalan tertutup tembok!'), nl, fail.
```

### 4. Fail
Digunakan bersama *Cut* untuk memaksa predikat gagal (*fail*) dan membatalkan aksi apabila kondisi ilegal (seperti menabrak rintangan atau lelah) terpenuhi.
**Cuplikan Kode (`movement.pl`):**
```prolog
move(_, _) :-
    player_stamina(S), S =< 0, !,
    write('Gagal: Kamu terlalu lelah, stamina habis!'), nl, fail. % Membatalkan perpindahan
```

### 5. Loop (Iterasi)
Karena game berjalan *native*, syarat perulangan (*loop*) diimplementasikan pada algoritma pengecekan grid koordinat secara sekuensial saat merender peta 2D ke layar.
**Cuplikan Kode (`map.pl`):**
```prolog
% Tail Recursion Loop untuk mencetak baris peta (Sumbu Y)
loop_y(12) :- !. % Basis
loop_y(Y) :-
    loop_x(1, Y), % Memanggil nested loop untuk kolom
    nl,           
    NY is Y + 1,
    loop_y(NY).   % Iterasi
```

### 6. File Processing
Diimplementasikan untuk sistem *Save/Load* dengan memanfaatkan *I/O Stream* standar.
**Cuplikan Kode (`save_load.pl`):**
```prolog
save :-
    open('savegame.txt', write, Stream), % Membuka akses file
    player_pos(X, Y), 
    format(Stream, 'player_pos(~w, ~w).~n', [X, Y]), % Menulis ke file
    % (menulis fakta lainnya...)
    close(Stream), % Menutup akses
    write('Progress tersimpan!'), nl, !.
```

---

## 🎮 Panduan Demonstrasi (Cara Bermain)

Untuk mengevaluasi kelengkapan fitur permainan, Anda dapat mengikuti *Walkthrough* berikut ini di terminal komputer lokal Anda.

### Prasyarat:
Pastikan **GNU Prolog (gprolog)** telah terinstal dan terdaftar dalam sistem PATH komputer Anda.

### Langkah Eksekusi:
1. Buka terminal (CMD/PowerShell) dan arahkan ke direktori proyek ini.
2. Ketik `gprolog` lalu tekan Enter.
3. Muat file utama dengan mengetikkan:
   ```prolog
   | ?- [main].
   ```
4. Mulai inisialisasi awal permainan:
   ```prolog
   | ?- start.
   ```

### Skenario Uji Coba (Bermain Langsung dari Prompt):
Ketikan urutan perintah berikut ini:

1. **Cek Peta dan Status Awal**
   ```prolog
   | ?- map.
   | ?- status.
   ```
2. **Berjalan dan Mengambil Item (Water & Earth)**
   ```prolog
   | ?- a.
   | ?- a.
   | ?- take.
   | ?- d.
   | ?- d.
   | ?- d.
   | ?- d.
   | ?- take.
   ```
3. **Kembali ke Basecamp & Meracik Item (Alkimia)**
   ```prolog
   | ?- a.
   | ?- a.
   | ?- mix(water, earth).
   | ?- status.
   ```
4. **Menguji File Processing (Save & Load)**
   ```prolog
   | ?- save.
   | ?- start.  % Mereset permainan ke hari-1
   | ?- status. % Buktikan tas kosong kembali
   | ?- load.
   | ?- status. % Buktikan Vine Trap dan posisi sebelumnya kembali
   ```
5. **Keluar dari Permainan**
   ```prolog
   | ?- halt.
   ```