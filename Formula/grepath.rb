class Grepath < Formula
  desc "Extract paths effortlessly from your command outputs with grepath"
  homepage "https://github.com/kqito/grepath"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kqito/grepath/releases/download/v0.0.6/grepath-aarch64-apple-darwin.tar.xz"
      sha256 "0bbecaef6f207deb3abfad81537e31d92cbf02ad6da38fb8267d040b31ddfc47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.6/grepath-x86_64-apple-darwin.tar.xz"
      sha256 "4aca39dc6f010565e7bd565e9f5d30e06f95daee391833f792b0778713554cf4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.6/grepath-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b476f6be20a1f87abeb8b6d3fefc5743714b1f936dd3be074035feaaaf25146b"
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
