# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Swiftypokemonbattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/homebrew-SwiftyPokemonBattle/archive/v1.0.1.tar.gz"
  sha256 "bfb1e988cb1f6e4e69f0a7c7b3b629ca44548db9b1781f8886d58f30b9e69d7c"

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
