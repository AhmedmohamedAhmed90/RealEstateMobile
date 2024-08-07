// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../../../utils/app_constants.dart';

// // Define states
// abstract class HomeState extends Equatable {
//   const HomeState();
  
//   @override
//   List<Object> get props => [];
// }

// class HomeInitial extends HomeState {}

// class HomeLoading extends HomeState {}

// class HomeLoaded extends HomeState {
//   final List<String> carouselImages;
//   final List<Map<String, String>> compounds;
//   final List<Map<String, String>> news;

//   const HomeLoaded({
//     required this.carouselImages,
//     required this.compounds,
//     required this.news,
//   });

//   @override
//   List<Object> get props => [carouselImages, compounds, news];
// }

// class HomeError extends HomeState {
//   final String message;

//   const HomeError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// // Define cubit
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitial());

//   void loadHomeData() async {
//     emit(HomeLoading());

//     try {
//       final carouselImages = await _fetchCarouselImages();
//       final compounds = await _fetchCompounds();
//       final news = await _fetchNews();

//       emit(HomeLoaded(
//         carouselImages: carouselImages,
//         compounds: compounds,
//         news: news,
//       ));
//     } catch (e) {
//       emit(HomeError(e.toString()));
//     }
//   }


// Future<List<String>> _fetchCarouselImages() async {
//   final response = await http.get(Uri.parse('${baseURL}/carousel/carousel'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//     print('API Response: $data'); // Print the entire response
//     List<String> images = [];
//     for (var item in data) {
//       final photos = item['carousel']['photos'] as List<dynamic>;
//       print('Photos: $photos'); // Print photos list
//       images.addAll(photos.map((photo) => photo as String).toList());
//     }
//     return images;
//   } else {
//     throw Exception('Failed to load carousel data');
//   }
// }
//   Future<List<Map<String, String>>> _fetchNews() async {
//     final response = await http.get(Uri.parse('${baseURL}/news/news'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((newsItem) {
//         return {
//           'title': newsItem['news']['title'] as String,
//           'image': (newsItem['news']['photos'] as List<dynamic>).isNotEmpty ? newsItem['news']['photos'][0] as String : '',
//         };
//       }).toList();
//     } else {
//       throw Exception('Failed to load news');
//     }
//   }

//   Future<List<Map<String, String>>> _fetchCompounds() async {
//     // Mock data for compounds, replace with actual API call if needed
//     return [
//       {'name': 'Regents Square', 'image': 'https://static.wixstatic.com/media/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg/v1/fill/w_1920,h_1013,al_c,q_85,enc_auto/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg'},
//       {'name': 'Regents Park', 'image': 'https://static.wixstatic.com/media/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg/v1/fill/w_2037,h_1405,al_c,q_90,enc_auto/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg'},
//       {'name': 'Land Mark', 'image': 'https://static.wixstatic.com/media/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg/v1/fill/w_1340,h_945,al_c,q_85,enc_auto/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg'},
//     ];
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../../utils/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/CustomerModel.dart';
import '../../../utils/app_constants.dart';
import 'customer_service.dart';

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
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  

  HomeCubit() : super(HomeInitial()) {
    loadHomeData();
  }
   

  void loadHomeData() async {
    emit(HomeLoading());

    try {
      final String? userId = await _storage.read(key: 'userid');
      final carouselImages = await _fetchCarouselImages();
      final compounds = await _fetchCompounds();
      final news = await _fetchNews();
      await fetchCustomerProfile(userId!);

      emit(HomeLoaded(
        carouselImages: carouselImages,
        compounds: compounds,
        news: news,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<List<String>> _fetchCarouselImages() async {
    final response = await http.get(Uri.parse('${baseURL}/carousel/carousel'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('API Response: $data');
      List<String> images = [];
      for (var item in data) {
        final photos = item['carousel']['photos'] as List<dynamic>;
        print('Photos: $photos');
        images.addAll(photos.map((photo) => photo as String).toList());
      }
      return images;
    } else {
      print('Failed to load carousel data, status code: ${response.statusCode}');
      throw Exception('Failed to load carousel data');
    }
  }

  Future<List<Map<String, String>>> _fetchNews() async {
    final response = await http.get(Uri.parse('${baseURL}/news/news'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((newsItem) {
        return {
          'title': newsItem['news']['title'] as String,
          'image': (newsItem['news']['photos'] as List<dynamic>).isNotEmpty ? newsItem['news']['photos'][0] as String : '',
          'entext': newsItem['news']['text']['en'] as String ,
        };
      }).toList();
    } else {
      print('Failed to load news, status code: ${response.statusCode}');
      throw Exception('Failed to load news');
    }
  }

  Future<List<Map<String, String>>> _fetchCompounds() async {
    return [
      {'name': 'Regents Square', 'image': 'https://static.wixstatic.com/media/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg/v1/fill/w_1920,h_1013,al_c,q_85,enc_auto/323294_a6bef655d3ac4f8687eb37ed8b07c472~mv2.jpg'},
      {'name': 'Regents Park', 'image': 'https://static.wixstatic.com/media/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg/v1/fill/w_2037,h_1405,al_c,q_90,enc_auto/323294_b575b0bd8744403f9f0182ccd9223832~mv2.jpg'},
      {'name': 'Land Mark', 'image': 'https://static.wixstatic.com/media/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg/v1/fill/w_1340,h_945,al_c,q_85,enc_auto/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg'},
      //{'name': 'Land Mark', 'image': 'https://static.wixstatic.com/media/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg/v1/fill/w_1340,h_945,al_c,q_85,enc_auto/b0f6bb_cb85e144feca4dfa914c40bc4e0753fd~mv2.jpg'},
    ];
  }

  Future<void> fetchCustomerProfile(String userId) async {
    final String? token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('No authentication token found.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseURL/customers/customerdata/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('customer')) {
          final customer = Customer.fromJson(data['customer']);
          CustomerService().setCustomer(customer); // Store in service
        } else {
          throw Exception('Invalid response structure: No customer data found.');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access - Please log in again.');
      } else {
        throw Exception('Failed to load customer profile: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Error in fetching customer profile: $error');
    }
  }
  
}

