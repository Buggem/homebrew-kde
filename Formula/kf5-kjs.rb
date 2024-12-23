require_relative "../lib/cmake"

class Kf5Kjs < Formula
  desc "Support for JS scripting in applications"
  homepage "https://api.kde.org/frameworks/kjs/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/portingAids/kjs-5.111.0.tar.xz"
  sha256 "0f947fb59a418362ac7bde8c4183775353c31544213c4ee45c0e3d779831cf23"
  head "https://invent.kde.org/frameworks/kjs.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "pcre"
  depends_on "qt@5"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5JS REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
