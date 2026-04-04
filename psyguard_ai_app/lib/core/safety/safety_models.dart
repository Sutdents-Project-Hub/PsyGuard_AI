import '../risk_engine/risk_models.dart';

class SafetyStep {
  const SafetyStep({required this.title, required this.content});

  final String title;
  final String content;
}

class SafetyResource {
  const SafetyResource({
    required this.name,
    required this.contact,
    required this.description,
  });

  final String name;
  final String contact;
  final String description;
}

class SafetyPlan {
  const SafetyPlan({
    required this.riskLevel,
    required this.steps,
    required this.resources,
    required this.copyTemplate,
    required this.disclaimer,
  });

  final RiskLevel riskLevel;
  final List<SafetyStep> steps;
  final List<SafetyResource> resources;
  final String copyTemplate;
  final String disclaimer;
}
