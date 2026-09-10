class Capxul < Formula
  desc "Capxul command-line diagnostics and configuration"
  homepage "https://github.com/Xelmar-tech/homebrew-tap"
  url "https://registry.npmjs.org/@capxul/cli/-/cli-4.20.0-beta.4.tgz"
  version "4.20.0-beta.4"
  sha256 "586ef7b56156d557c87d005ee23f00d69f5c4eb87d5a6c24d1ede36599746ca0"
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
