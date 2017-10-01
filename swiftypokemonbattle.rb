# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Swiftypokemonbattle < Formula
  desc "👾 High-Fidelity Pokemon Battle Simulator 💨"
  homepage ""
  url "https://github.com/creaaa/homebrew-SwiftyPokemonBattle/releases/tag/v1.0"
  sha256 "b357691240412171f21e7f95d3ae8efd2bcc38763c204a22a8cd1f1c42f07c4d"

  def install
    bin.install "spb"
  end

  test do
    system "false"
  end
end
