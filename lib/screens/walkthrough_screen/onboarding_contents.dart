class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to inSetu –\n Your Construction Site Companion",
    image: "assets/icons/image1.png",
    desc: "Manage site reports, stock, and documents — all in one app.",
  ),
  OnboardingContents(
    title: "Never Lose Your Site Drawings Again",
    image: "assets/icons/image2.png",
    desc:
    "Upload and access site documents anytime, from anywhere.",
  ),
  OnboardingContents(
    title: "Track Stock in Real Time",
    image: "assets/icons/image3.png",
    desc:
    "Update and monitor material inward/outward with full transparency.",
  ),
  OnboardingContents(
    title: "Log Daily Progress in 30 Seconds",
    image: "assets/icons/image2.png",
    desc:
    "Add manpower, work status, and photos directly from site.",
  ),
];