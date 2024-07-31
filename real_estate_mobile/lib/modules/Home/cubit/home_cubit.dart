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
      'https://static.wixstatic.com/media/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg/v1/fill/w_1920,h_1013,al_c,q_85,enc_auto/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg',
      'https://static.wixstatic.com/media/b0f6bb_e8954f54a1134e279255e1536380fe22~mv2.png/v1/fill/w_1569,h_868,al_c,q_90,enc_auto/b0f6bb_e8954f54a1134e279255e1536380fe22~mv2.png',
      'https://static.wixstatic.com/media/b0f6bb_b2772081219741c6a7238d7103af8791~mv2.png/v1/fill/w_1564,h_773,al_c,q_90,enc_auto/b0f6bb_b2772081219741c6a7238d7103af8791~mv2.png',
    ];

    final compounds = [
      {'name': 'Regents Square', 'image': 'https://static.wixstatic.com/media/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg/v1/fill/w_1920,h_1013,al_c,q_85,enc_auto/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg'},
      {'name': 'Regents Park', 'image': 'https://static.wixstatic.com/media/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg/v1/fill/w_2037,h_1405,al_c,q_90,enc_auto/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg'},
      {'name': 'Land Mark', 'image': 'https://static.wixstatic.com/media/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg/v1/fill/w_1340,h_945,al_c,q_85,enc_auto/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg'},
    ];

    final news = [
      {'title': 'New Services available', 'image': 'https://www.shutterstock.com/image-vector/new-service-sign-banner-speech-260nw-1356778103.jpg'},
      {'title': 'Pool Maintenance Reminder', 'image': 'https://www.millenniumpool.com/wp-content/uploads/2020/04/GettyImages-1134506282.jpg'},
      {'title': 'Amr Diab Event Reminder', 'image': 'https://amrdiab.net/wp-content/uploads/2024/06/AmrDiabinBeirut-2024.jpg'},
    ];

    emit(HomeLoaded(
      carouselImages: carouselImages,
      compounds: compounds,
      news: news,
    ));
  }
}
