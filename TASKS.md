# TASKS — Glance v1 (Feature Complete & Ready to Ship)

This checklist defines **everything that must be completed** for Glance v1 to be considered feature complete, stable, and shippable per the PRD.

If it’s not checked here, it’s not shipped.

---

## 0. Project Bootstrap

- [x] Create macOS app project (Swift + SwiftUI)
- [x] Configure app as menu bar–only (`LSUIElement`)
- [x] Remove Dock icon and Cmd+Tab presence
- [x] Configure app sandbox & entitlements
- [x] Set minimum supported macOS version
- [x] Verify app launches cleanly with no UI shown

---

## 1. Menu Bar Integration

- [x] Create `NSStatusItem`
- [x] Add menu bar icon (template image)
- [ ] Define icon states:
  - [x] Idle
  - [x] Camera active
- [x] Left-click toggles camera window
- [x] Right-click opens context menu
- [ ] Context menu contains:
  - [x] Preferences
  - [x] Quit
- [x] Menu bar icon updates correctly on camera open/close

---

## 2. Camera Window (Core UX)

- [x] Create borderless floating window (`NSWindow` / `NSPanel`)
- [x] Window does not appear in Dock or Cmd+Tab
- [x] Window opens instantly (<300ms perceived)
- [x] Window closes instantly with no animation lag
- [x] Window is draggable
- [x] Window is freely resizable
- [x] Window remembers last size
- [x] Window remembers last position
- [x] Window opens near last position on relaunch
- [ ] Optional always-on-top behavior implemented
- [ ] Always-on-top preference persists

---

## 3. Camera Feed (AVFoundation)

- [ ] Initialize `AVCaptureSession`
- [ ] Detect available video input devices
- [ ] Default to system default camera
- [ ] Render live camera feed in window
- [ ] Mirror video horizontally (default on)
- [ ] Mirror mode toggle implemented
- [ ] Mirror preference persists
- [ ] Camera switches correctly when device changes
- [ ] External webcams supported
- [ ] Camera feed stops immediately when window closes

---

## 4. Camera Permissions & Errors

- [ ] Detect camera permission status on first use
- [ ] Trigger system permission prompt cleanly
- [ ] Handle permission denied state gracefully
- [ ] Show clear error UI if permission denied
- [ ] Handle camera already-in-use scenario
- [ ] Show non-blocking error when camera unavailable
- [ ] Allow retry after camera becomes available
- [ ] App does not crash on permission edge cases

---

## 5. Preferences (Minimal)

- [ ] Preferences window implemented
- [ ] Launch at login toggle
- [ ] Always-on-top toggle
- [ ] Mirror mode toggle
- [ ] Camera selection dropdown
- [ ] Preferences persist via UserDefaults
- [ ] Preferences apply immediately (no restart required)

---

## 6. App Lifecycle & Stability

- [ ] App launches cleanly on login (if enabled)
- [ ] App survives macOS sleep/wake
- [ ] App survives display resolution changes
- [ ] App survives camera hot-plug/unplug
- [ ] App handles repeated open/close cycles
- [ ] No crashes after extended use (>50 toggles)
- [ ] No zombie camera sessions left running

---

## 7. Performance & Resource Usage

- [ ] Cold app launch < 500ms
- [ ] Camera activation < 300ms perceived
- [ ] Memory usage < 50MB steady state
- [ ] No CPU spikes when idle
- [ ] Camera fully releases resources on close
- [ ] No background processing when window closed

---

## 8. Privacy & Trust

- [ ] No network calls
- [ ] No analytics or telemetry
- [ ] Camera active only when window visible
- [ ] Camera off when app idle
- [ ] Privacy behavior documented (README or About)

---

## 9. UX Polish (Ship-Level)

- [ ] Icon aligns with macOS menu bar style
- [ ] No unnecessary text or labels
- [ ] No onboarding or first-run screens
- [ ] Errors are clear but minimal
- [ ] App feels instantaneous and invisible
- [ ] Matches macOS look & behavior expectations

---

## 10. QA / Manual Test Checklist

- [ ] First launch with no permissions
- [ ] Permission granted flow
- [ ] Permission denied flow
- [ ] Camera in use by another app
- [ ] External webcam connect/disconnect
- [ ] Repeated toggle stress test
- [ ] Launch at login verification
- [ ] Sleep/wake test
- [ ] Quit while camera active
- [ ] Relaunch restores previous state correctly

---

## 11. Release Readiness

- [ ] App icon finalized
- [ ] Bundle identifier finalized
- [ ] Version number set (v1.0.0)
- [ ] Build configuration set to Release
- [ ] Code signing configured
- [ ] Notarization verified
- [ ] Final smoke test on clean machine
- [ ] DMG or distribution method prepared

---

## 12. Ship Criteria (All Must Be True)

- [ ] All MUST-HAVE user stories satisfied
- [ ] All non-goals respected (no scope creep)
- [ ] No known crashers
- [ ] Performance targets met
- [ ] Feels native, invisible, instant

---

## Parking Lot (Explicitly Deferred)

- [ ] Keyboard shortcuts
- [ ] Snapshot capture
- [ ] Picture-in-picture
- [ ] Multiple camera views
- [ ] iOS companion

---

## Definition of Done

Glance v1 is **ready to ship** when:
- Every checkbox above is complete
- The app feels boring in the best possible way
- Using it requires zero thought
