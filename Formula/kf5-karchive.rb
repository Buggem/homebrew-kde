require_relative "../lib/cmake"

class Kf5Karchive < Formula
  desc "Archival tools for KDE frameworks"
  homepage "https://api.kde.org/frameworks/karchive/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/karchive-5.111.0.tar.xz"
  sha256 "e00e3d492882788e4289d62c6bde25e56178197de92f232a5850864ff6c2cd2d"
  head "https://invent.kde.org/frameworks/karchive.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "qt@5"


  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
  
  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Archive REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
