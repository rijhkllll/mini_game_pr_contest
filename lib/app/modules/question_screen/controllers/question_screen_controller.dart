import 'package:get/get.dart';

import 'package:mini_game_pr_contest/app/data/question_repo.dart';

import '../../../data/local_db.dart';
import '../../../model/local_model/best_score.dart';
import '../../../model/response_model/question_response.dart';
import '../../home/controllers/home_controller.dart';

class QuestionScreenController extends GetxController {
  //TODO: Implement QuestionScreenController
  RxList<Questions> questionList = <Questions>[].obs;
  final count = 0.obs;
  RxInt counter = 0.obs;
  RxList<int> scoreAddChecker = <int>[0, 0, 0, 0].obs;
  RxInt currentScore = 0.obs;
  var answerList = <String?>[].obs;
  //final box = GetStorage();
  RxInt bestScore = 0.obs;
  List<Map>? bestScoreList;
  HomeController homeController=Get.put(HomeController());

  int pickCorrectAnswerIndex(Questions item) {
    if (item.correctAnswer == "A") {
      print("A");
      return 0;
    } else if (item.correctAnswer == "B") {
      print("B");

      return 1;
    } else if (item.correctAnswer == "C") {
      print("C");

      return 2;
    } else if (item.correctAnswer == "D") {
      print("D");

      return 3;
    } else {
      return 0;
    }
  }

  void loadAnswerList(Questions item) {
    answerList.value = [];
    answerList.value.add(item.answers?.a?.replaceAll("&", ""));
    answerList.value.add(item.answers?.b?.replaceAll("&", ""));
    answerList.value.add(item.answers?.c?.replaceAll("&", ""));
    answerList.value.add(item.answers?.d?.replaceAll("&", ""));
  }

  @override
  void onInit() {
    super.onInit();
  }

  setBestScore() async {

    bestScoreList = await DataBaseHelper.instance.newQuery(1);
    print("currentScore${currentScore}");
    print("localSCore${bestScoreList?[0]["bestScore"].toString()}");

    if (currentScore > bestScoreList?[0]["bestScore"]) {
      BestScore bestScoreModel=BestScore(id:1,bestScore:currentScore.value);
      print("for update");

      DataBaseHelper.instance.updaate(bestScoreModel);
      bestScoreList = await DataBaseHelper.instance.newQuery(1);

    }
  }

  loadQuestionLit() async {
    print("Load calling");
    Response response = await QuestionRepo().getQuestionList();
    if (response.statusCode == 200) {
      questionList.value = [];
      print("got it");
      print(response.body.toString());
      questionList.value = QuestionModel.fromJson(response.body).questions!;
    } else {
      print(response.status);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
