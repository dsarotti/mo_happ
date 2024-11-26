import 'package:get/get.dart';
import 'package:mo_happ/pages/doors/controller/doors_controller.dart';

class DoorsBinding extends Bindings{
  @override
  void dependencies(){
    Get.put<DoorsController>(DoorsController(),permanent: true) ;
  }
}