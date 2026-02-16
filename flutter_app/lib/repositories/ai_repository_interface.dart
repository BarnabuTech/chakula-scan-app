import 'dart:io';

import 'package:flutter_app/models/food_analysis_response.dart';
import 'package:flutter_app/models/product_analysis_response.dart';

abstract class AiRepositoryInterface {
  Future<ProductAnalysisResponse> analyzeProductImages(
      File frontImage, File labelImage);
  Future<FoodAnalysisResponse> analyzeFoodImage(File imageFile);
  Future<FoodAnalysisResponse> analyzeFoodDescription(String description);
}
