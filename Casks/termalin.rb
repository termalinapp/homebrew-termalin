# Termalin — Homebrew Cask (custom tap)
#
#   brew tap termalinapp/termalin
#   brew install --cask termalin
#
# The macOS dmg is distributed from termal.in/download with immutable, versioned
# URLs; the build is signed with Developer ID and notarized.

cask "termalin" do
  version "0.1.42"
  sha256 "6eb91a5f63141c54494d7d0d44adeabc50dc9f3202a841aee452f8d5ae7017dc"

  url "https://termal.in/download/Termalin-#{version}-macos.dmg",
      verified: "termal.in/download/"
  name "Termalin"
  desc "Cross-platform SSH client with a built-in MCP server for AI agents"
  homepage "https://termal.in/"

  livecheck do
    url "https://termal.in/api/v1/updates/latest?platform=macos"
    strategy :json do |json|
      json["data"]["version"]
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "termalin.app"

  uninstall quit: "in.termal.desktop"

  zap trash: [
    "~/.termalin",
    "~/Library/Application Support/in.termal.desktop",
    "~/Library/Caches/in.termal.desktop",
    "~/Library/Preferences/in.termal.desktop.plist",
    "~/Library/Saved Application State/in.termal.desktop.savedState",
    "~/Library/HTTPStorages/in.termal.desktop",
  ]

  caveats <<~EOS
    Termalin stores saved hosts, keys and snippets encrypted at rest, with the
    vault key held in your macOS Keychain. `--zap` removes on-disk data but not
    Keychain items; remove those from Keychain Access if you want a full wipe.
  EOS
end
