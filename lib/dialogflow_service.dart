import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';

class DialogflowService {
  late DialogflowGrpcV2 dialogflow;
  late Map<String, dynamic> serviceAccount;

  DialogflowService._privateConstructor();
  static final DialogflowService instance =
      DialogflowService._privateConstructor();

  /// Initialise le service Dialogflow avec les identifiants JSON
  Future<void> init() async {
    try {
      // Charger le fichier JSON avec les informations d'authentification
      final jsonString = await rootBundle.loadString(
        'assets/smartpot-chatbot-b8c9c78aec39.json',
      );
      serviceAccount = json.decode(jsonString);

      // Créer l'objet ServiceAccount attendu par DialogflowGrpc
      final sa = ServiceAccount.fromString(json.encode(serviceAccount));

      // Initialiser Dialogflow
      dialogflow = DialogflowGrpcV2.viaServiceAccount(sa);
    } catch (e) {
      debugPrint('Erreur d\'initialisation de Dialogflow : $e');
      rethrow;
    }
  }

  /// Envoie un message à Dialogflow et retourne la réponse texte
  Future<String> sendMessageToDialogflow(String message) async {
    try {
      final response = await dialogflow.detectIntent(message, 'en-US');
      return response.queryResult.fulfillmentText;
    } catch (e) {
      debugPrint('Erreur lors de l\'envoi du message : $e');
      return 'Désolé, une erreur est survenue.';
    }
  }
}
