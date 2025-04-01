class Grepath < Formula
  desc "Extract paths effortlessly from your command outputs with grepath"
  homepage "https://github.com/kqito/grepath"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kqito/grepath/releases/download/v0.0.9/grepath-aarch64-apple-darwin.tar.xz"
      sha256 "ffd0bffd0b1d81977c22ef5e1ccdea69844d056e67c56fa786a8148f39cc3749"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.9/grepath-x86_64-apple-darwin.tar.xz"
      sha256 "26b4ad59c1a2934f87a376a838f8d9175171290a0ff7c4b8afab18c1f1f8ca4c"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.9/grepath-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "316a4e8a84e03ccf96823408904f62420dc56c0f0e7e4e7dabbe23d695cdef37"
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
