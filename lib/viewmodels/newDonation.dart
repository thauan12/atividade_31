import 'dart:io';
import 'package:atividade_30_05/models/Donation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationViewModel {
  final CollectionReference donationsCollection =
  FirebaseFirestore.instance.collection('donations');

  Future<void> addDonation(Donation donation) async {
    try {
      await donationsCollection.add({
        'nome': donation.nome,
        'tipo': donation.tipo,
        'condicao': donation.condicao,
        'disponivel': donation.disponivel,
        'descricao': donation.descricao,
        'dono': donation.dono,
        'foto': donation.foto,
      });
    } catch (e) {
      print('Erro ao adicionar doação: $e');
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('donation_images/$fileName');
      final firebase_storage.UploadTask uploadTask = storageReference.putFile(imageFile);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      throw Exception('Falha ao fazer upload da imagem.');
    }
  }
}