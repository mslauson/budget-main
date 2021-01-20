import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/institution.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/security/blossom_encryption_utility.dart';

class ModelEncryptionUtility {
  final BlossomEncryptionUtility _beu = BlossomEncryptionUtility();

  SignUpForm encryptSignUpForm(SignUpForm signUpForm) {
    return SignUpForm(
        firstName: _beu.encrypt(signUpForm.firstName),
        middleName: signUpForm.middleName == null
            ? ""
            : _beu.encrypt(signUpForm.middleName),
        lastName: _beu.encrypt(signUpForm.lastName),
        emailAddress: _beu.encrypt(signUpForm.emailAddress),
        phone: _beu.encrypt(signUpForm.phone));
  }

  GetBudgetsResponse decryptGetBudgetsResponse(GetBudgetsResponse response) {
    List<Budgets> _decryptedBudgets = List();
    response.budgets.forEach((budget) {
      _decryptedBudgets.add(Budgets(
        id: _beu.decrypt(budget.id),
        category: _beu.decrypt(budget.category),
        allocation: budget.allocation,
        dateCreated: _beu.decrypt(budget.dateCreated),
        email: _beu.decrypt(budget.email),
        linkedTransactions: _decryptLinkedTransactions(budget),
        monthYear: budget.monthYear,
        name: _beu.decrypt(budget.name),
        used: budget.used,
        visible: budget.visible,
        subCategory: _decryptSubCategory(budget),
      ));
    });
    return GetBudgetsResponse(budgets: _decryptedBudgets);
  }

  AccountsResponseModel decryptAccountsResponseModel(AccountsResponseModel accountsResponseModel) {
    List<AccountsFullModel> decryptedAccounts = List();
    accountsResponseModel.itemList.forEach((item) {
      decryptedAccounts.add(AccountsFullModel(
          id: _beu.decrypt(item.id),
          phone: _beu.decrypt(item.phone),
          accessToken: _beu.decrypt(item.accessToken),
          accounts: _decryptAccounts(item.accounts),
          deletionTimeStamp: item.deletionTimeStamp,
          flaggedForDeletion: item.flaggedForDeletion,
          institution: _decryptInstitution(item.institution),
          lastUpdated: item.lastUpdated,
          linkSessionId: _beu.decrypt(item.linkSessionId),
          needsUpdating: item.needsUpdating));
    });
    return AccountsResponseModel(itemList: decryptedAccounts);
  }

  AccessTokensResponse decryptAccessTokensResponse(
      AccessTokensResponse accessTokensResponse) {
    List<AccessTokens> accessTokenList = List();
    accessTokensResponse.accessTokens.forEach((token) {
      accessTokenList
          .add(AccessTokens(accessToken: _beu.decrypt(token.accessToken)));
    });
    return AccessTokensResponse(accessTokens: accessTokenList);
  }

  List<LinkedTransactions> _decryptLinkedTransactions(Budgets budget) {
    List<LinkedTransactions> _decryptedLinkedTransactions = List();
    budget.linkedTransactions.forEach((linkedTrans) {
      _decryptedLinkedTransactions.add(LinkedTransactions(
          transactionId: _beu.decrypt(linkedTrans.transactionId),
          amount: linkedTrans.amount));
    });
    return _decryptedLinkedTransactions;
  }

  List<LinkedTransactions> _decryptSubLinkedTransactions(SubCategory subCategory) {
    List<LinkedTransactions> _decryptedLinkedTransactions = List();
    subCategory.linkedTransactions.forEach((linkedTrans) {
      _decryptedLinkedTransactions.add(LinkedTransactions(
          transactionId: _beu.decrypt(linkedTrans.transactionId),
          amount: linkedTrans.amount));
    });
    return _decryptedLinkedTransactions;
  }

  List<SubCategory> _decryptSubCategory(Budgets budget) {
    List<SubCategory> _decryptedSubCategory = List();
    budget.subCategory.forEach((subCat) {
      _decryptedSubCategory.add(SubCategory(
          id: _beu.decrypt(subCat.id),
          visible: subCat.visible,
          used: subCat.used,
          name: _beu.decrypt(subCat.name),
          category: _beu.decrypt(subCat.category),
          allocation: subCat.allocation,
          linkedTransactions: _decryptSubLinkedTransactions(subCat)));
    });
    return _decryptedSubCategory;
  }

  List<Account> _decryptAccounts(List<Account> accounts) {
    List<Account> accountList = List();
    accounts.forEach((account) {
      accountList.add(Account(
          id: _beu.decrypt(account.id),
          name: _beu.decrypt(account.name),
          accountId: _beu.decrypt(account.accountId),
          balances: account.balances,
          mask: _beu.decrypt(account.mask),
          subtype: _beu.decrypt(account.subtype),
          type: _beu.decrypt(account.type),
          verificationStatus: _beu.decrypt(account.verificationStatus)));
    });
    return accountList;
  }

  Institution _decryptInstitution(Institution institution) {
    return Institution(
        type: _beu.decrypt(institution.type),
        name: _beu.decrypt(institution.name),
        institutionId: _beu.decrypt(institution.institutionId),
        label: _beu.decrypt(institution.label),
        logo: _beu.decrypt(institution.logo),
        primaryColor: _beu.decrypt(institution.primaryColor),
        url: _beu.decrypt(institution.url));
  }
}
