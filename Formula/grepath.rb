class Grepath < Formula
  desc "Extract paths effortlessly from your command outputs with grepath"
  homepage "https://github.com/kqito/grepath"
  version "0.0.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kqito/grepath/releases/download/v0.0.11/grepath-aarch64-apple-darwin.tar.xz"
      sha256 "937651c29143301cf6ce91ecb9161af0297e460f98c9803ad14c12315d9c3e48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.11/grepath-x86_64-apple-darwin.tar.xz"
      sha256 "339c4482e95946e5861481cb3158b6c8068300872b20cae81acfcc87444d5dec"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/kqito/grepath/releases/download/v0.0.11/grepath-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca55dade054b326582aa051428c14ed332b009f3eb5085a153c0b08f86536893"
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
