import 'package:auto_route/auto_route.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/messaging/application/cubit/messages_cubit.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ContactsLibraryScreen extends StatelessWidget {
  const ContactsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MessagesCubit>()..init(),
      child: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          return StyledScaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () async {
                //     final url =
                //         'http://cn2bgb3jkt2fpgzw3ycykhej4x2hfjc6eg2clmdyxb4pvzj7sz3pfyad.onion/message';
                //     debugPrint('📤 Sending to: $url');
                //     final result = await getIt<ITorRepository>().post(
                //       url,
                //       headers: {'Content-Type': 'application/json'},
                //       body: jsonEncode(
                //         Message(
                //           id: '0',
                //           sender: 'dsffds',
                //           content: 'fdsdfs',
                //           timestamp: DateTime.now(),
                //         ).toJson(),
                //       ),
                //     );
                //     result.fold(
                //       (failure) => debugPrint('❌ Send failed: $failure'),
                //       (response) =>
                //           debugPrint('✅ Sent! Response: ${response.body}'),
                //     );
                //   },
                //   child: Text('Send Message'),
                // ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.pushRoute(AddContactRoute()),
              backgroundColor: context.flickTheme.primary,
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
