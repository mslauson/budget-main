import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:main/client/plaidMicroserviceClient.dart';
import 'package:main/constants/plaidConstants.dart';
import 'package:main/model/plaid/plaidLinkResponse.dart';
import 'package:main/model/plaid/tokenExchangeResponse.dart';

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
      body: WebView(
        navigationDelegate: (NavigationRequest request) =>
            _processNavigationRequest(request),
        debuggingEnabled: true,
        initialUrl: widget.websiteUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

_processNavigationRequest(NavigationRequest request) async {
  String url = request.url;
  if (url.startsWith(PlaidConstants.PLAID_LINK_URI)) {
    print('blocking navigation to $request');
    if (url.contains(PlaidConstants.PLAID_CONNECTED_EVENT)) {
      print(url);
      PlaidLinkResponse linkResponse = await _processConnectedUri(url);
    }
    return NavigationDecision.prevent;
  }

  print('allowing navigation to $request');
  return NavigationDecision.navigate;
}

Future<PlaidLinkResponse> _processConnectedUri(String url) async {
  Uri uri = Uri.dataFromString(url);
  PlaidLinkResponse linkResponse = new PlaidLinkResponse();
  Institution institution = new Institution();
  institution.institutionId = Uri.base.queryParameters['institution_id'];
  institution.name = Uri.base.queryParameters['institution_name'];
  linkResponse.accessToken = await getAccessToken(Uri.base.queryParameters['public_token']);
  linkResponse.institution=institution;
  linkResponse.linkSessionId = Uri.base.queryParameters['link_session_id'];
  return linkResponse;
}

Future<String> getAccessToken(String publicToken) async {
 TokenExchangeResponse response = await PlaidMicroserviceClient.exchangeToken(publicToken);
 return response.accessToken;

}
