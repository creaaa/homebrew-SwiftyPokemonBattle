# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Swiftypokemonbattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/homebrew-SwiftyPokemonBattle/releases/tag/v1.0"
  sha256 "4b3f1bafabe8b95236c5eb1eae926fb07c5a5e60cf4adff1ae90b5d6bc33e9b3"

  def install
    bin.install "spb"
  end

  test do
    system "false"
  end
end
