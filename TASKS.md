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

---

## 3. Camera Feed (AVFoundation)

- [x] Initialize `AVCaptureSession`
- [x] Detect available video input devices
- [x] Default to system default camera
- [x] Render live camera feed in window
- [x] Mirror video horizontally (default on)
- [x] Mirror mode toggle implemented
- [x] Mirror preference persists
- [x] Camera switches correctly when device changes
- [x] External webcams supported
- [x] Camera feed stops immediately when window closes

---

## 4. Camera Permissions & Errors

- [x] Detect camera permission status on first use
- [x] Trigger system permission prompt cleanly
- [x] Handle permission denied state gracefully
- [x] Show clear error UI if permission denied
- [ ] Handle camera already-in-use scenario
- [x] Show non-blocking error when camera unavailable
- [x] Allow retry after camera becomes available
- [x] App does not crash on permission edge cases

---

## 5. Preferences (Minimal)

- [x] Preferences window implemented
- [x] Launch at login toggle
- [x] Mirror mode toggle
- [x] Camera selection dropdown
- [x] Preferences persist via UserDefaults
- [x] Preferences apply immediately (no restart required)

---

## 6. App Lifecycle & Stability

- [ ] App launches cleanly on login (if enabled)
- [x] App survives macOS sleep/wake
- [x] App survives display resolution changes
- [x] App survives camera hot-plug/unplug
- [x] App handles repeated open/close cycles
- [ ] No crashes after extended use (>50 toggles)
- [x] No zombie camera sessions left running

---

## 7. Performance & Resource Usage

- [x] Cold app launch < 500ms
- [x] Camera activation < 300ms perceived
- [x] Memory usage < 50MB steady state
- [x] No CPU spikes when idle
- [x] Camera fully releases resources on close
- [x] No background processing when window closed

---

## 8. Privacy & Trust

- [x] No network calls
- [x] No analytics or telemetry
- [x] Camera active only when window visible
- [x] Camera off when app idle
- [x] Privacy behavior documented (README or About)

---

## 9. UX Polish (Ship-Level)

- [x] Icon aligns with macOS menu bar style
- [x] No unnecessary text or labels
- [x] No onboarding or first-run screens
- [x] Errors are clear but minimal
- [x] App feels instantaneous and invisible
- [x] Matches macOS look & behavior expectations

---

## 10. QA / Manual Test Checklist

- [x] First launch with no permissions
- [x] Permission granted flow
- [x] Permission denied flow
- [x] Camera in use by another app
- [x] External webcam connect/disconnect
- [x] Repeated toggle stress test
- [x] Launch at login verification
- [x] Sleep/wake test
- [x] Quit while camera active
- [x] Relaunch restores previous state correctly

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

- [ ] Always-on-top behavior + preference
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
