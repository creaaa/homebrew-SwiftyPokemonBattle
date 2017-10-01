# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Swiftypokemonbattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/homebrew-SwiftyPokemonBattle/releases/tag/v1.0.2"
  sha256 "f1911662fc87321bbe85164b8d424219c87015f55a94bdca91aad3b834030dba"

  def install
    bin.install "spb"
  end

  test do
    system "false"
  end
end
