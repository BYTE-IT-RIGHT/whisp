import 'package:auto_route/auto_route.dart';
import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:flick/common/screens/error_screen.dart';
import 'package:flick/common/screens/loading_screen.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddContactCubit>()..init(),
      child: BlocBuilder<AddContactCubit, AddContactState>(
        builder: (context, state) {
          switch (state) {
            case AddContactLoading():
            case AddContactWaiting():
              return LoadingScreen();
            case AddContactData(:final onionAddress):
              return _buildDataScreen(context, onionAddress);
            case AddContactSuccess(:final username):
              return _buildSuccessScreen(context, username);
            case AddContactDeclined():
              return _buildDeclinedScreen(context);
            case AddContactError(:final failure):
              return ErrorScreen(
                failure: failure,
                onRetry: () => context.read<AddContactCubit>().init(),
              );
          }
        },
      ),
    );
  }

  Widget _buildDataScreen(BuildContext context, String onionAddress) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your Onion Address'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FittedBox(child: Text(onionAddress, maxLines: 1)),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: onionAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Contact Onion Address',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<AddContactCubit>().addContact(
                _addressController.text,
              ),
              child: const Text('Send invite'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(BuildContext context, String username) {
    return StyledScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text('$username accepted your invite!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.router.maybePop(),
              child: const Text('Back to contacts'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeclinedScreen(BuildContext context) {
    return StyledScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text('Your invitation was declined'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.read<AddContactCubit>().init(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
