class Cli < Formula
  desc "200stack の CLI"
  homepage "https://www.200stack.com/ai/"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.5.0/stack200-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c83440cd90f08afa7f1b0820095f40c6a48ff5a45c871041b03e64c0393a8f1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.5.0/stack200-cli-x86_64-apple-darwin.tar.xz"
      sha256 "99746ee1c81876cdd65ce6c01b11d7b1c71097709ff0fd1757c279c03fa7be8a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.5.0/stack200-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "148d569b7a38b4106628e5e69d8fd0b3fbcf179668233ff5525f1f67550a931e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anytools-app/homebrew-200stack/releases/download/stack200-cli-v0.5.0/stack200-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "12ac1a79627595f005bdf4a7a1ddbb06e22efdfbd6e4efd626380680cd156fbe"
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
