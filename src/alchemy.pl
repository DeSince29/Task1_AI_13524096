% Buku Resep Alchemy
recipe(water, earth, vine_trap).
recipe(water, water, healing_dew).
recipe(fire, earth, magma_flask).

% Menghapus item pertama yang cocok dari List
del_item(X, [X|T], T) :- !.
del_item(X, [Y|T], [Y|T1]) :- del_item(X, T, T1).

mix(I1, I2) :-
    player_pos(6, 6), % Syarat: Harus di Basecamp
    inventory(Inv),
    del_item(I1, Inv, TempInv),   
    del_item(I2, TempInv, Sisa),  
    (recipe(I1, I2, Hasil) ; recipe(I2, I1, Hasil)), !, 
    append(Sisa, [Hasil], NewInv),
    retract(inventory(Inv)), asserta(inventory(NewInv)),
    format('Sintesis Berhasil! Kamu meracik [~w].~n', [Hasil]).
mix(_, _) :-
    write('Gagal: Kamu harus berada di Basecamp dan membawa elemen yang benar.'), nl, fail.