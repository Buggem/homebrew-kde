require_relative "../lib/cmake"

class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/20.12.2/src/kimap-20.12.2.tar.xz"
  sha256 "ad809073b32a98b07d08bff09d3ac687d8121c1f278facffc8cee2b08c7d7292"
  head "https://invent.kde.org/pim/kimap.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kmime"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5IMAP REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
