class Grepath < Formula
  desc "Extract paths effortlessly from your command outputs with grepath"
  homepage "https://github.com/kqito/grepath"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kqito/grepath/releases/download/v0.0.5/grepath-aarch64-apple-darwin.tar.xz"
      sha256 "46b8b9c438f3868d71c7a1272da2018b1ca17a30641133f7b8da7738e34c902f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.5/grepath-x86_64-apple-darwin.tar.xz"
      sha256 "04239b98ddd7bf9a1560b51b61398f4a008d727d44c33f517fcbf833f97008c8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.5/grepath-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6752d8e904eda28b2c3f27d99efe247ea6ee5c3e614eaa5ada681ef43fdccba0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "grepath"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grepath"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grepath"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
