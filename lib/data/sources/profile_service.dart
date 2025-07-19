import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../models/profile_model.dart';
import '../models/user_model.dart';

class ProfileService {
  final Dio dio;
  ProfileService(this.dio);

  Future<ProfileModel> getProfile() async {
    // Affiche tous les headers envoyés
    print('Headers envoyés pour /profil/me : ${dio.options.headers}');
    final token = dio.options.headers['Authorization'];
    print('JWT envoyé dans Authorization: $token');
    final response = await dio.get(ApiConfig.profileMe);
    print('Réponse backend: ${response.data}'); // DEBUG
    try {
      return ProfileModel.fromJson(response.data);
    } catch (e, stack) {
      print('Erreur lors de la désérialisation du profil: $e');
      print(stack);
      rethrow;
    }
  }

  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final response = await dio.put(ApiConfig.updateProfile, data: profile.toJson());
    return ProfileModel.fromJson(response.data);
  }

  Future<void> demandeEvolutionProducteur(Map<String, dynamic> request) async {
    await dio.post(ApiConfig.demandeEvolutionProducteur, data: request);
  }
}
