class ShellGpt < Formula
  include Language::Python::Virtualenv

  desc "Command-line productivity tool powered by large language models"
  homepage "https://github.com/TheR1D/shell_gpt"
  url "https://files.pythonhosted.org/packages/82/ab/d70b98a1b37a6a891133d75a14c19ef66a00850eda83c57a4fbab3b0a6ae/shell_gpt-1.5.1.tar.gz"
  sha256 "1c528f960b1c515c882eec351ba3ac78ba6f306cece9cbe554d3ad350c8b5bfe"
  license "MIT"
  head "https://github.com/TheR1D/shell_gpt.git", branch: "main"

  depends_on "python@3.14"

  pypi_packages package_name: "shell-gpt"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sgpt --version")
  end
end
