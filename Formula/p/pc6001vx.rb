class Pc6001vx < Formula
  desc "PC-6001 emulator"
  # http://eighttails.seesaa.net/ gives 405 error
  homepage "https://github.com/eighttails/PC6001VX"
  license "LGPL-2.1-or-later"
  revision 1
  head "https://github.com/eighttails/PC6001VX.git", branch: "master"

  stable do
    url "https://eighttails.up.seesaa.net/bin/PC6001VX_4.2.5_src.tar.gz"
    sha256 "4f44df8940db6d412bf4d316c950c540f03c5ab543b028b793998bfeeaac64ac"

    # backport a fix for incorrectly handling SIGTERM
    patch do
      url "https://github.com/eighttails/PC6001VX/commit/93f2a366d1944237d4712a6de4290ac1bda15771.patch?full_index=1"
      sha256 "f4e9d7f23ec7d0f87d869cfcef84de80f1371cc703600313a00970f84d77c632"
    end
  end

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "58618f072671e7dbe6721691a737600c9c7e063fdd51e1eebf042372ddff77ab"
    sha256 cellar: :any, arm64_ventura:  "f6307dcaed2bbc05d3c42f119540b2b541d246edcaca51f6b106da6eae28ffd0"
    sha256 cellar: :any, arm64_monterey: "51c6e2cf8ada814c83132e0868be43e740aa8fcd9ab6f8dbf5ac13f76fbdd736"
    sha256 cellar: :any, sonoma:         "5a62bee188b5bc8c44a46055b03d9561dad1b7f6cae94a7267539da4cf2797cf"
    sha256 cellar: :any, ventura:        "c14b25c52c6b649ebe4ec841f731008ad0f8d45fb680b4e7466e19f1e8066524"
    sha256 cellar: :any, monterey:       "6296a3e8d539a31c7d8717eb53fff6a8ad5caf4b6339b4ccfd961f2dada91f0a"
  end

  depends_on "pkg-config" => :build
  depends_on "ffmpeg"
  depends_on "qt"

  fails_with gcc: "5" # ffmpeg is compiled with GCC

  def install
    mkdir "build" do
      system "qmake", "PREFIX=#{prefix}",
                                 "QMAKE_CXXFLAGS=#{ENV.cxxflags}",
                                 "CONFIG+=no_include_pwd",
                                 ".."
      system "make"

      prefix.install "PC6001VX.app"
      bin.write_exec_script "#{prefix}/PC6001VX.app/Contents/MacOS/PC6001VX"
    end
  end

  test do
    # locales aren't set correctly within the testing environment
    ENV["LC_ALL"] = "en_US.UTF-8"
    user_config_dir = testpath/".pc6001vx4"
    user_config_dir.mkpath
    pid = fork do
      exec bin/"PC6001VX"
    end
    sleep 20
    assert_predicate user_config_dir/"rom",
                     :exist?, "User config directory should exist"
  ensure
    # the first SIGTERM signal closes a window which spawns another immediately
    # after 5 seconds, send a second SIGTERM signal to ensure the process is fully stopped
    Process.kill("TERM", pid)
    sleep 5
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
