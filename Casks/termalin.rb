# Termalin — Homebrew Cask (custom tap)
#
#   brew tap termalinapp/termalin
#   brew install --cask termalin
#
# The macOS dmg is distributed from termal.in/download with immutable, versioned
# URLs; the build is signed with Developer ID and notarized.

cask "termalin" do
  version "0.1.45"
  sha256 "083621eb2394f41cb83046dee9bbd6b85284c7edceaa8c291f52739b0f13e7a9"

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
