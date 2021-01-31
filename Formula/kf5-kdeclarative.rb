require_relative "../lib/cmake"

class Kf5Kdeclarative < Formula
  desc "Provides integration of QML and KDE Frameworks"
  homepage "https://api.kde.org/frameworks/kdeclarative/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kdeclarative-5.79.0.tar.xz"
  sha256 "f07b19a737cd0c5d824718332a2f20386583645fc075aca3b06d781cf7556115"
  head "https://invent.kde.org/frameworks/kdeclarative.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpackage"
  depends_on "libepoxy"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Declarative REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end

# Mark executables as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 51c04dd..f0ef51e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -48,6 +48,7 @@ include(ECMSetupVersion)
 include(ECMGenerateHeaders)
 include(CMakePackageConfigHelpers)
 include(ECMAddQch)
+include(ECMMarkNonGuiExecutable)
 
 option(BUILD_EXAMPLES "Build and install examples." OFF)
 option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
diff --git a/src/kpackagelauncherqml/CMakeLists.txt b/src/kpackagelauncherqml/CMakeLists.txt
index 7744b77..b87a5dc 100644
--- a/src/kpackagelauncherqml/CMakeLists.txt
+++ b/src/kpackagelauncherqml/CMakeLists.txt
@@ -18,4 +18,5 @@ target_link_libraries(kpackagelauncherqml
  KF5::QuickAddons
 )
 
+ecm_mark_nongui_executable(kpackagelauncherqml)
 install(TARGETS kpackagelauncherqml ${INSTALL_TARGETS_DEFAULT_ARGS})
