# Product Requirements Document (PRD)

**Project:** Glance (Hand Mirror Clone)
**Platform:** macOS
**Form Factor:** Menu bar utility
**Audience:** macOS users who need instant camera access (calls, grooming, lighting checks, content creation)

---

## 1. Problem Statement

macOS users frequently need **instant access to their camera** for quick checks (appearance, framing, lighting) without:

* Opening FaceTime, Photo Booth, or Zoom
* Managing meetings, calls, or UI clutter
* Losing focus or context

Current solutions are **slow, heavy, or indirect**.

---

## 2. Product Goal

Deliver a **zero-friction, one-click camera mirror** that:

* Lives in the menu bar
* Opens instantly
* Feels lightweight, native, and invisible when not in use

Success = *“I forgot this was an app — it’s just there when I need it.”*

---

## 3. Core Value Proposition

> **One click. Instant camera. No ceremony.**

---

## 4. Target Users

### Primary

* Remote workers
* Developers & designers
* Content creators
* Anyone hopping on quick video calls

### Secondary

* Streamers
* Educators
* Support agents

---

## 5. Non-Goals (Important)

Explicitly **out of scope for v1**:

* Video recording
* Streaming / broadcasting
* Video calls
* Filters / AR
* AI beautification
* Cross-platform support (macOS only)

This is a **tool**, not a platform.

---

## 6. User Stories (v1)

### Must-Have

1. As a user, I can click a menu bar icon and instantly see my camera feed
2. As a user, I can close the camera just as quickly
3. As a user, the app remembers my last camera and window position
4. As a user, the app launches on login (optional)

### Nice-to-Have

5. As a user, I can flip the camera horizontally (mirror mode)
6. As a user, I can resize the camera window freely
7. As a user, I can switch between available cameras

---

## 7. Functional Requirements

### 7.1 Menu Bar App

* Lives permanently in macOS menu bar
* Icon states:

  * Idle
  * Camera active
* Left click:

  * Toggle camera window
* Right click:

  * Preferences
  * Quit

---

### 7.2 Camera Window

* Borderless or minimal chrome
* Always-on-top (configurable)
* Resizable
* Draggable
* Instant open (<300ms perceived)

**Behavior**

* Opens near last position
* Closes without animation lag
* No dock icon (LSUIElement)

---

### 7.3 Camera Handling

* Default to system default camera
* Support external webcams
* Mirror horizontally by default (configurable)
* Auto-handle camera permission prompt

---

### 7.4 Preferences (Minimal)

* Launch at login
* Always on top
* Mirror mode on/off
* Camera selection dropdown

---

## 8. Non-Functional Requirements

### Performance

* App launch < 500ms
* Camera activation < 300ms
* < 50MB memory footprint

### Reliability

* Must gracefully recover if camera is in use by another app
* Clear error state if camera unavailable

### Privacy

* No network calls
* No analytics (or clearly disclosed)
* Camera only active when window is visible

---

## 9. UX Principles

* **Zero friction**
* **No onboarding**
* **No text where UI will do**
* **Feels like part of macOS, not an app**

This should feel closer to **Spotlight** than **Zoom**.

---

## 10. Technical Approach (Suggested)

### Stack

* **Swift + SwiftUI** (preferred)
* AVFoundation for camera
* NSStatusBar for menu bar
* NSWindow / NSPanel for floating window

### Architecture

* Single process
* No background services
* State stored via UserDefaults

### Key APIs

* `AVCaptureSession`
* `AVCaptureDevice`
* `NSStatusItem`
* `SMLoginItemSetEnabled`

---

## 11. MVP Scope Checklist

**Ship v1 when all are true:**

* Menu bar icon works
* Camera opens instantly
* Window is resizable & movable
* Permissions handled cleanly
* App survives sleep/wake
* No crashes after repeated open/close

---

## 12. Future Enhancements (Post-MVP)

Explicitly defer:

* Snapshot / photo capture
* Keyboard shortcuts
* Picture-in-picture mode
* Multiple camera views
* iOS companion

---

## 13. Risks & Mitigations

| Risk                        | Mitigation                           |
| --------------------------- | ------------------------------------ |
| Camera permission friction  | First-run detection + clear error UI |
| Camera busy by other app    | Non-blocking error + retry           |
| macOS updates breaking APIs | Minimal API surface                  |

---

## 14. Success Metrics

* Time-to-camera < 1 second
* Daily opens per user > 3
* Uninstall rate < 10% after 7 days
* “Feels native” qualitative feedback

---

## 15. Open Questions (Answer Before Coding)

1. Menu bar icon style: monochrome or colored?
2. Default always-on-top or opt-in?
3. Mirror mode default on or off?
4. Paid features later or always free?

---

## TL;DR Build Order

1. Menu bar shell
2. Camera feed window
3. Toggle logic
4. Preferences
5. Polish & ship

