require_relative "../lib/cmake"

class Poxml < Formula
  desc "Translates DocBook XML files using gettext po files"
  homepage "https://www.kde.org/applications/development/"
  url "https://download.kde.org/stable/release-service/21.08.1/src/poxml-21.08.1.tar.xz"
  sha256 "952b858ce9dbb6bdb1ff79fac8dc1834c65dcf823a284f6a38532e0eebca9c83"
  head "https://invent.kde.org/sdk/poxml.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "kdoctools"
  depends_on "qt@5"

  patch :DATA

  def install
    args = kde_cmake_args
    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_includes "english-XML", `$(brew --prefix)/opt/poxml/bin/po2xml.app/Contents/MacOS/po2xml`
  end
end

# Mark executables as nongui type

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9d6ea4e..c7a87fe 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -8,6 +8,7 @@ set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_D
 include(FeatureSummary)
 include(ECMAddAppIcon)
 include(ECMInstallIcons)
+include(ECMMarkNonGuiExecutable)
 include(KDEInstallDirs)
 include(KDECompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -37,6 +38,8 @@ add_executable(split2po ${split2po_SRCS})
 
 target_link_libraries(split2po ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(split2po)
+
 install(TARGETS split2po  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -49,6 +52,8 @@ add_executable(xml2pot ${xml2pot_SRCS})
 
 target_link_libraries(xml2pot ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(xml2pot)
+
 install(TARGETS xml2pot  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -64,6 +69,8 @@ add_executable(po2xml ${po2xml_SRCS})
 
 target_link_libraries(po2xml ${GETTEXTPO_LIBRARY} Qt5::Xml Qt5::Core)
 
+ecm_mark_nongui_executable(po2xml)
+
 install(TARGETS po2xml  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 
@@ -78,6 +85,8 @@ add_executable(swappo ${swappo_SRCS})
 
 target_link_libraries(swappo ${GETTEXTPO_LIBRARY})
 
+ecm_mark_nongui_executable(swappo)
+
 install(TARGETS swappo  ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
