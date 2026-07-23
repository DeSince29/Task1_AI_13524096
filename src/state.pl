:- dynamic(player_pos/2).      % player_pos(X, Y)
:- dynamic(player_stamina/1).  % player_stamina(Angka)
:- dynamic(player_hp/1).       % player_hp(Angka)
:- dynamic(inventory/1).       % inventory([List_Item])
:- dynamic(item_at/3).         % item_at(X, Y, JenisElemen)

init_state :-
    retractall(player_pos(_, _)),
    retractall(player_stamina(_)),
    retractall(player_hp(_)),
    retractall(inventory(_)),
    retractall(item_at(_,_,_)),
    
    % Set awal pemain di Basecamp (6,6)
    asserta(player_pos(6, 6)),
    asserta(player_stamina(30)),
    asserta(player_hp(3)),
    asserta(inventory([])),
    
    % Spawn beberapa elemen acak di map untuk testing PoC
    asserta(item_at(4, 6, water)),
    asserta(item_at(8, 6, earth)),
    asserta(item_at(6, 4, fire)).