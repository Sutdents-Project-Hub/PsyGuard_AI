import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../risk_engine/risk_models.dart';
import 'safety_models.dart';

final safetyFlowServiceProvider = Provider<SafetyFlowService>((ref) {
  return SafetyFlowService();
});

class SafetyFlowService {
  SafetyPlan getPlan({required RiskLevel riskLevel, required String locale}) {
    return SafetyPlan(
      riskLevel: riskLevel,
      steps: const [
        SafetyStep(
          title: 'Step A｜先穩定呼吸',
          content: '吸氣 4 秒、停 2 秒、吐氣 6 秒，重複 3 次，先讓身體降速。',
        ),
        SafetyStep(
          title: 'Step B｜選擇一位真人協助',
          content: '你不需要一個人撐著，請優先聯絡信任的大人或校內輔導窗口。',
        ),
        SafetyStep(
          title: 'Step C｜複製求助訊息',
          content: '把需求說清楚，讓對方知道你現在需要陪伴與安全協助。',
        ),
        SafetyStep(title: 'Step D｜保留當下安全', content: '遠離危險物品，移動到明亮且有人可接近的空間。'),
      ],
      resources: const [
        SafetyResource(
          name: '校內輔導室',
          contact: '請依學校公告',
          description: '優先聯絡導師、輔導老師或學務處。',
        ),
        SafetyResource(
          name: '安心專線',
          contact: '1925',
          description: '24 小時心理支持與轉介。',
        ),
        SafetyResource(name: '生命線', contact: '1995', description: '提供情緒支持與傾聽。'),
        SafetyResource(name: '警察', contact: '110', description: '有立即人身危險時撥打。'),
        SafetyResource(
          name: '消防救護',
          contact: '119',
          description: '有緊急醫療需求時撥打。',
        ),
      ],
      copyTemplate: '我現在情緒很不穩，擔心自己會做出危險行為。請你現在陪我，並協助我聯絡輔導老師或 1925。',
      disclaimer: '本應用非醫療診斷工具，不能取代心理師與醫療專業。若有立即危險請立刻撥打 110/119。',
    );
  }
}
