require "formula"

class Kf5Ki18n < Formula
  desc "Text internationiser for KDE"
  url "https://download.kde.org/stable/frameworks/5.111/ki18n-5.111.0.tar.xz"
  sha256 "4d0a27bdc89c9111888930ab17cb1f8416450f0baceffb6d52571e135c85df27""
  homepage "https://www.kde.org/"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build

  depends_on "qt@5"


  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
  
  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5I18n REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
