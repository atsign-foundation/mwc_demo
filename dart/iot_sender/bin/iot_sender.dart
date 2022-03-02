import 'package:at_utils/at_logger.dart';
import 'package:iot_sender/at_onboarding_cli.dart';
import 'package:at_client/at_client.dart';
import 'package:at_commons/at_commons.dart' as common;

import 'package:iot_sender/iot_mqtt_listener.dart';
import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.length < 2) {
    print('Usage: iot_sender <iot @sign> <owners @sign>');
    exit(0);
  }

  AtSignLogger.root_level = 'INFO';

  final AtSignLogger logger = AtSignLogger('iot_sender');

  String atsign = arguments[0];
  String ownerAtsign = arguments[1];

  OnboardingService onboardingService = OnboardingService(atsign);
  await onboardingService.authenticate();

  var pkam = await onboardingService.privateKey();
  var encryptSelfKey = await onboardingService.selfEncryptionKey();
  var encryptPrivateKey = await onboardingService.privateEncryptionKey();
  var encryptPublicKey = await onboardingService.publicEncryptionKey();

  String namespace = 'fourballcorporate9';
  AtClientManager atClientManager = AtClientManager.getInstance();
  AtClient atClient;

  var preference = AtClientPreference()
    ..hiveStoragePath = 'lib/hive/client'
    ..commitLogPath = 'lib/hive/client/commit'
    ..isLocalStoreRequired = true
    ..privateKey = pkam

    // These can be added once in the main releases
    ..syncRequestTriggerInSeconds = 1
    ..syncRequestThreshold = 1
    ..syncRunIntervalSeconds = 1
    ..syncPageLimit = 10
    ..rootDomain = 'root.atsign.org';

  atClientManager = AtClientManager.getInstance();
  await atClientManager.setCurrentAtSign(atsign, namespace, preference);
  atClient = atClientManager.atClient;

  await atClient
      .getLocalSecondary()
      ?.putValue(common.AT_ENCRYPTION_PRIVATE_KEY, encryptPrivateKey!);

  await atClient
      .getLocalSecondary()
      ?.putValue(common.AT_ENCRYPTION_SELF_KEY, encryptSelfKey!);

  await atClient
      .getLocalSecondary()
      ?.putValue(common.AT_ENCRYPTION_PUBLIC_KEY+atsign, encryptPublicKey!);


      bool syncComplete = false;
    void onSyncDone(syncResult) {
      logger.shout("******* HELLO!!!!! ********");
      logger.info("syncResult.syncStatus: ${syncResult.syncStatus}");
      logger.info("syncResult.lastSyncedOn ${syncResult.lastSyncedOn}");
      syncComplete = true;
    }

    // Wait for initial sync to complete
    logger.info("Waiting for initial sync");
    syncComplete = false;
    atClientManager.syncService.sync(onDone: onSyncDone);
    while (! syncComplete) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    logger.info("Initial sync complete");

  logger.info('OK Ready');

  logger.info("calling iotListen atSign '$atsign', ownerAtSign '$ownerAtsign'");

  iotListen(atClientManager, atClient, atsign, ownerAtsign);
  print('listening');
}
