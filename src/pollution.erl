%%%-------------------------------------------------------------------
%%% @author macie
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. mar 2024 22:46
%%%-------------------------------------------------------------------
-module(pollution).
-author("macie").

%% API
-export([create_monitor/0, add_station/3, add_value/5, getKey/2, remove_value/4, get_one_value/4, get_station_mean/3, get_daily_mean/3,get_daily_over_limit/4]).

getKey(Key, M) ->
  TrueKey = maps:fold(fun({N, C}, _, AccIn) when N == Key orelse C == Key -> AccIn ++ [{N, C}];
    (_, _, AccIn) -> AccIn end, [], M),
  case TrueKey of
    [] -> [false];
    [_] -> TrueKey
  end.



add_value(Key, Time, Type, Val, M) ->
  [FullKey] = getKey(Key, M),
  case FullKey of
    false -> {error, "Stacja, do ktorej chcesz dodac nie istnieje"};
    _ -> Readings = maps:get(FullKey, M),
      case maps:find({Time, Type}, Readings) of
        error -> NewReadings = Readings#{{Time, Type} => Val},
          M#{FullKey => NewReadings};
        _ -> {error, "nie mozna odac wartosci"}
      end
  end
.

remove_value(Key, Time, Type, M) ->
  [FullKey] = getKey(Key, M),
  case FullKey of
    false -> {error, "Nie istnieje stacja do usuniecia"};
    _ -> Readings = maps:get(FullKey, M),
      case maps:find({Time, Type}, Readings) of
        error -> {error, "Nie istnieje pomiar do usniecia"};
        _ -> NewReadings = maps:remove({Time, Type}, Readings),
          M#{FullKey => NewReadings}
      end
  end.


create_monitor() -> #{}.



is_station(_, _, M) when map_size(M) == 0 -> false;
is_station(Name, Cords, M) ->
  case maps:fold(fun({N, C}, _, Accin) when N == Name orelse C == Cords -> Accin + 1;
    (_, _, AccIn) -> AccIn end,
    0, M) of
    0 -> false;
    _ -> true
  end.


add_station(Name, Cords, M) ->
  case is_station(Name, Cords, M) of
    true -> {error, "nie mozna dodac stacji"};
    false -> M#{{Name, Cords} => #{}}
  end.


get_one_value(Key, Time, Type, M) ->
  [FullKey] = getKey(Key, M),
  case FullKey of
    false -> {error, "Nie istnieje stacja do spomiarowania"};
    _ -> Readings = maps:get(FullKey, M),
      case maps:find({Time, Type}, Readings) of
        error -> {error, "Nie istnieje zadany pomiar"};
        _ -> maps:get({Time, Type}, Readings)
      end
  end.


get_station_mean(Key, Type, M) ->
  [FullKey] = getKey(Key, M),
  case FullKey of
    false -> {error, "Nie istnieje stacja do sprawdzenia sredniej"};
    _ -> Readings = maps:get(FullKey, M),
      [Sum, Amount] = maps:fold(fun({_, MyType}, Val, [TempSum, TempAmount]) when MyType == Type ->
        [TempSum + Val, TempAmount + 1];
        (_, _, AccIn) -> AccIn end, [0, 0], Readings),
      case Amount of
        0 -> {error, "Brak jakichkolwiek pomiarow"};
        _ -> Sum / Amount
      end
  end.

get_daily_mean(Type, Day, M) ->
  [Sum, Amount] = maps:fold(fun(_, Reading, [TempSum, TempAmount]) ->
    maps:fold(fun({{Date, _}, MyType}, Val, [Sumka, Liczba]) when MyType == Type andalso Day == Date ->
      [Sumka + Val, Liczba + 1];
      (_, _, AccIn) -> AccIn end, [TempSum, TempAmount], Reading);
    (_, _, Acc) -> Acc end, [0, 0], M),

  case Amount of
    0 -> {error, "Brak jakichkolwiek pomiarow"};
    _ -> Sum / Amount
  end.


get_daily_over_limit(Type, Day, Limit, M) ->
  Stacje = maps:fold(fun({Name, _}, Reading, TempSum) ->
    maps:fold(fun({{Date, _}, MyType}, Val, Nazwy) when MyType == Type andalso Day == Date andalso Limit < Val ->
      [Name]++Nazwy;
      (_, _, AccIn) -> AccIn end, TempSum, Reading);
    (_, _, Acc) -> Acc end, [], M),
%  io:fwrite("Hello world!~n", Stacje),
  sets:size(sets:from_list(Stacje)).




