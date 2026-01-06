import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forget_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/otp_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/driver/add_fuel_log/bindings/add_fuel_log_binding.dart';
import '../modules/driver/add_fuel_log/views/add_fuel_log_view.dart';
import '../modules/driver/incident_report/bindings/incident_report_binding.dart';
import '../modules/driver/incident_report/views/incident_report_view.dart';
import '../modules/driver/vehicle_checklist/bindings/vehicle_checklist_binding.dart';
import '../modules/driver/vehicle_checklist/views/vehicle_checklist_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding/views/role_selection_view.dart';
import '../modules/rider/drivers_list/bindings/drivers_list_binding.dart';
import '../modules/rider/drivers_list/views/drivers_list_view.dart';
import '../modules/rider/home/bindings/home_binding.dart';
import '../modules/rider/home/views/home_view.dart';
import '../modules/rider/hourly_reservation/bindings/hourly_reservation_binding.dart';
import '../modules/rider/hourly_reservation/views/hourly_reservation_view.dart';
import '../modules/rider/point_to_point/bindings/point_to_point_binding.dart';
import '../modules/rider/point_to_point/views/point_to_point_view.dart';
import '../modules/rider/rate_driver/bindings/rate_driver_binding.dart';
import '../modules/rider/rate_driver/views/rate_driver_view.dart';
import '../modules/rider/receipt/bindings/receipt_binding.dart';
import '../modules/rider/receipt/views/receipt_view.dart';
import '../modules/rider/ride_booked/bindings/ride_booked_binding.dart';
import '../modules/rider/ride_booked/views/ride_booked_view.dart';
import '../modules/rider/ride_history/bindings/ride_history_binding.dart';
import '../modules/rider/ride_history/views/ride_history_view.dart';
import '../modules/rider/search/bindings/search_binding.dart';
import '../modules/rider/search/views/search_view.dart';
import '../modules/shared/chat/bindings/chat_binding.dart';
import '../modules/shared/chat/views/chat_view.dart';
import '../modules/shared/notifications/bindings/notifications_binding.dart';
import '../modules/shared/notifications/views/notifications_view.dart';
import '../modules/shared/payment_method/bindings/payment_method_binding.dart';
import '../modules/shared/payment_method/views/payment_method_view.dart';
import '../modules/shared/pricing_summary/bindings/pricing_summary_binding.dart';
import '../modules/shared/pricing_summary/views/pricing_summary_view.dart';
import '../modules/shared/profile/bindings/profile_binding.dart';
import '../modules/shared/profile/views/profile_view.dart';
import '../modules/shared/settings/bindings/settings_binding.dart';
import '../modules/shared/settings/views/settings_view.dart';
import '../modules/shared/wallet/bindings/wallet_binding.dart';
import '../modules/shared/wallet/views/wallet_view.dart';
import '../modules/driver/ride_info/bindings/ride_info_binding.dart';
import '../modules/driver/ride_info/views/ride_info_view.dart';
import '../modules/driver/active_ride/bindings/active_ride_binding.dart';
import '../modules/driver/active_ride/views/active_ride_view.dart';
import '../modules/driver/dropoff_navigation/bindings/dropoff_navigation_binding.dart';
import '../modules/driver/dropoff_navigation/views/dropoff_navigation_view.dart';
import '../modules/driver/request_detail/bindings/request_detail_binding.dart';
import '../modules/driver/request_detail/views/request_detail_view.dart';
import '../modules/driver/accepted_request/bindings/accepted_request_binding.dart';
import '../modules/driver/accepted_request/views/accepted_request_view.dart';
import '../modules/driver/during_ride/bindings/during_ride_binding.dart';
import '../modules/driver/during_ride/views/during_ride_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ROLESELECTION,
      page: () => const RoleSelectionView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(name: _Paths.OTP, page: () => OtpView(), binding: AuthBinding()),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.WALLET,
          page: () => WalletView(),
          binding: WalletBinding(),
        ),
        GetPage(
          name: _Paths.RIDE_HISTORY,
          page: () => RideHistoryView(),
          binding: RideHistoryBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => const SettingsView(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: _Paths.NOTIFICATIONS,
          page: () => NotificationsView(),
          binding: NotificationsBinding(),
        ),
        GetPage(
          name: _Paths.SEARCH,
          page: () => SearchView(),
          binding: SearchBinding(),
        ),
        GetPage(
          name: _Paths.POINT_TO_POINT,
          page: () => const PointToPointView(),
          binding: PointToPointBinding(),
        ),
        GetPage(
          name: _Paths.DRIVERS_LIST,
          page: () => const DriversListView(),
          binding: DriversListBinding(),
        ),
        GetPage(
          name: _Paths.RIDE_BOOKED,
          page: () => const RideBookedView(),
          binding: RideBookedBinding(),
        ),
        GetPage(
          name: _Paths.CHAT,
          page: () => const ChatView(),
          binding: ChatBinding(),
        ),
        GetPage(
          name: _Paths.RECEIPT,
          page: () => const ReceiptView(),
          binding: ReceiptBinding(),
        ),
        GetPage(
          name: _Paths.RATE_DRIVER,
          page: () => const RateDriverView(),
          binding: RateDriverBinding(),
        ),
        GetPage(
          name: _Paths.PAYMENT_METHOD,
          page: () => const PaymentMethodView(),
          binding: PaymentMethodBinding(),
        ),
        GetPage(
          name: _Paths.HOURLY_RESERVATION,
          page: () => const HourlyReservationView(),
          binding: HourlyReservationBinding(),
        ),
        GetPage(
          name: _Paths.PRICING_SUMMARY,
          page: () => const PricingSummaryView(),
          binding: PricingSummaryBinding(),
        ),
      ],
    ),
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.ADD_FUEL_LOG,
      page: () => AddFuelLogView(),
      binding: AddFuelLogBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_CHECKLIST,
      page: () => VehicleChecklistView(),
      binding: VehicleChecklistBinding(),
    ),
    GetPage(
      name: _Paths.INCIDENT_REPORT,
      page: () => IncidentReportView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_INFO,
      page: () => const RideInfoView(),
      binding: RideInfoBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_RIDE,
      page: () => const ActiveRideView(),
      binding: ActiveRideBinding(),
    ),
    GetPage(
      name: _Paths.DROPOFF_NAVIGATION,
      page: () => const DropoffNavigationView(),
      binding: DropoffNavigationBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_DETAIL,
      page: () => const RequestDetailView(),
      binding: RequestDetailBinding(),
    ),
    GetPage(
      name: _Paths.ACCEPTED_REQUEST,
      page: () => const AcceptedRequestView(),
      binding: AcceptedRequestBinding(),
    ),
    GetPage(
      name: _Paths.DURING_RIDE,
      page: () => const DuringRideView(),
      binding: DuringRideBinding(),
    ),
  ];
}
