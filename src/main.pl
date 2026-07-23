:- include('state.pl').
:- include('map.pl').
:- include('movement.pl').
:- include('inventory.pl').
:- include('alchemy.pl').
:- include('save_load.pl').

start :-
    init_state,
    write('======================================='), nl,
    write('        WELCOME TO EXPLODATION!        '), nl,
    write('======================================='), nl,
    write('Bermainlah langsung dari prompt | ?-'), nl,
    write('Command: w. a. s. d. | take. | status. | mix(I1, I2). | quit.'), nl,
    nl,
    check_tile(6,6).

quit :-
    write('======================================='), nl,
    write('  Terima kasih telah bermain Explodation!'), nl,
    write('======================================='), nl,
    write('Ketik "start." untuk mengulang permainan dari awal.'), nl,
    write('Ketik "halt." jika ingin menutup GNU Prolog sepenuhnya.'), nl.