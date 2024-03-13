%%%-------------------------------------------------------------------
%%% @author macie
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. lut 2024 14:15
%%%-------------------------------------------------------------------
-module(myLists).
-author("macie").

%% API
-export([contains/2,duplicateElements/1,sumFloats/1, measurements/0]).



contains([],_) -> false;
contains([E|_],E) -> true;
contains([_|T],E) -> contains(T,E).

duplicateElements([N]) ->[N,N];
duplicateElements([H|T]) -> [H,H] ++ duplicateElements(T).

sumFloats2(N,[]) -> N;
sumFloats2(N,[H|T]) ->sumFloats2(N+H,T).


%%sumFloats([]) -> 0;
sumFloats(A)-> sumFloats2(0,A).


measurements() -> [{"Wroclaw",{{2024,3,4},{19,41,30}},[{"PM10", 7.5},{"cisnienie",1050},{"temperatura",10}]},
  {"Krakow",{{2024,3,5},{8,18,30}},[{"PM2.5", 0.5},{"cisnienie",1050},{"temperatura",14}]},
  {"Krakow",{{2024,2,23},{20,11,30}},[{"PM2.5", 0.9},{"cisnienie",950},{"temperatura",7}]},
  {"Tenczynek",{{2024,3,7},{17,35,30}},[{"PM2.5", 1.5},{"cisnienie",1090},{"temperatura",14},{"wilgotnosc",70}]},
  {"Rzeszow",{{2024,3,1},{13,33,30}},[{"PM10",5.6},{"PM1",0.1},{"PM2.5", 0.5},{"temperatura",16}]},
  {"Gdynia",{{2024,3,2},{3,27,30}},[{"temperatura",10},{"cisnienie",1050},{"wilgotnosc",90}]},
  {"Radom",{{2024,2,23},{9,22,30}},[{"cisnienie",987},{"temperatura",3}]},
  {"Sosnowiec",{{2024,3,7},{19,51,30}},[{"PM2.5", 0.5},{"cisnienie",1027},{"wilgotnosc",38}]}].
