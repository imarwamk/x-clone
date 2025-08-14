abstract class HomeState {}

class HomeInitial extends HomeState{}

class HomeLoding extends HomeState{}

class HomeSuccess extends HomeState{
  final List <Map<String, dynamic>> posts;
  HomeSuccess(this.posts);
}
 
class HomeFailure extends HomeState{
  final String errorMessage;
  HomeFailure(this.errorMessage);
}