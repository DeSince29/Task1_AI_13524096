% Batas Peta 11x11
map_limit(11, 11).

% Koordinat Tembok
wall(2, 2). wall(2, 5). wall(2, 7). wall(2, 10).
wall(3, 3). wall(3, 5). wall(3, 7). wall(3, 9).

is_wall(X, Y) :- wall(X, Y).

% Pengecekan event saat menginjak ubin
check_tile(6, 6) :- 
    write('Kamu berada di Basecamp (B). Ketik "mix(Item1, Item2)." untuk meracik.'), nl, !.
check_tile(X, Y) :-
    item_at(X, Y, Item),
    format('Ada elemen [~w] di bawahmu! Ketik "take." untuk mengambil.', [Item]), nl, !.
check_tile(_, _) :- true.

% Visualisasi Peta
map :-
    write('=== PETA EXPLODATION ==='), nl,
    loop_y(1), % Memulai perulangan dari baris Y = 1
    write('========================'), nl,
    write('Keterangan: P = Pemain, B = Basecamp, # = Tembok, * = Item'), nl, !.

% Loop untuk Sumbu Y
loop_y(12) :- !.
loop_y(Y) :-
    loop_x(1, Y),
    nl,
    NY is Y + 1,
    loop_y(NY).

% Loop untuk Sumbu X
loop_x(12, _) :- !.
loop_x(X, Y) :-
    cetak_simbol(X, Y),
    write(' '),
    NX is X + 1,
    loop_x(NX, Y).

% Penentuan Simbol
cetak_simbol(X, Y) :- player_pos(X, Y), write('P'), !.
cetak_simbol(X, Y) :- is_wall(X, Y), write('#'), !.
cetak_simbol(6, 6) :- write('B'), !.
cetak_simbol(X, Y) :- item_at(X, Y, _), write('*'), !.
cetak_simbol(_, _) :- write('-'). % Petak kosong