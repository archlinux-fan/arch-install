#!/bin/bash
# Firefox rules for every profile, set once for the whole system: no telemetry, studies,
# sponsored content or Mozilla account; DNS stays with the system.
# Firefox itself comes with desktop/50-apps.sh. Restart it afterwards; about:policies shows the rules.

sudo mkdir -p /etc/firefox/policies
sudo tee /etc/firefox/policies/policies.json > /dev/null <<'EOF'
{
  "policies": {
    "AppAutoUpdate": false,
    "DisableTelemetry": true,
    "DisableFirefoxStudies": true,
    "DisableFirefoxAccounts": true,
    "DisableRemoteImprovements": true,
    "DisableFeedbackCommands": true,
    "DisableSetDesktopBackground": true,
    "NoDefaultBookmarks": true,
    "DontCheckDefaultBrowser": true,
    "SkipTermsOfUse": true,
    "GenerativeAI": { "Enabled": false },
    "DNSOverHTTPS": { "Enabled": false, "Locked": true },
    "FirefoxHome": { "SponsoredTopSites": false, "SponsoredPocket": false },
    "FirefoxSuggest": { "SponsoredSuggestions": false, "ImproveSuggest": false }
  }
}
EOF
