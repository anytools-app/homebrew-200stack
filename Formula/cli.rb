class Cli < Formula
  desc "200stack の CLI"
  homepage "https://www.200stack.com/ai/"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.4.0/stack200-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e9d4a538b36594f51f7567bcce2efed34d58b8a29db93fc7bf510a99ad370d81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.4.0/stack200-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a39f8ebebd948f024b971444d2beec0c9dce894d48954e23e73165a555ee32d6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.4.0/stack200-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9ca2f8c4e4bae374c59cda577b202a581f0921a95d0b46d46ee761bdbb2e28ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.4.0/stack200-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0daeb4f3ba34c071a1459a8b1e3f3bd503c277d6cb36d24f3951fb7fc57ce7a6"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
      bin.install "200stack"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "200stack"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "200stack"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "200stack"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/200stack --version")
  end
end
