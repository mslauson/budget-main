import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/security/blossom_encryption_utility.dart';

class ModelEncryptionUtility {
  final BlossomEncryptionUtility beu = BlossomEncryptionUtility();

  SignUpForm encryptSignUpForm(SignUpForm signUpForm) {
    return SignUpForm(
        firstName: beu.encrypt(signUpForm.firstName),
        middleName: signUpForm.middleName == null
            ? ""
            : beu.encrypt(signUpForm.middleName),
        lastName: beu.encrypt(signUpForm.lastName),
        emailAddress: beu.encrypt(signUpForm.emailAddress),
        phone: beu.encrypt(signUpForm.phone));
  }

  GetBudgetsResponse decryptGetBudgetsResponse(GetBudgetsResponse response) {
    List<Budgets> _decryptedBudgets = List();
    response.budgets.forEach((budget) {
      _decryptedBudgets.add(Budgets(
        id: beu.decrypt(budget.id),
        category: beu.decrypt(budget.category),
        allocation: budget.allocation,
        dateCreated: beu.decrypt(budget.dateCreated),
        email: beu.decrypt(budget.email),
        linkedTransactions: _decryptLinkedTransactions(budget),
        monthYear: budget.monthYear,
        name: beu.decrypt(budget.name),
        used: budget.used,
        visible: budget.visible,
        subCategory: _decryptSubCategory(budget),
      ));
    });
    return GetBudgetsResponse(budgets: _decryptedBudgets);
  }

  List<LinkedTransactions> _decryptLinkedTransactions(Budgets budget) {
    List<LinkedTransactions> _decryptedLinkedTransactions = List();
    budget.linkedTransactions.forEach((linkedTrans) {
      _decryptedLinkedTransactions.add(LinkedTransactions(
          transactionId: beu.decrypt(linkedTrans.transactionId),
          amount: linkedTrans.amount));
    });
    return _decryptedLinkedTransactions;
  }

  List<LinkedTransactions> _decryptSubLinkedTransactions(
      SubCategory subCategory) {
    List<LinkedTransactions> _decryptedLinkedTransactions = List();
    subCategory.linkedTransactions.forEach((linkedTrans) {
      _decryptedLinkedTransactions.add(LinkedTransactions(
          transactionId: beu.decrypt(linkedTrans.transactionId),
          amount: linkedTrans.amount));
    });
    return _decryptedLinkedTransactions;
  }

  List<SubCategory> _decryptSubCategory(Budgets budget) {
    List<SubCategory> _decryptedSubCategory = List();
    budget.subCategory.forEach((subCat) {
      _decryptedSubCategory.add(SubCategory(
          id: beu.decrypt(subCat.id),
          visible: subCat.visible,
          used: subCat.used,
          name: beu.decrypt(subCat.name),
          category: beu.decrypt(subCat.category),
          allocation: subCat.allocation,
          linkedTransactions: _decryptSubLinkedTransactions(subCat)));
    });
    return _decryptedSubCategory;
  }
}
