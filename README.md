# Capxul Homebrew tap

This tap distributes the Capxul CLI from its verified npm release.

The first formula is pending the CLI foundation review and compatible Railway
backend deployment. No installable formula is published yet.

After the first release:

```sh
brew install xelmar-tech/tap/capxul
brew upgrade xelmar-tech/tap/capxul
```

The formula installs Bash, Zsh, and Fish completions. It uses Homebrew Node and
keeps its npm dependencies inside the formula installation.

Formula versions and SHA-256 checksums are generated from the exact published
`@capxul/cli` tarball after npm SHA-512 integrity verification. This repository
contains distribution metadata only. The CLI retains its upstream license terms.
