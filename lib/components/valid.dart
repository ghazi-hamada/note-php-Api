import 'package:course_php/constant/message.dart';

validinput(String val, int min, int max) {
  if (val.length > max) {
    return "$messagesInputMax $max";
  }
  if (val.isEmpty) {
    return messagesInputEmpty;
  }
  if (val.length < min) {
    return "$messagesInputMin $min";
  }
  
}
