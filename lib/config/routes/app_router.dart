import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_routes.dart' as app_routes;

import 'package:plants_buddy/features/admin/config/admin_home_route.dart' as admin;
import 'package:plants_buddy/features/authentication/config/authentication_route.dart' as authentication;
import 'package:plants_buddy/features/home/config/home_route.dart' as home;
import 'package:plants_buddy/features/botanists/config/attend_gardeners_route.dart' as consult_gardeners;
import 'package:plants_buddy/features/botanists/config/consult_botanists_route.dart' as consult_botanists;
import 'package:plants_buddy/features/botanists/config/botanist_details_route.dart' as botanist_details;
import 'package:plants_buddy/features/botanists/config/reviews_route.dart' as reviews;
import 'package:plants_buddy/features/identification/config/identify_route.dart' as identification;
import 'package:plants_buddy/features/identification/config/identification_results_route.dart'
    as identification_results;
import 'package:plants_buddy/features/identification/config/identification_history_route.dart'
    as identification_history;
import 'package:plants_buddy/features/identification/config/history_identification_results_route.dart'
    as history_identification_results;
import 'package:plants_buddy/features/identification/config/plant_details_route.dart' as plant_details;
import 'package:plants_buddy/features/identification/config/disease_details_route.dart' as disease_details;
import 'package:plants_buddy/features/chat/config/chat_route.dart' as chat;
import 'package:plants_buddy/features/chatbot/config/chatbot_route.dart' as chatbot;
import 'package:plants_buddy/features/reminders/config/add_reminder_route.dart' as add_reminder;
import 'package:plants_buddy/features/reminders/config/reminder_details_route.dart' as reminder_details;
import 'package:plants_buddy/features/community/config/add_community_post_route.dart' as add_community_post;
import 'package:plants_buddy/features/community/config/community_post_details_route.dart' as community_post_details;
import 'package:plants_buddy/features/collections/config/collection_plants_route.dart' as collection_plants;
import 'package:plants_buddy/features/collections/config/add_plant_to_collection_route.dart' as add_plant_to_collection;
import 'package:plants_buddy/features/suggestions/config/suggestions_route.dart' as suggestions;
import 'package:plants_buddy/features/suggestions/config/full_guide_route.dart' as full_guide;
import 'package:plants_buddy/features/admin/config/blocked_users_route.dart' as blocked_users;
import 'package:plants_buddy/features/admin/config/reported_botanists_route.dart' as reported_botanists;
import 'package:plants_buddy/features/admin/config/reported_comments_route.dart' as reported_comments;
import 'package:plants_buddy/features/admin/config/reported_posts_route.dart' as reported_posts;
import 'package:plants_buddy/features/admin/config/reported_ratings_route.dart' as reported_ratings;

class AppRouter {
  final sl = GetIt.instance;

  AppRouter();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case app_routes.adminHome:
        return admin.route();

      case app_routes.authentication:
        return authentication.route();

      case app_routes.home:
        return home.route();

      case app_routes.attendGardeners:
        return consult_gardeners.route(settings.arguments);

      case app_routes.consultBotanists:
        return consult_botanists.route(settings.arguments);

      case app_routes.botanistDetails:
        return botanist_details.route(settings.arguments);

      case app_routes.reviews:
        return reviews.route(settings.arguments);

      case app_routes.chat:
        return chat.route(settings.arguments);

      case app_routes.chatbot:
        return chatbot.route();

      case app_routes.identify:
        return identification.route(settings.arguments);

      case app_routes.identificationHistory:
        return identification_history.route();

      case app_routes.identificationResults:
        return identification_results.route(settings.arguments);

      case app_routes.historyIdentificationResults:
        return history_identification_results.route(settings.arguments);

      case app_routes.plantDetails:
        return plant_details.route(settings.arguments);

      case app_routes.diseaseDetails:
        return disease_details.route(settings.arguments);

      case app_routes.addReminder:
        return add_reminder.route(settings.arguments);

      case app_routes.reminderDetails:
        return reminder_details.route(settings.arguments);

      case app_routes.addCommunityPost:
        return add_community_post.route(settings.arguments);

      case app_routes.communityPostDetails:
        return community_post_details.route(settings.arguments);

      case app_routes.collectionPlants:
        return collection_plants.route(settings.arguments);

      case app_routes.addPlantToCollection:
        return add_plant_to_collection.route(settings.arguments);

      case app_routes.suggestions:
        return suggestions.route(settings.arguments);

      case app_routes.fullGuide:
        return full_guide.route(settings.arguments);

      case app_routes.reportedPosts:
        return reported_posts.route(settings.arguments);

      case app_routes.reportedComments:
        return reported_comments.route(settings.arguments);

      case app_routes.reportedRatings:
        return reported_ratings.route(settings.arguments);

      case app_routes.reportedBotanists:
        return reported_botanists.route(settings.arguments);

      case app_routes.blockedUsers:
        return blocked_users.route(settings.arguments);

      default:
        return home.route();
    }
  }
}
