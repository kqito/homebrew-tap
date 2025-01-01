class Grepath < Formula
  desc "Extract paths effortlessly from your command outputs with grepath"
  homepage "https://github.com/kqito/grepath"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kqito/grepath/releases/download/v0.0.7/grepath-aarch64-apple-darwin.tar.xz"
      sha256 "107c8b3d52ac417e8f5bb280e39add306fcac52fc58506b917f39a300d2738f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.7/grepath-x86_64-apple-darwin.tar.xz"
      sha256 "f3acfec7a6cd7c35ba821505f9bb874654407db3c95baacc157e1c5b154d1701"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.7/grepath-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25558cfda1781d9da168a9b0260abed0e61e10749c5d7f37392ddf56a61d8c06"
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
