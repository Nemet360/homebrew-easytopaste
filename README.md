# Homebrew tap — EasyToPaste

```sh
brew install Nemet360/easytopaste/easytopaste
easytopaste --text "the thing you were about to paste into Slack"
```

> The secret can also be piped in: `echo "…" | easytopaste`. There is no
> `send` subcommand — the first version of this README invented one, and every
> copy-pasted first command failed with exit 2.

Share a password, an API key or a note through a **one-time link**. Your
terminal encrypts it before anything leaves (AES-256-GCM); the key travels in
the link's URL fragment, which no HTTP client transmits, so the service stores
ciphertext it cannot read. The link dies on first read.

What it is: <https://easytopaste.com/?utm_source=homebrew&utm_medium=cli&utm_campaign=launch-2026-11>
· how the encryption works: <https://easytopaste.com/how-it-works/?utm_source=homebrew&utm_medium=cli&utm_campaign=launch-2026-11>

## Why a tap and not `brew install easytopaste`

homebrew-core requires notability — roughly 75 stars or 30 forks — and this
project does not clear it yet. A tap needs nobody's approval and works today.
The bare name becomes possible later; the formula moves, the command changes,
and this README will say so rather than quietly keep working.

## What the formula does that a plain `npm i -g` does not

It sets `EASYTOPASTE_CHANNEL=brew`, which the CLI puts in its User-Agent. That
is how a Homebrew install is distinguishable from an npm one on the service
side. There is no other way to see it: an install followed by a command
produces no page view at all, so a link tag cannot measure it. Nothing else is
sent — no plaintext, no key, no path, no telemetry.

The channel field reaches the service from **version 0.1.2 onward**; 0.1.1, the
version this formula pins today, ignores it. The formula is written for the
version that follows so the wrapper does not have to change twice.
