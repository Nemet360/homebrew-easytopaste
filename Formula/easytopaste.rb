# EasyToPaste — one-time secret links, encrypted in your terminal.
#
# This is a TAP, not homebrew-core. homebrew-core has a notability bar (roughly
# 75 stars or 30 forks) that this project does not clear yet, and a tap needs
# nobody's approval, so this is the honest place for it today.
#
# EASYTOPASTE_CHANNEL is what tells the service a request came from a Homebrew
# install. A utm tag measures a click on a link; somebody who installs here and
# then runs the command never loads a page, so the request header is the only
# place the channel can appear. It is set in a wrapper rather than baked into
# the package, so the same published artifact serves every channel.
class Easytopaste < Formula
  desc "Share a password or API key through a one-time, client-encrypted link"
  homepage "https://easytopaste.com/?utm_source=homebrew&utm_medium=cli&utm_campaign=launch-2026-11"
  url "https://registry.npmjs.org/easytopaste/-/easytopaste-0.1.1.tgz"
  sha256 "635628a574cc1135428f1d30df50048cc59f7b0aaa5597672794da331fb2777a"
  license :cannot_represent # see LICENSE.md in the package: use permitted, redistribution is not
  version "0.1.1"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # The real executable lands in libexec; the wrapper is what users run, and
    # it is the thing that declares the channel.
    (bin/"easytopaste").write <<~SH
      #!/bin/bash
      export EASYTOPASTE_CHANNEL="${EASYTOPASTE_CHANNEL:-brew}"
      exec "#{libexec}/bin/easytopaste" "$@"
    SH
    chmod 0755, bin/"easytopaste"
  end

  test do
    # No network: --version proves the wiring end to end.
    assert_match version.to_s, shell_output("#{bin}/easytopaste --version")
  end
end
