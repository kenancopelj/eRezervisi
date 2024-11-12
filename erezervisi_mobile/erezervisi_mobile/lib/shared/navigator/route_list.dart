enum AppRoutes {
  login,
  accommodationUnitDetails,
  accommodationUnits,
  chatDetails,
  chat,
  createAccommodationUnit,
  favorites,
  home,
  myReviews,
  notificationSettings,
  notifications,
  profile,
  register,
  reservationDetails,
  reservations,
  reviews,
  search,
  settings,
  searchResults,
  filterResults,
  requestCode,
  checkCode,
  resetPassword
}

extension AppRouteExtension on AppRoutes {
  String get routeName {
    switch (this) {
      case AppRoutes.login:
        return 'login';
      case AppRoutes.accommodationUnitDetails:
        return 'accommodation-unit-details';
      case AppRoutes.accommodationUnits:
        return 'accommodation-units';
      case AppRoutes.chatDetails:
        return 'chat-details';
      case AppRoutes.chat:
        return 'chat';
      case AppRoutes.createAccommodationUnit:
        return 'create-accommodation-unit';
      case AppRoutes.favorites:
        return 'favorites';
      case AppRoutes.home:
        return 'home';
      case AppRoutes.myReviews:
        return 'my-reviews';
      case AppRoutes.notificationSettings:
        return 'notification-settings';
      case AppRoutes.notifications:
        return 'notifications';
      case AppRoutes.profile:
        return 'profile';
      case AppRoutes.register:
        return 'register';
      case AppRoutes.reservationDetails:
        return 'reservation-details';
      case AppRoutes.reservations:
        return 'reservations';
      case AppRoutes.reviews:
        return 'reviews';
      case AppRoutes.search:
        return 'search';
      case AppRoutes.settings:
        return 'settings';
      case AppRoutes.searchResults:
        return 'search-results';
      case AppRoutes.filterResults:
        return 'filter-results';
      case AppRoutes.requestCode:
        return 'request-code';
      case AppRoutes.checkCode:
        return 'check-code';
      case AppRoutes.resetPassword:
        return 'reset-password';
      default:
        return '/';
    }
  }
}
