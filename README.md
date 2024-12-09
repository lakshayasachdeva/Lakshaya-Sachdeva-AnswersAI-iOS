# App Store Today Detail View

A SwiftUI implementation of the App Store's Today view detail page, featuring dynamic scroll behaviors and interactive elements.

## Features

- Full-screen detail view with hero image
- Dynamic floating app bar on scroll
- Interactive app installation button
- Share functionality
- Responsive scroll animations
- Dark mode support

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Components

### DetailView
Main view component displaying the app details with:
- Hero image with text overlay
- App information card
- Description section
- Share button
- Dynamic floating bottom bar

### FloatingAppView
Secondary component that appears/disappears based on scroll position:
- App icon
- App name and category
- Install button

### AppInstallOverlay
Modal view for app installation process:
- Installation progress
- Success/failure states


## Implementation Details
- Uses SwiftUI's preference key system for scroll position tracking
- Implements custom transitions for floating app bar
- Uses GeometryReader for dynamic layout calculations
- Follows Apple's Human Interface Guidelines for UI components
