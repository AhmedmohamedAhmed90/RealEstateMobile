import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define states
abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

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

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

// Define cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadHomeData() async {
    emit(HomeLoading());

    try {
      final news = await _fetchNews();
      final carouselImages = _getCarouselImagesFromNews(news);
      final compounds = await _fetchCompounds();

      emit(HomeLoaded(
        carouselImages: carouselImages,
        compounds: compounds,
        news: news,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<List<Map<String, String>>> _fetchNews() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5001/api/news/news'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((newsItem) {
        return {
          'title': newsItem['news']['title'] as String,
          'image': (newsItem['news']['photos'] as List<dynamic>).isNotEmpty ? newsItem['news']['photos'][0] as String : '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  List<String> _getCarouselImagesFromNews(List<Map<String, String>> news) {
    return news.take(3).map((newsItem) => newsItem['image']!).toList();
  }

  Future<List<Map<String, String>>> _fetchCompounds() async {
    // Mock data for compounds, replace with actual API call if needed
    return [
      {'name': 'Compound A', 'image': 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg'},
      {'name': 'Compound B', 'image': 'https://via.placeholder.com/150?text=B'},
      {'name': 'Compound C', 'image': 'https://via.placeholder.com/150?text=C'},
    ];
  }
}
