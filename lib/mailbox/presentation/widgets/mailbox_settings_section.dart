import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/mailbox/application/cubit/mailbox_cubit.dart';
import 'package:whisp/mailbox/domain/mailbox.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/settings/presentation/widgets/section_header.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class MailboxSettingsSection extends StatelessWidget {
  const MailboxSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailboxCubit, MailboxState>(
      builder: (context, state) {
        final mailboxes = state is MailboxLoaded
            ? state.mailboxes
            : <Mailbox>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionHeader(title: 'Mailboxes'),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: context.whispTheme.primary,
                  ),
                  onPressed: () => context.pushRoute(AddMailboxRoute()),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (mailboxes.isEmpty)
              _buildEmptyState(context)
            else
              _buildMailboxList(context, mailboxes),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = context.whispTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.stroke.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.mail_outline_rounded,
            size: 48,
            color: theme.caption.color,
          ),
          const SizedBox(height: 12),
          Text('No mailboxes added', style: theme.subtitle),
          const SizedBox(height: 4),
          Text(
            'Add a mailbox to receive messages when offline',
            style: theme.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.pushRoute(AddMailboxRoute()),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Mailbox'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMailboxList(BuildContext context, List<Mailbox> mailboxes) {
    final theme = context.whispTheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.stroke.withValues(alpha: 0.3)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mailboxes.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: theme.stroke.withValues(alpha: 0.2)),
        itemBuilder: (context, index) {
          final mailbox = mailboxes[index];
          return _MailboxTile(mailbox: mailbox);
        },
      ),
    );
  }
}

class _MailboxTile extends StatelessWidget {
  final Mailbox mailbox;

  const _MailboxTile({required this.mailbox});

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    final shortAddress = _truncateAddress(mailbox.onionAddress);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primary.withValues(alpha: 0.2),
              theme.primary.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.mail_rounded, color: theme.primary, size: 22),
      ),
      title: Text(
        shortAddress,
        style: theme.body.copyWith(fontFamily: 'monospace', fontSize: 13),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: mailbox.isOnline ? theme.contrast : theme.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            mailbox.isOnline ? 'Online' : 'Offline',
            style: theme.caption.copyWith(
              color: mailbox.isOnline ? theme.contrast : theme.error,
            ),
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, color: theme.caption.color),
        onSelected: (value) {
          if (value == 'remove') {
            _showRemoveDialog(context);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'remove',
            child: Row(
              children: [
                Icon(Icons.delete_outline, color: theme.error, size: 20),
                const SizedBox(width: 12),
                Text('Remove', style: TextStyle(color: theme.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _truncateAddress(String address) {
    if (address.length <= 24) return address;
    return '${address.substring(0, 12)}...${address.substring(address.length - 12)}';
  }

  void _showRemoveDialog(BuildContext context) {
    final theme = context.whispTheme;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: theme.background,
        title: Text('Remove Mailbox?', style: theme.h5),
        content: Text(
          'Are you sure you want to remove this mailbox?',
          style: theme.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel', style: TextStyle(color: theme.caption.color)),
          ),
          TextButton(
            onPressed: () {
              context.read<MailboxCubit>().removeMailbox(mailbox.onionAddress);
              Navigator.of(dialogContext).pop();
            },
            child: Text('Remove', style: TextStyle(color: theme.error)),
          ),
        ],
      ),
    );
  }
}
