import 'package:get/get.dart';
import '../controllers/document_authentication_controller.dart';

class DocumentAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentAuthenticationController>(() => DocumentAuthenticationController());
  }
}


