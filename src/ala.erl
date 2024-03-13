%%%-------------------------------------------------------------------
%%% @author macie
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. lut 2024 12:16
%%%-------------------------------------------------------------------
-module(ala).
-author("macie").

%% API
-export([factorial/1,power/2]).

factorial(0) -> 1;
factorial(N) -> N*factorial(N-1).


power(_,0)-> 1;
power(Podst,Pot)->Podst*power(Podst,Pot-1).
