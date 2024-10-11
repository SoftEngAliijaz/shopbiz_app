enum SocialIcon {
  facebook,
  github,
  instagram,
  linkedin,
}

extension SocialIconAsset on SocialIcon {
  String get asset {
    switch (this) {
      case SocialIcon.facebook:
        return 'assets/social_logos/facebook_logo.svg';
      case SocialIcon.github:
        return 'assets/social_logos/github_logo.svg';
      case SocialIcon.instagram:
        return 'assets/social_logos/instagram_logo.svg';
      case SocialIcon.linkedin:
        return 'assets/social_logos/linkedin_logo.svg';
    }
  }

  String get url {
    switch (this) {
      case SocialIcon.facebook:
        return 'https://www.facebook.com/';
      case SocialIcon.github:
        return 'https://www.github.com/';
      case SocialIcon.instagram:
        return 'https://www.instagram.com/';
      case SocialIcon.linkedin:
        return 'https://www.linkedin.com/in/';
    }
  }
}
