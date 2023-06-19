import 'package:atividade_30_05/models/Donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationListViewModel {
  Future<List<Donation>> getDoacoesDisponiveis(String userEmail) async {
    final List<Donation> availableDonations = await getAvailableDonations();

    // Filtrar as doações pelo email do usuário
    final List<Donation> userDonations = availableDonations
        .where((donation) => donation.dono == userEmail)
        .toList();

    return userDonations;
  }

  Future<List<Donation>> getAvailableDonations() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('donations')
        .where('disponivel', isEqualTo: 'Sim')
        .get();

    final List<Donation> donations = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Donation.fromMap(data);
    }).toList();

    return donations;
  }
}