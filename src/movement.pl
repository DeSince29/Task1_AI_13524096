move(DX, DY) :-
    player_pos(X, Y),
    NX is X + DX, NY is Y + DY,
    % Validasi Batas Peta
    (NX < 1 ; NX > 11 ; NY < 1 ; NY > 11), !,
    write('Gagal: Kamu menabrak batas labirin!'), nl, fail.

move(DX, DY) :-
    player_pos(X, Y),
    NX is X + DX, NY is Y + DY,
    % Validasi Tembok
    is_wall(NX, NY), !,
    write('Gagal: Jalan tertutup tembok!'), nl, fail.

move(_, _) :-
    player_stamina(S), S =< 0, !,
    write('Gagal: Kamu kelelahan, stamina habis!'), nl, fail.

move(DX, DY) :-
    player_pos(X, Y), player_stamina(S),
    NX is X + DX, NY is Y + DY,
    % Eksekusi Pindah
    NS is S - 1,
    retract(player_stamina(S)), asserta(player_stamina(NS)),
    retract(player_pos(X, Y)), asserta(player_pos(NX, NY)),
    format('Kamu melangkah. (Posisi: ~w,~w | Stamina: ~w)~n', [NX, NY, NS]),
    check_tile(NX, NY), !.

% Command Pergerakan 
w :- move(0, -1).
s :- move(0, 1).
a :- move(-1, 0).
d :- move(1, 0).