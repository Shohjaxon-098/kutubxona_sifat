import 'package:flutter/services.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/drawer/domain/entities/contribution.dart';

class ContributeCard extends StatelessWidget {
  const ContributeCard({super.key, required this.info});
  final Contribution info;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: info.imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Бепул кутубхонага хисса қўшиш',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  info.cardNumber1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                tooltip: 'Нусха олиш',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: info.cardNumber1));
                  ToastMessage.showToast('Нусха олинди', context);
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  info.cardNumber2,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                tooltip: 'Нусха олиш',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: info.cardNumber2));
                  ToastMessage.showToast('Нусха олинди', context);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            info.description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
