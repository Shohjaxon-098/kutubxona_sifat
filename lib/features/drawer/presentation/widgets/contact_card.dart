import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/domain/entities/about_us_entity.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/contact_info_row.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/social_media_row.dart';

class ContactCard extends StatelessWidget {
  final AboutUsEntity info;

  const ContactCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(imageUrl: info.image),
          ),
          const SizedBox(height: 24),

          Text(
            info.library_name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),

          ContactInfoRow(title: 'Манзил', value: info.address),
          ContactInfoRow(
            title: 'Телефон',
            value: '${info.phone1}\n${info.phone2}',
          ),
          ContactInfoRow(title: 'Электрон почта', value: info.email),

          const SizedBox(height: 24),
          const SocialMediaRow(),
        ],
      ),
    );
  }
}
