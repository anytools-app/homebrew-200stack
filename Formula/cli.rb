class Cli < Formula
  desc "200stack の CLI"
  homepage "https://www.200stack.com/ai/"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.6.0/stack200-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c9db9314b823f098468a6c5b465bb25493ba5c3dcfbbc7ab097a6a065b9ea084"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.6.0/stack200-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a5de3f98406d2320962baba53db9fd73b41f552a82b122dc4d1bd3d708724a49"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.6.0/stack200-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "54859098683d7fa59c98c82fb9a10c6427fcab2f9cef3fe38627956e7ec2a519"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.6.0/stack200-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "321afeb4f90d5b6aa54b4f5f6b83562d776074ba1646dfa7b6a584f1e563b8d5"
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
