import 'package:auto_route/auto_route.dart';
import 'package:whisp/common/screens/loading_screen.dart';
import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/conversations_library/application/cubit/conversations_cubit.dart';
import 'package:whisp/conversations_library/presentation/widgets/conversations_list.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/invitation/presentation/invitation_wrapper.dart';
import 'package:whisp/messaging/application/cubit/messages_cubit.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
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
              return InvitationWrapper(
                child: StyledScaffold(
                  appBar: StyledAppBar(title: 'Contacts'),
                  body: (state is ConversationsLoading)
                      ? LoadingScreen()
                      : (state is ConversationsData)
                      ? ConversationsList(conversations: state.conversations)
                      : SizedBox(),
                  floatingActionButton: (state is ConversationsData)
                      ? FloatingActionButton(
                          onPressed: () => context.pushRoute(AddContactRoute()),
                          backgroundColor: context.whispTheme.primary,
                          child: Icon(Icons.add),
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
