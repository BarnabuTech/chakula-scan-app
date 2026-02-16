import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Removed unused AI/Vertex/Markdown imports that were causing analyzer warnings
import 'package:provider/provider.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_app/utils/app_logger.dart';
import 'package:flutter_app/viewmodels/description_analysis_view_model.dart';
import 'package:flutter_app/viewmodels/meal_analysis_view_model.dart';

class AskAiView extends StatefulWidget {
  final String foodContext;
  final String mealName;
  final File? foodImage;

  const AskAiView({
    super.key,
    required this.foodContext,
    required this.mealName,
    required this.foodImage,
  });

  @override
  State<AskAiView> createState() => _AskAiViewState();
}

class _AskAiViewState extends State<AskAiView> {
  String? nutritionContext;
  String? apiKey;
  bool _isProviderInitialized = false;
  final logger = AppLogger();

  @override
  void initState() {
    super.initState();
    apiKey = kIsWeb
        ? const String.fromEnvironment('GEMINI_API_KEY')
        : dotenv.env['GEMINI_API_KEY'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProvider();
    });
  }

  void _initializeProvider() {
    if (!mounted) return;

    setState(() {
      _createProvider();
      _isProviderInitialized = true;
      logger.d("✅_isProviderInitialized $_isProviderInitialized)");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _createProvider() {
    logger.d("🔄_createProvider() called");
    // Safe provider access - only after widget is built
    final mealAnalysisProvider = Provider.of<MealAnalysisViewModel>(
      context,
      listen: false,
    );
    final descriptionAnalysisProvider =
        Provider.of<DescriptionAnalysisViewModel>(context, listen: false);

    final Map<String, dynamic> nutrientData;
    logger.d("foodContext: ${widget.foodContext}");
    switch (widget.foodContext) {
      case "food":
        // Use meal analysis data
        nutrientData = mealAnalysisProvider.totalScannedPlateNutrients;
        break;
      case "description":
        // Use description analysis data
        nutrientData = descriptionAnalysisProvider.totalPlateNutrients;
        break;
      case "product":
        // Use meal analysis data
        nutrientData = mealAnalysisProvider.totalScannedPlateNutrients;
        break;
      default:
        // Default to empty history if context is unknown
        nutrientData = {};
    }
    logger.d("nutrientData: $nutrientData");
    // Extract individual nutrients with null safety
    final calories = nutrientData['calories'] ?? 0;
    final protein = nutrientData['protein'] ?? 0;
    final carbs = nutrientData['carbohydrates'] ?? 0;
    final fat = nutrientData['fat'] ?? 0;
    final fiber = nutrientData['fiber'] ?? 0;

    nutritionContext =
        '''
      Meal: ${widget.mealName}
      Nutritional Information:
      - Calories: $calories kcal
      - Protein: ${protein}g
      - Carbohydrates: ${carbs}g
      - Fat: ${fat}g
      - Fiber: ${fiber}g
    ''';

    logger.d('🍊Nutrition Context: $nutritionContext');
  }

  @override
  Widget build(BuildContext context) {
    if (!_isProviderInitialized) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(color: Colors.transparent),
            ),
          ),
          title: const Text('Ask AI'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Provider state is refreshed via setState when needed; helper removed.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: Colors.transparent),
          ),
        ),
        title: const Text('Ask AI'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.cardBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  widget.foodImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: FileImage(widget.foodImage!),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            width: double.infinity,
                            height: 200,
                          ),
                        )
                      : Container(
                          height: 200,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black.withOpacity(0)],
                          stops: const [0.4, 0.75],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: widget.foodImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: FileImage(widget.foodImage!),
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                                width: double.infinity,
                                height: 200,
                              ),
                            )
                          : Container(
                              height: 200,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 2,
                    child: Text(
                      widget.mealName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AI Chat Feature Coming Soon',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ask questions about "${widget.mealName}"',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
