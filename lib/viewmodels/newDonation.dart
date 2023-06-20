import 'dart:io';
import 'package:atividade_30_05/models/Donation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class DonationController extends GetxController {
  File? file;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      file = File(pickedImage.path);
      update();
    } else {
      print('Nenhuma imagem selecionada');
    }
  }

  Future<String> uploadImage(File? file) async {
    String downloadURL = '';
    if (file == null) {
      return 'Arquivo está vazio';
    }
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      var fileName = 'imagem_$timestamp.${file.path.split('/').last}';

      var storageReference = FirebaseStorage.instance
          .ref()
          .child('imagensDoação/$fileName');

      await storageReference.putFile(file);
      downloadURL = await storageReference.getDownloadURL();
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
    }

    return downloadURL;
  }

  Future<void> addDonation(context, doacao) async {
    if (doacao == null) {
      return;
    }
    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    try {
      await donations.add(doacao!.toMap());
    } catch (e) {
      print('Erro ao adicionar doação: $e');
    }
  }

  Future<List<Donation>> listDonationsUser({required String email}) async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await db
        .collection('donations')
        .where('dono', isEqualTo: email)
        .where('disponivel', isEqualTo: 'Sim')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((doc) {
        final data = doc.data();
        if (data != null) {
          return Donation.fromJson(data as Map<String, dynamic>, doc.id);
        } else {
          throw Exception('Data is null');
        }
      })
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Donation>> listOtherDonations({required String email}) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('donations')
        .where('dono', isNotEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((doc) {
        final data = doc.data();
        if (data != null) {
          return Donation.fromJson(data as Map<String, dynamic>, doc.id);
        } else {
          throw Exception('Data is null');
        }
      })
          .toList();
    } else {
      return [];
    }
  }
}

Future<Donation> criarDoacao(context, String nome, String tipo, String condicao,
    String disponivel, String descricao, String dono, String urldaDoacao) async {
  var doacao = Donation(
      nome: '${nome}',
      tipo: '${tipo}',
      condicao: '${condicao}',
      disponivel: '${disponivel}',
      descricao: '${descricao}',
      dono: '${dono}',
      foto: '${urldaDoacao}');
  return doacao;
}
