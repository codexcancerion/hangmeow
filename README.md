# HangMeow

**Developers:** Melbert P. Marafo, Herbert B. Acoking, Jerick A. Amiao, Jeric M. Colsido

**Platform:** Android (Mobile Platform)

**Repository:** [https://github.com/codexcancerion/hangmeow](https://github.com/codexcancerion/hangmeow)

**Download for Android:** [Click here](https://github.com/codexcancerion/hangmeow/releases/download/v1.0.0/hangmeow-v1.0.0.apk)

---

## I. GAME CONCEPT

### A. IDEA

HangMeow is an educational, word-guessing mobile game inspired by Hangaroo. It features a character named Meowgan Freeman, a cartoon cat who becomes the emotional centerpiece of the game. Players guess eco-themed statements or slogans letter-by-letter. Incorrect guesses progressively bring Meowgan closer to being "hanged," creating tension and urgency. The game’s mission is to educate players on climate change through fun, challenging, and emotionally engaging gameplay.

---

## II. GAME DESIGN

### A. GAME TYPE

**Genre:** Puzzle / Educational
HangMeow merges traditional Hangman mechanics with a powerful advocacy twist. It builds logic, vocabulary, and memory skills while embedding environmental awareness in its core design.

### B. OBJECTIVE DESIGN

* **Primary Objective:**

  * Promote climate literacy through interactive puzzles.
* **Sub-Objectives:**

  * Enhance pattern recognition and vocabulary.
  * Instill empathy via symbolic consequences (Meowgan’s fate).
  * Encourage perseverance through trial-and-error learning.

### C. USER EXPERIENCE

* **Emotion:**

  * Emotional stakes are set through Meowgan’s expressions, creating player empathy without violence.
* **Challenge:**

  * Puzzle difficulty escalates as phrases become more abstract.
* **Progression:**

  * Levels introduce new vocabulary and concepts, reinforcing long-term retention.

### D. GAME PARAMETERS

* **Space:**

  * A clean 2D UI with three main areas: phrase display, letter input buttons, and Meowgan’s status.
* **State:**

  * Tracks revealed letters, mistakes made, current level, and win/lose state.
* **Action:**

  * Player taps to guess letters. Actions trigger state changes.
* **Skills:**

  * Language comprehension, logical deduction, and pattern recognition.
* **Randomness:**

  * Phrases are selected randomly from a curated climate-related database.

### E. GAME CONTROLS

* Letter Buttons: Guess letters.
* Restart Button: Reset the current level.
* Next Button: Proceed to the next puzzle.
* Hint Display: Optional clue for harder phrases.
* Lives Tracker: Indicates how many mistakes are allowed.

### F. GAME FEATURES

1. **Word-Guessing Gameplay** – Core mechanic inspired by Hangman.
2. **Educational Content** – Factual climate-change phrases and trivia.
3. **Emotional System** – Meowgan reacts to player success/failure.
4. **Contextual Paragraphs** – Each solved puzzle reveals climate facts or tips.
5. **Dynamic Difficulty** – Levels increase in complexity.
6. **Hint System** – Clues assist when puzzles become difficult.
7. **Aesthetic Theme** – Green and blue color scheme reinforcing eco-awareness.
8. **Mobile-First UX** – Optimized for Android’s touch interaction.

---

## III. GAME AESTHETICS

* **Visual Style:**

  * Minimalist 2D design with soft colors (greens and blues).
  * Clean typography and intuitive layout.
  * Meowgan’s animations and visual feedback change with game state.

---

## IV. TECHNICAL DOCUMENTATION

### A. TECHNOLOGY STACK

* **Framework:** Flutter (Dart)
* **Platform:** Android
* **UI Components:** Flutter widgets
* **State Management:** setState (for simple local state)
* **Data Storage:** JSON-based phrase database (local asset)
* **Media Assets:** Local assets for Meowgan’s sprites and background visuals

### B. SYSTEM ARCHITECTURE

1. **Frontend (Flutter)**

   * Splash Screen
   * Main Menu
   * Game Screen (Phrase display, letter input, Meowgan character)
   * Result Modal (Explanation + next button)

2. **Phrase Engine**

   * Random selector from JSON
   * Filtering based on difficulty level

3. **Game Logic Engine**

   * Tracks guessed letters, wrong attempts
   * Evaluates win/lose conditions
   * Triggers character animations and UI state changes

4. **Hint System**

   * One hint per level, shown optionally
   * Pulled from same JSON dataset

5. **Progress Tracker**

   * In-memory score and streak counter
   * Basic level advancement

### C. DATA STRUCTURE

```json
{
  "phrase": "Save the Earth, it’s the only one we’ve got",
  "hint": "A call to preserve the environment",
  "explanation": "This slogan reminds us that our planet is unique and irreplaceable."
}
```

### D. ASSET MANAGEMENT

* **Sprites:** PNG assets (Meowgan’s states: happy, worried, near peril, hanged)
* **Fonts:** Embedded via pubspec.yaml
* **Colors:** Defined as constants (Earth tones: green, blue, brown)

### E. DEPLOYMENT

* Built via Flutter’s Android build pipeline
* Debugged using Android Emulator
* APK export for testing and deployment

### F. FUTURE IMPROVEMENTS

* Cloud sync for user progress
* Firebase integration for user analytics
* Leaderboard implementation
* Multi-language support (English + Filipino)
* Sound/music toggle options

---

## V. DEVELOPMENT BEST PRACTICES

* **Code Modularity:** Each screen and component is separated for clarity
* **Responsive UI:** Scales to various Android screen sizes
* **Minimal External Dependencies:** Ensures lightweight app
* **Accessibility:** Clean UI, readable fonts, visual cues for mistakes

---

## VI. FINAL NOTES

HangMeow isn’t just a game—it’s an advocacy in action. By merging logic-based gameplay with environmental education, it speaks both to the mind and the heart. It builds a future generation of climate-conscious players, one puzzle at a time.
