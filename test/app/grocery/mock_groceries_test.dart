import 'package:market_lists/app/grocery/grocery.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class GroceryRepositoryTest extends Mock implements GroceryRepository {}

@GenerateMocks([GroceryRepositoryTest])
void main() {}
