/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon-adaptive.png
  AssetGenImage get appIconAdaptive => const AssetGenImage('assets/images/app_icon-adaptive.png');

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/ic_profile_placeholder.png
  AssetGenImage get icProfilePlaceholder => const AssetGenImage('assets/images/ic_profile_placeholder.png');

  /// File path: assets/images/ic_profile_placeholder_large.png
  AssetGenImage get icProfilePlaceholderLarge => const AssetGenImage('assets/images/ic_profile_placeholder_large.png');

  $AssetsImagesLoginRegisterScreenGen get loginRegisterScreen => const $AssetsImagesLoginRegisterScreenGen();

  /// File path: assets/images/logo_horizontal_white.svg
  SvgGenImage get logoHorizontalWhite => const SvgGenImage('assets/images/logo_horizontal_white.svg');

  $AssetsImagesShowsGen get shows => const $AssetsImagesShowsGen();

  /// File path: assets/images/splash_logo.png
  AssetGenImage get splashLogo => const AssetGenImage('assets/images/splash_logo.png');

  /// File path: assets/images/welcome_icon.svg
  SvgGenImage get welcomeIcon => const SvgGenImage('assets/images/welcome_icon.svg');
}

class $AssetsImagesLoginRegisterScreenGen {
  const $AssetsImagesLoginRegisterScreenGen();

  /// File path: assets/images/login_register_screen/hide_icon.svg
  SvgGenImage get hideIcon => const SvgGenImage('assets/images/login_register_screen/hide_icon.svg');

  /// File path: assets/images/login_register_screen/login_top_left.svg
  SvgGenImage get loginTopLeft => const SvgGenImage('assets/images/login_register_screen/login_top_left.svg');

  /// File path: assets/images/login_register_screen/login_top_right.svg
  SvgGenImage get loginTopRight => const SvgGenImage('assets/images/login_register_screen/login_top_right.svg');

  /// File path: assets/images/login_register_screen/show_icon.svg
  SvgGenImage get showIcon => const SvgGenImage('assets/images/login_register_screen/show_icon.svg');
}

class $AssetsImagesShowsGen {
  const $AssetsImagesShowsGen();

  /// File path: assets/images/shows/blood_aint_water.png
  AssetGenImage get bloodAintWater => const AssetGenImage('assets/images/shows/blood_aint_water.png');

  /// File path: assets/images/shows/ic_shows_empty_state.svg
  SvgGenImage get icShowsEmptyState => const SvgGenImage('assets/images/shows/ic_shows_empty_state.svg');

  /// File path: assets/images/shows/stranger_things.png
  AssetGenImage get strangerThings => const AssetGenImage('assets/images/shows/stranger_things.png');

  /// File path: assets/images/shows/the_sopranos.jpg
  AssetGenImage get theSopranos => const AssetGenImage('assets/images/shows/the_sopranos.jpg');

  /// File path: assets/images/shows/ured.png
  AssetGenImage get ured => const AssetGenImage('assets/images/shows/ured.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
