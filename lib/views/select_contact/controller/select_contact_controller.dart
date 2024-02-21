import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/select_contact_repo.dart';

final getContacts = FutureProvider((ref) {
  final selectContactRepo = ref.watch(selectContactRepoProvider);

  return selectContactRepo.getContacts();
});
