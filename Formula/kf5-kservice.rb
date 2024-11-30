require_relative "../lib/cmake"

class Kf5Kservice < Formula
  desc "Advanced plugin and service introspection"
  homepage "https://api.kde.org/frameworks/kservice/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/kservice-5.111.0.tar.xz"
  sha256 "6cd0b7eabec1f8deff92cf2436e35eb0b59d543fc6f70ba6d392a41ec4ad2e12"
  head "https://invent.kde.org/frameworks/kservice.git", branch: "master"

  depends_on "bison" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "flex" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcrash"
  depends_on "kde-mac/kde/kf5-kdbusaddons"
  depends_on "kde-mac/kde/kf5-ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Service REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
