class Capxul < Formula
  desc "Capxul command-line diagnostics and configuration"
  homepage "https://github.com/Xelmar-tech/homebrew-tap"
  url "https://registry.npmjs.org/@capxul/cli/-/cli-4.20.0-beta.9.tgz"
  version "4.20.0-beta.9"
  sha256 "219714edcf74fd91471a5e6fcb9debc3c52b9be0040bbe77e01915924db48717"
  # The upstream npm package retains its UNLICENSED metadata.
  license :cannot_represent

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    (bin/"capxul").write_env_script libexec/"bin/capxul", PATH: "#{Formula["node"].opt_bin}:$PATH"
    generate_completions_from_executable(bin/"capxul", "--completions",
                                        shells: [:bash, :zsh, :fish])
  end

  test do
    ENV["CAPXUL_CLI_HOME"] = testpath/"state"
    ENV["CAPXUL_TELEMETRY_DISABLED"] = "true"
    assert_equal "capxul v#{version}", shell_output("#{bin}/capxul --version").strip
    result = JSON.parse(shell_output("#{bin}/capxul doctor --json"))
    assert_equal "succeeded", result.fetch("outcome")
    assert_equal "not_checked", result.fetch("data").fetch("network").fetch("status")
    assert_match "#compdef capxul", (zsh_completion/"_capxul").read
  end
end
