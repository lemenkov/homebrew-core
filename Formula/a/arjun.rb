class Arjun < Formula
  include Language::Python::Virtualenv

  desc "HTTP parameter discovery suite"
  homepage "https://github.com/s0md3v/Arjun"
  url "https://files.pythonhosted.org/packages/51/cd/8eaadf3973a4e7bb519b885588b13348ddbe6d97ca06ecdcdda5f7a53dcb/arjun-2.2.1.tar.gz"
  sha256 "b1904add44c0c5a8241910b0555d7e252281187b7dadd16ebc0843dc768cb36e"
  license "AGPL-3.0-only"
  revision 3

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "aad7fb9e6468c4ba498475c9010cc2bb95bef77cc486aa9ad8139a4b4949c7c2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e1fd582eb0bd0a90b5f98447c33fe0df6c1f57db42a00d1e2d51b48d764c5bf4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9cd5a7f640262ae57ba284afc0194a99edac000d959ee3f95cffae2571124222"
    sha256 cellar: :any_skip_relocation, sonoma:         "7e207152f9a447a0acd7468a6dbe5d4c1d6a6d7fde2ae439067298812f3e24ed"
    sha256 cellar: :any_skip_relocation, ventura:        "d1a4304776da9eed64222c4cb3ed19ffec7e4a197fece07fa0ad1b1e446bf910"
    sha256 cellar: :any_skip_relocation, monterey:       "5fa923a6326835eeb6d333f532b83b03144b5d400937d0c3999904916a1471f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca4fa2a28451b0007530711886ea43c6c1292aa3880546a062c7061f37a92ae9"
  end

  depends_on "python-certifi"
  depends_on "python@3.12"

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/cf/ac/e89b2f2f75f51e9859979b56d2ec162f7f893221975d244d8d5277aa9489/charset-normalizer-3.3.0.tar.gz"
    sha256 "63563193aec44bce707e0c5ca64ff69fa72ed7cf34ce6e11d5127555756fd2f6"
  end

  resource "dicttoxml" do
    url "https://files.pythonhosted.org/packages/ee/c9/3132427f9e64d572688e6a1cbe3d542d1a03f676b81fb600f3d1fd7d2ec5/dicttoxml-1.7.16.tar.gz"
    sha256 "6f36ce644881db5cd8940bee9b7cb3f3f6b7b327ba8a67d83d3e2caa0538bf9d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/af/47/b215df9f71b4fdba1025fc05a77db2ad243fa0926755a52c5e71659f4e3c/urllib3-2.0.7.tar.gz"
    sha256 "c97dfde1f7bd43a71c8d2a58e369e9b2bf692d1334ea9f9cae55add7d0dd0f84"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/arjun -u https://mockbin.org/ -m GET")
    assert_match "No parameters were discovered", output
  end
end
