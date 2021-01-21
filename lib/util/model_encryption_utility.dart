import 'package:main/models/accounts/AccessTokensResponse.dart';
import 'package:main/models/accounts/account.dart';
import 'package:main/models/accounts/account_meta.dart';
import 'package:main/models/accounts/accounts_full_model.dart';
import 'package:main/models/accounts/delete_account_request_model.dart';
import 'package:main/models/accounts/institution.dart';
import 'package:main/models/accounts/response/account_meta_response.dart';
import 'package:main/models/accounts/response/accounts_response.dart';
import 'package:main/models/accounts/update_accounts_request_model.dart';
import 'package:main/models/budget/getBudgetsResponse.dart';
import 'package:main/models/iam/signUpForm.dart';
import 'package:main/models/transactions/transactions_get_response.dart';
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

  AccountsResponseModel decryptAccountsResponseModel(
      AccountsResponseModel accountsResponseModel) {
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

  AccountMetaResponse decryptAccountMetaResponse(
      AccountMetaResponse accountMetaResponse) {
    List<AccountMeta> metaList = List();
    accountMetaResponse.accountMetaList.forEach((meta) {
      metaList.add(AccountMeta(
          accountId: _beu.decrypt(meta.accountId),
          accountName: _beu.decrypt(meta.accountName),
          accountNumber: _beu.decrypt(meta.accountNumber)));
    });
    return AccountMetaResponse(accountMetaList: metaList);
  }

  AccountsFullModel encryptAccountsFullModel(AccountsFullModel fullModel) {
    return AccountsFullModel(
        accessToken: _beu.encrypt(fullModel.accessToken),
        needsUpdating: fullModel.needsUpdating,
        linkSessionId: _beu.encrypt(fullModel.linkSessionId),
        lastUpdated: fullModel.lastUpdated,
        institution: _encryptInstitution(fullModel.institution),
        flaggedForDeletion: fullModel.flaggedForDeletion,
        deletionTimeStamp: fullModel.deletionTimeStamp,
        accounts: _encryptAccounts(fullModel.accounts),
        id: _beu.encrypt(fullModel.id),
        phone: _beu.encrypt(fullModel.phone));
  }

  AccountsFullModel decryptAccountsFullModel(AccountsFullModel fullModel) {
    return AccountsFullModel(
        accessToken: _beu.decrypt(fullModel.accessToken),
        needsUpdating: fullModel.needsUpdating,
        linkSessionId: _beu.decrypt(fullModel.linkSessionId),
        lastUpdated: fullModel.lastUpdated,
        institution: _decryptInstitution(fullModel.institution),
        flaggedForDeletion: fullModel.flaggedForDeletion,
        deletionTimeStamp: fullModel.deletionTimeStamp,
        accounts: _decryptAccounts(fullModel.accounts),
        id: _beu.decrypt(fullModel.id),
        phone: _beu.decrypt(fullModel.phone));
  }

  DeleteAccountRequestModel encryptDeleteAccountModel(
      DeleteAccountRequestModel deleteAccountRequestModel) {
    return DeleteAccountRequestModel(
        phone: _beu.encrypt(deleteAccountRequestModel.phone),
        accountId: _beu.encrypt(deleteAccountRequestModel.accountId));
  }

  UpdateAccountRequestModel encryptUpdateAccountModel(
      UpdateAccountRequestModel updateAccountRequestModel) {
    return UpdateAccountRequestModel(
      phone: _beu.encrypt(updateAccountRequestModel.phone),
      id: _beu.encrypt(updateAccountRequestModel.id),
      accessToken: _beu.encrypt(updateAccountRequestModel.accessToken),
    );
  }

  TransactionsGetResponse decryptTransactionsGetResponse(
      TransactionsGetResponse getResponse) {
    getResponse
    .
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

  List<LinkedTransactions> _decryptSubLinkedTransactions(
      SubCategory subCategory) {
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

  List<Account> _encryptAccounts(List<Account> accounts) {
    List<Account> accountList = List();
    accounts.forEach((account) {
      accountList.add(Account(
          id: _beu.encrypt(account.id),
          name: _beu.encrypt(account.name),
          accountId: _beu.encrypt(account.accountId),
          balances: account.balances,
          mask: _beu.encrypt(account.mask),
          subtype: _beu.encrypt(account.subtype),
          type: _beu.encrypt(account.type),
          verificationStatus: _beu.encrypt(account.verificationStatus)));
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

  Institution _encryptInstitution(Institution institution) {
    return Institution(
        type: _beu.encrypt(institution.type),
        name: _beu.encrypt(institution.name),
        institutionId: _beu.encrypt(institution.institutionId),
        label: _beu.encrypt(institution.label),
        logo: _beu.encrypt(institution.logo),
        primaryColor: _beu.encrypt(institution.primaryColor),
        url: _beu.encrypt(institution.url));
  }

  List<Transactions> _decryptTransactions(List<Transactions> transactions) {
    List<Transactions> decryptedTransactions = List();
    transactions.forEach((transaction) {
      decryptedTransactions.add(
          Transactions(
              phone: _beu.decrypt(transaction.phone),
              accountId: _beu.decrypt(transaction.accountId),
              deletionTimeStamp: transaction.deletionTimeStamp,
              flaggedForDeletion: transaction.flaggedForDeletion,
              lastUpdated: transaction.lastUpdated,
              amount: transaction.amount,
              transactionId: _beu.decrypt(transaction.transactionId),
              authorizationDate: transaction.authorizationDate,
              budgetId: _beu.decrypt(transaction.budgetId),
              categories: _decryptListOfStrings(transaction.categories),
              categoryId: _beu.decrypt(transaction.categoryId),
              creationTimeStamp: transaction.creationTimeStamp,
              date: transaction.date,
              isoCurrencyCode: transaction.isoCurrencyCode,
              isPending: transaction.isPending,
              location: _decryptLocation(transaction.location),
              merchant: _beu.decrypt(transaction.merchant),
              notes: _beu.decrypt(transaction.notes),
              paymentMeta: _decryptPaymentMeta(transaction.paymentMeta),
              pendingTransactionId: _beu.decrypt(
                  transaction.pendingTransactionId),
              reimbursement: _decryptReimbursement(transaction.reimbursement),
              subBudgetId: _beu.decrypt(transaction.subBudgetId),
              tags: _beu.decrypt(transaction.tags),
              transacionType: _beu.decrypt(transaction.transacionType)
          )
      );
    });
  }

  List<String> _decryptListOfStrings(List<String> categories) {
    List<String> decryptedCategories = List();
    categories.forEach((element) {
      decryptedCategories.add(
        _beu.decrypt(element),
      );
    });
    return decryptedCategories;
  }

  Location _decryptLocation(Location location) {
    return Location(
        address: _beu.decrypt(location.address),
        city: _beu.decrypt(location.city),
        country: _beu.decrypt(location.country),
        lat: location.lat,
        lon: location.lon,
        postalCode: _beu.decrypt(location.postalCode),
        region: _beu.decrypt(location.region),
        storeNumber: _beu.decrypt(location.storeNumber)
    );
  }

  PaymentMeta _decryptPaymentMeta(PaymentMeta paymentMeta) {
    return PaymentMeta(
        byOrderOf: _beu.decrypt(paymentMeta.byOrderOf),
        payee: _beu.decrypt(paymentMeta.payee),
        payer: _beu.decrypt(paymentMeta.payer),
        paymentMethod: _beu.decrypt(paymentMeta.paymentMethod),
        paymentProcessor: _beu.decrypt(paymentMeta.paymentProcessor),
        ppdId: _beu.decrypt(paymentMeta.ppdId),
        reason: _beu.decrypt(paymentMeta.reason),
        referenceNumber: _beu.decrypt(paymentMeta.referenceNumber)
    );
  }

  Reimbursement _decryptReimbursement(Reimbursement reimbursement) {
    return Reimbursement(
        amount: reimbursement.amount,
        linkedTransactions: _decryptListOfStrings(
            reimbursement.linkedTransactions),
        reimbursed: reimbursement.reimbursed
    );
  }
}
