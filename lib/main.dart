import 'package:flutter/material.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/models/trufi_latlng.dart';
import 'package:trufi_core/base/utils/certificates_letsencrypt_android.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/base/widgets/screen/lifecycle_reactor_notification.dart';
import 'package:trufi_core/default_values.dart';
import 'package:trufi_core/trufi_core.dart';
import 'package:trufi_core/trufi_router.dart';
// TODO: Update example
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CertificatedLetsencryptAndroid.workAroundCertificated();
  await initHiveForFlutter();
  runApp(
    TrufiApp(
      appNameTitle: 'Angkot',
      blocProviders: [
        ...DefaultValues.blocProviders(
          otpEndpoint: "https://medan.trufi.dev/otp",
          otpGraphqlEndpoint: "https://medan.trufi.dev/otp/index/graphql",
          mapConfiguration: MapConfiguration(
            center: const TrufiLatLng(3.594582, 98.672618),
          ),
          searchAssetPath: "assets/data/search.json",
          photonUrl: "https://medan.trufi.dev/photon",
        ),
      ],
      trufiRouter: TrufiRouter(
        routerDelegate: DefaultValues.routerDelegate(
          appName: 'Angkot',
          cityName: 'Medan',
          countryName: 'Indonesia',
          backgroundImageBuilder: (_) {
            return Image.asset(
              'assets/images/drawer-bg.jpg',
              fit: BoxFit.cover,
            );
          },
          urlFeedback: 'https://example/feedback',
          emailContact: 'example@example.com',
          urlShareApp: 'https://example/share',
          urlSocialMedia: const UrlSocialMedia(
            urlFacebook: 'https://www.facebook.com/Example',
          ),
          shareBaseUri: Uri(
            scheme: "https",
            host: "medan.trufi.dev",
          ),
          lifecycleReactorHandler: LifecycleReactorNotifications(
            url:
                'https://medan.trufi.dev/static_files/notification.json',
          ),
        ),
      ),
    ),
  );
}
