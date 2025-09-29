import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/color.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeUrl;

  const YoutubeVideoPlayer({
    super.key,
    required this.youtubeUrl,
  });

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {

  String _extractVideoId(String url) {
    // Handle different YouTube URL formats
    RegExp regExp = RegExp(
      r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)',
      caseSensitive: false,
    );
    
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  String _getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  String _getEmbedUrl(String videoId) {
    return 'https://www.youtube.com/embed/$videoId?autoplay=1&controls=1&rel=0&showinfo=0&modestbranding=1';
  }

  void _showFullScreenPlayer() {
    final videoId = _extractVideoId(widget.youtubeUrl);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenVideoPlayer(
          embedUrl: _getEmbedUrl(videoId),
          title: 'Video Player',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final videoId = _extractVideoId(widget.youtubeUrl);
    final thumbnailUrl = _getThumbnailUrl(videoId);
    
    // Responsive sizing based on device type
    final isTablet = mq.size.width > 768;
    final isLandscape = mq.orientation == Orientation.landscape;
    
    final horizontalMargin = isTablet 
        ? mq.size.width * 0.08 
        : mq.size.width * 0.04;
    
    final verticalMargin = isTablet 
        ? mq.size.height * 0.03 
        : mq.size.height * 0.015;
    
    final videoHeight = isLandscape 
        ? mq.size.height * 0.4 
        : isTablet 
            ? mq.size.height * 0.35 
            : mq.size.height * 0.25;
    
    final borderRadius = isTablet ? 16.0 : 12.0;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      height: videoHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isTablet ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // YouTube thumbnail
            Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.componentColor,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.video_library,
                    size: isTablet ? 80 : 64,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            // Play button overlay
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _showFullScreenPlayer,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      size: isTablet ? 100 : 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // YouTube logo
            Positioned(
              bottom: isTablet ? 16 : 12,
              right: isTablet ? 16 : 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 12 : 8, 
                  vertical: isTablet ? 6 : 4
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(isTablet ? 6 : 4),
                ),
                child: Text(
                  'YouTube',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Play indicator
            Positioned(
              top: isTablet ? 16 : 12,
              left: isTablet ? 16 : 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 12 : 8, 
                  vertical: isTablet ? 6 : 4
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(isTablet ? 6 : 4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: isTablet ? 20 : 16,
                    ),
                    SizedBox(width: isTablet ? 6 : 4),
                    Text(
                      'Tap untuk memutar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 14 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Full Screen Video Player Widget with WebView
class _FullScreenVideoPlayer extends StatefulWidget {
  final String embedUrl;
  final String title;

  const _FullScreenVideoPlayer({
    required this.embedUrl,
    required this.title,
  });

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // Initialize WebView controller
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.embedUrl));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isTablet = mq.size.width > 768;
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: isTablet ? 64 : 56,
        title: Text(
          'Video Player',
          style: TextStyle(
            color: Colors.white, 
            fontSize: isTablet ? 20 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close, 
            color: Colors.white,
            size: isTablet ? 28 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.open_in_new, 
              color: Colors.white,
              size: isTablet ? 26 : 22,
            ),
            onPressed: () async {
              // Open in YouTube app
              final videoId = widget.embedUrl.split('/embed/')[1].split('?')[0];
              final youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
              final uri = Uri.parse(youtubeUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.fullscreen, 
              color: Colors.white,
              size: isTablet ? 26 : 22,
            ),
            onPressed: () {
              // Toggle fullscreen
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // WebView for YouTube embed
          WebViewWidget(controller: _webViewController),
          
          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: isTablet ? 4 : 3,
                    ),
                    SizedBox(height: isTablet ? 20 : 16),
                    Text(
                      'Memuat video...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Restore portrait orientation when leaving
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
