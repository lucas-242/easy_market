import 'package:easy_market/app/modules/shopping_list/presenter/widgets/user_circle.dart';
import 'package:flutter/material.dart';
import '/app/shared/themes/themes.dart';

class UsersRow extends StatelessWidget {
  final VoidCallback onPressed;
  final List<String> users;
  const UsersRow({Key? key, required this.users, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: users.length < 5 ? users.length : 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: UserCircle(name: users[index]),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            AddCircle(users: users),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class AddCircle extends StatelessWidget {
  final List<String> users;
  const AddCircle({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsScheme.secondaryContainer,
      child: Icon(
        users.isEmpty ? Icons.group_add_outlined : Icons.add,
        color: context.colorsScheme.onSecondaryContainer,
      ),
    );
  }
}
