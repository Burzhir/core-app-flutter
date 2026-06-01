# CORE – Philosophical Coaching App

**CORE** is a mobile app that diagnoses your mindset and delivers hardcore philosophical frameworks.  
It connects to a Flask AI API to give you actionable wisdom — no therapy, no hand-holding.

## Features

- **Daily Philosophy** – A rotating philosopher and challenge every day.
- **Diagnose** – Type what's holding you back and get a matched philosophy with actionable advice.
- **Philosophy Library** – Browse all 15+ philosophies with deep‑dive descriptions and challenges.
- **Journal** – Write private reflections that automatically link to your last diagnosis. Persists locally.
- **Stats** – Track your streak, total diagnoses, and top philosophies.

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider + ChangeNotifier
- **Local Persistence**: SharedPreferences (journal, streaks, history)
- **API**: Custom Flask backend (OpenRouter AI + keyword fallback) hosted on Render
- **Styling**: Dark theme, custom gradients, animated transitions
