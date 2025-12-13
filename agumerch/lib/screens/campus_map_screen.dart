import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key, required this.mapUrl});

  final String mapUrl;

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  late final WebViewController? _controller;
  bool _webViewAvailable = true;

  @override
  void initState() {
    super.initState();
    // Check that a platform implementation for webview is available.
    if (WebViewPlatform.instance == null) {
      _webViewAvailable = false;
      _controller = null;
      return;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          try {
            final Uri uri = Uri.parse(request.url);
            // If the URL scheme is not http(s), open externally (maps:, intent:, market:, etc.)
            if (uri.scheme != 'http' && uri.scheme != 'https') {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
          } catch (e) {
            // If parsing fails, open externally as a fallback
            try {
              await launchUrl(Uri.parse(request.url), mode: LaunchMode.externalApplication);
            } catch (_) {}
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.mapUrl));
  }

  Future<void> _openExternally() async {
    final Uri uri = Uri.parse(widget.mapUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open maps link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Location'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _openExternally,
            tooltip: 'Open in Maps',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _webViewAvailable && _controller != null
                ? WebViewWidget(controller: _controller)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Map view is not available on this platform.'),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _openExternally,
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Open in Maps'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Location link', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                SelectableText(widget.mapUrl, style: const TextStyle(color: Colors.blue)),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: _openExternally,
                      icon: const Icon(Icons.map),
                      label: const Text('Open in Maps'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.mapUrl));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied')));
                      },
                      child: const Text('Copy link'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
