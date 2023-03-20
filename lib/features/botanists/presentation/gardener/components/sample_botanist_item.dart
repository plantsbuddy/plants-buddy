import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';

class SampleBotanistItem extends StatelessWidget {
  const SampleBotanistItem(this.botanist, {Key? key}) : super(key: key);

  final Botanist botanist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(app_routes.botanistDetails, arguments: {
        'gardener_appointment_bloc': context.read<GardenerAppointmentBloc>(),
        'chat_bloc': context.read<ChatBloc>(),
        'authentication_bloc': context.read<AuthenticationBloc>(),
        'botanist': botanist,
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    botanist.profilePicture,
                    height: 60,
                    fit: BoxFit.cover,
                    width: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${botanist.username}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 20,
                          ),
                          Text(
                            botanist.city,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
