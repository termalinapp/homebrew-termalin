# Termalin — Homebrew Cask (custom tap)
#
#   brew tap termalinapp/termalin
#   brew install --cask termalin
#
# The macOS dmg is distributed from termal.in/download with immutable, versioned
# URLs; the build is signed with Developer ID and notarized.

cask "termalin" do
  version "0.1.44"
  sha256 "1f93c383dae8f210432d6728b1ca443a85aa6647e8e136a211795238e9c78185"

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
