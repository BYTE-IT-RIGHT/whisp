import 'package:auto_route/auto_route.dart';
import 'package:flick/common/screens/loading_screen.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/conversations_library/application/cubit/conversations_cubit.dart';
import 'package:flick/conversations_library/presentation/widgets/contacts_app_bar.dart';
import 'package:flick/conversations_library/presentation/widgets/conversations_list.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/messaging/application/cubit/messages_cubit.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ConversationsLibraryScreen extends StatelessWidget {
  const ConversationsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MessagesCubit>()..init()),
        BlocProvider(create: (context) => getIt<ConversationsCubit>()..init()),
      ],
      child: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          return BlocBuilder<ConversationsCubit, ConversationsState>(
            builder: (context, state) {
              return StyledScaffold(
                appBar: ContactsAppBar(),
                body: (state is ConversationsLoading)
                    ? LoadingScreen()
                    : (state is ConversationsData)
                    ? ConversationsList(conversations: state.conversations)
                    : SizedBox(),
                floatingActionButton: (state is ConversationsData) ? FloatingActionButton(
                  onPressed: () => context.pushRoute(AddContactRoute()),
                  backgroundColor: context.flickTheme.primary,
                  child: Icon(Icons.add),
                ) : null,
              );
            },
          );
        },
      ),
    );
  }
}
