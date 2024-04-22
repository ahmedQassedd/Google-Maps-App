abstract class MapState {}

class MapInitial extends MapState {}


class SearchOnChangedState extends MapState {}

class LoadingGettingLocationState extends MapState {}
class SuccessGettingLocationState extends MapState {}
class ErrorGettingLocationState extends MapState {}




class LoadingSearchedPlaceState extends MapState {}
class SuccessSearchedPlaceState extends MapState {}
class ErrorSearchedPlaceState extends MapState {}


class LoadingPlaceDetailsState extends MapState {}
class SuccessPlaceDetailsState extends MapState {}
class ErrorPlaceDetailsState extends MapState {}


class LoadingDirectionState extends MapState {}
class SuccessDirectionState extends MapState {}
class ErrorDirectionState extends MapState {}


class MarkersState extends MapState {}


