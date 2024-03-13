%%%-------------------------------------------------------------------
%%% @author macie
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. mar 2024 19:59
%%%-------------------------------------------------------------------
-module(pomiarowanie).
-author("macie").
-export([number_of_readings/2, calculate_max/2,calculate_mean/2]).

%% API

%%Date_check = fun({_,{D,_},_},D) -> true; = (_,_)-> false end.

number_of_readings(Readings,Date)-> length(lists:filter(fun({_,{D,_},_}) when D==Date->  true;(_)->false end,Readings)).

maxed_list([]) -> "No reading of that data type";
maxed_list(L) -> lists:max(L).

mean_list([]) -> "No reading of that data type";
mean_list(L) -> mean(0,0,L).

mean(Val,Amount,[]) -> Val/Amount;
mean(Val,Amount,[H|T]) -> mean(Val+H,Amount+1,T).



calculate_max(Readings, Type) ->
  A=lists:map(fun ({_,{_,_},L}) -> lists:filter(fun ({Name,_}) when Name==Type -> true; (_) -> false end,L) end,Readings),
  Filtered=lists:filter(fun ([]) -> false; (_) -> true end,A),
  Mapped=lists:map(fun ([{_,Val}]) -> Val end, Filtered),
  maxed_list(Mapped).


calculate_mean(Readings, Type) ->
  A=lists:map(fun ({_,{_,_},L}) -> lists:filter(fun ({Name,_}) when Name==Type -> true; (_) -> false end,L) end,Readings),
  Filtered=lists:filter(fun ([]) -> false; (_) -> true end,A),
  Mapped=lists:map(fun ([{_,Val}]) -> Val end, Filtered),
  mean_list(Mapped).


%%  lists:map(fun([{_,Val}]) ->Val end,A).

