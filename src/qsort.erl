%%%-------------------------------------------------------------------
%%% @author macie
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. mar 2024 12:28
%%%-------------------------------------------------------------------
-module(qsort).
-author("macie").

%% API
-export([less_than/2,grt_eq_than/2,qs/1,random_elems/3, compare_speeds/3]).


less_than(List, Arg)-> [X || X<-List, X<Arg].

grt_eq_than(List, Arg)->[X || X<-List, X>=Arg].

qs([])->[];
qs([Val])->[Val];
qs([Pivot|Tail])-> qs( less_than(Tail,Pivot))++ [Pivot] ++ qs( grt_eq_than(Tail,Pivot)).

random_elems(N,Min,Max)->[rand:uniform(Max-Min)+Min || _<-lists:seq(1,N)].

compare_speeds(List, Fun1, Fun2) ->
  T1 = timer:tc(Fun1,[List]),
  T2 = timer:tc(Fun2,[List]),
  io:format("Moja ~p~n vs biblioteczna ~p~n",[T1,T2]).