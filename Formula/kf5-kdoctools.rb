require_relative "../lib/cmake"

class Kf5Kdoctools < Formula
  desc "Documentation generation from docbook"
  homepage "https://api.kde.org/frameworks/kdoctools/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kdoctools-5.79.0.tar.xz"
  sha256 "ebc37ba10261fc05808ae332260eabfc86705b1d0cf906b529ca7099df907b0d"
  head "https://invent.kde.org/frameworks/kdoctools.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-ki18n" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build

  depends_on "docbook-xsl"
  depends_on "kde-karchive"
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    args = kde_cmake_args

    system "cmake", *args
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
    (testpath/"CMakeLists.txt").write("find_package(KF5DocTools REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
