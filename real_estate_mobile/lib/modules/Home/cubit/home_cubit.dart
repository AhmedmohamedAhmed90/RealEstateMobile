import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Define states
abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> carouselImages;
  final List<Map<String, String>> compounds;
  final List<Map<String, String>> news;

  const HomeLoaded({
    required this.carouselImages,
    required this.compounds,
    required this.news,
  });

  @override
  List<Object> get props => [carouselImages, compounds, news];
}

// Define cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadHomeData() {
    // Mock data
    final carouselImages = [
      'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
      'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
      'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
    ];

    final compounds = [
      {'name': 'Compound A', 'image': 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg'},
      {'name': 'Compound B', 'image': 'https://via.placeholder.com/150?text=B'},
      {'name': 'Compound C', 'image': 'https://via.placeholder.com/150?text=C'},
    ];

    final news = [
      {'title': 'News Headline 1', 'image': 'https://via.placeholder.com/600x200?text=News+1'},
      {'title': 'News Headline 2', 'image': 'https://via.placeholder.com/600x200?text=News+2'},
      {'title': 'News Headline 3', 'image': 'https://via.placeholder.com/600x200?text=News+3'},
    ];

    emit(HomeLoaded(
      carouselImages: carouselImages,
      compounds: compounds,
      news: news,
    ));
  }
}
