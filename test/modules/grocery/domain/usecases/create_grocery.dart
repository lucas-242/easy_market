import 'package:flutter_test/flutter_test.dart';
import 'package:market_lists/modules/grocery/grocery.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_grocery.mocks.dart';

class GroceryRepositoryTest extends Mock implements GroceryRepository {}

@GenerateMocks([GroceryRepositoryTest])
void main() {
  late CreateGrocery createGrocery;
  late MockGroceryRepositoryTest groceryRepository;

  const testGrocery = Grocery(
    id: 'abc',
    name: 'Test Grocery',
    price: 12.5,
    quantity: 5,
    type: GroceryType.dairy,
  );

  setUp(() {
    groceryRepository = MockGroceryRepositoryTest();
    createGrocery = CreateGrocery(groceryRepository: groceryRepository);
  });

  test('Should return a Grocery', () async {
    when(groceryRepository.create(any)).thenAnswer((_) async => testGrocery);

    final result = await createGrocery(testGrocery);
    expect(result, testGrocery);
    verifyNoMoreInteractions(groceryRepository);
  });
}
