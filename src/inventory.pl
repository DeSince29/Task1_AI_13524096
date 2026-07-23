take :-
    player_pos(X, Y), item_at(X, Y, Item),
    inventory(Inv), length(Inv, Len), Len < 6, !,
    retract(item_at(X, Y, Item)),
    append(Inv, [Item], NewInv),
    retract(inventory(Inv)), asserta(inventory(NewInv)),
    format('Berhasil mengambil [~w].~n', [Item]).
take :-
    write('Gagal: Tidak ada item di sini atau tas penuh!'), nl, fail.

status :-
    player_hp(HP), player_stamina(S), inventory(Inv),
    format('=== STATUS ===~nNyawa: ~w | Stamina: ~w~nTas: ~w~n==============~n', [HP, S, Inv]).