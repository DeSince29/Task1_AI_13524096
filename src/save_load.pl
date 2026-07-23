save :-
    open('savegame.txt', write, Stream),
    
    player_pos(X, Y), format(Stream, 'player_pos(~w, ~w).~n', [X, Y]),
    player_stamina(S), format(Stream, 'player_stamina(~w).~n', [S]),
    player_hp(H), format(Stream, 'player_hp(~w).~n', [H]),
    inventory(Inv), format(Stream, 'inventory(~w).~n', [Inv]),
    
    % Untuk item_at, gunakan fail-driven loop
    (item_at(IX, IY, Item), format(Stream, 'item_at(~w, ~w, ~w).~n', [IX, IY, Item]), fail ; true),
    
    close(Stream),
    write('Progress permainan berhasil disimpan ke savegame.txt!'), nl, !.

load :-
    catch(open('savegame.txt', read, Stream), _, (write('Gagal: Tidak ada file savegame.txt!'), nl, fail)),
    
    % Kosongkan state dinamis yang sedang berjalan
    retractall(player_pos(_, _)),
    retractall(player_stamina(_)),
    retractall(player_hp(_)),
    retractall(inventory(_)),
    retractall(item_at(_, _, _)),
    
    load_loop(Stream),
    close(Stream),
    write('Progress permainan berhasil dimuat!'), nl,
    player_pos(PX, PY), check_tile(PX, PY), !.

% Loop untuk membaca file hingga EOF
load_loop(Stream) :-
    read(Stream, Term),
    ( Term == end_of_file -> true
    ; assertz(Term), load_loop(Stream)
    ).