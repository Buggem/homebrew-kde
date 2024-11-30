require_relative "../lib/cmake"

class Kf5Kdoctools < Formula
  desc "Tools for making KDE Documentation"
  homepage "https://api.kde.org/frameworks/kdoctools/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/kdoctools-5.111.0.tar.xz"
  sha256 "39a9126a8f4067afc02b4d9afdc6cfa5fe870843678428dd3a4f14e1d2104ebe"
  head "https://invent.kde.org/frameworks/kdoctools.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "perl" => :build
  depends_on "cpanminus" => :build
  depends_on "kde-mac/kde/kf5-karchive"
  depends_on "docbook"
  depends_on "docbook-xsl"
  depends_on "gettext"

  depends_on "qt@5"


  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
  
  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Doctools REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
