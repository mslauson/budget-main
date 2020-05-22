import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main/client/plaidMicroserviceClient.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/model/global/activeUser.dart';
import 'package:main/model/plaid/genericStatusResponseModel.dart';
import 'package:main/model/plaid/plaidLinkResponse.dart';
import 'package:main/model/plaid/tokenExchangeResponse.dart';
import 'package:main/ui/secureHome/secureHome.dart';
import 'package:scoped_model/scoped_model.dart';

//Webview in flutter
import 'package:webview_flutter/webview_flutter.dart';

class PlaidLinkWebView extends StatefulWidget {
  final String websiteName;
  final String websiteUrl;

  const PlaidLinkWebView({Key key, this.websiteName, this.websiteUrl})
      : super(key: key);

  @override
  _PlaidLinkWebViewState createState() => _PlaidLinkWebViewState();
}

class _PlaidLinkWebViewState extends State<PlaidLinkWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<ActiveUser>(
          builder: (BuildContext context, Widget child, ActiveUser model) {
        return WebView(
          navigationDelegate: (NavigationRequest request) =>
              _processNavigationRequest(request, model, context),
          debuggingEnabled: true,
          initialUrl: widget.websiteUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        );
      }),
    );
  }
}

_processNavigationRequest(NavigationRequest request, ActiveUser model, BuildContext context) async {
  String url = request.url;
  if (url.startsWith(PlaidConstants.PLAID_LINK_URI)) {
    print('blocking navigation to $request');
    if (url.contains(PlaidConstants.PLAID_CONNECTED_EVENT)) {
      print(url);
      PlaidLinkResponse linkResponse = await _processConnectedUri(url);
      linkResponse.email=model.email;
      addAccounts(linkResponse).catchError((Object error){
        Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3
        );
      }).whenComplete((){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              new SecureHome()),
        );
      });
    }
    return NavigationDecision.prevent;
  }

  print('allowing navigation to $request');
  return NavigationDecision.navigate;
}

Future<PlaidLinkResponse> _processConnectedUri(String url) async {
  String decoded = Uri.decodeFull(url);
  Uri uri = Uri.dataFromString(decoded);
  PlaidLinkResponse linkResponse = new PlaidLinkResponse();
  Institution institution = new Institution();
  institution.institutionId = uri.queryParameters['institution_id'];
  institution.name = uri.queryParameters['institution_name'];
  linkResponse.accessToken =
      await getAccessToken(uri.queryParameters['public_token']);
  linkResponse.institution = institution;
  linkResponse.linkSessionId = uri.queryParameters['link_session_id'];
  return linkResponse;
}

Future<String> getAccessToken(String publicToken) async {
  TokenExchangeResponse response =
      await PlaidMicroserviceClient.exchangeToken(publicToken);
  return response.accessToken;
}

Future<bool> addAccounts(PlaidLinkResponse request) async{
  String payload = jsonEncode(request.toJson());
  return await PlaidMicroserviceClient.addAccounts(payload);
}
