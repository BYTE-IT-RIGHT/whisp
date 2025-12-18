import 'package:auto_route/auto_route.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/contacts_library/application/cubit/contacts_cubit.dart';
import 'package:flick/contacts_library/presentation/widgets/contacts_list.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MessagesCubit>()..init()),
        BlocProvider(create: (context) => getIt<ContactsCubit>()..init()),
      ],
      child: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          return BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              return StyledScaffold(
                body: (state is ContactsData)
                    ? ContactsList(contacts: state.contacts)
                    : SizedBox(),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => context.pushRoute(AddContactRoute()),
                  backgroundColor: context.flickTheme.primary,
                  child: Icon(Icons.add),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
