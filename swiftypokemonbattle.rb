# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class SwiftyPokemonBattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/SwiftyPokemonBattle/archive/v1.0.tar.gz"
  sha256 "df36b0c1f049dff45fb5af6933fe6c26e436ecf4c465ce49fcf8908a0768052b"

  # depends_on "cmake" => :build

  def install
    bin.install "spb"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test SwiftyPokemonBattle`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
