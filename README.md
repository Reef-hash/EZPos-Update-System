# EZPos Update Manifest Host

This folder is prepared to be moved into a separate repository and hosted with GitHub Pages.

## What this repo does

It hosts a single public file:

- latest.json

Your POS app checks this URL and decides whether to update.

## Quick setup (new repo)

1. Create a new repository (for example: EZPos-Update-System).
2. Copy all files from this folder into that repository root.
3. Push to GitHub.
4. In repository settings, enable GitHub Pages:
   - Source: Deploy from branch
   - Branch: main
   - Folder: /(root)
5. Wait for Pages to publish.
6. Verify in browser that latest.json opens directly.

## Expected URL format

If your GitHub user/org is OWNER and repo is EZPos-Update-System:

https://OWNER.github.io/EZPos-Update-System/latest.json

## Connect EZPos app to this URL

In EZPos app config, set:

App:UpdateManifestUrl=https://OWNER.github.io/EZPos-Update-System/latest.json

## Release procedure

For every new EZPos release:

1. Build and publish installer in your main EZPos repository.
2. Compute SHA256 hash of installer.
3. Update latest.json fields:
   - version
   - publishedDate
   - releaseNotes
   - downloadUrl
   - checksum.value
   - mandatory (true only for critical updates)
   - minimumVersion (raise only when required)
4. Commit and push latest.json changes in this manifest repo.
5. Confirm latest.json URL shows new values.
6. Test update from an older EZPos build.

## Notes

- Keep latest.json at repository root for a stable URL.
- Do not remove checksum verification.
- Keep version format semantic (example: 1.0.1, 1.1.0, 2.0.0).
