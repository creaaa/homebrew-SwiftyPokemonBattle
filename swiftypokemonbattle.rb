# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Swiftypokemonbattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/homebrew-SwiftyPokemonBattle/archive/v1.0.2.tar.gz"
  sha256 "6f1690616a4ac541e000e4d9488bcd880b9852b03416baa4907efa73d266ca7c"

  # depends_on "cmake" => :build

  def install
    bin.install "spb"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test homebrew-SwiftyPokemonBattle`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
