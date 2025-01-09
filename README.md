# Bingo Game Application 🎲

A modern and intuitive **Bingo Game Application** built using **Flutter** for desktop platforms. This app is designed to provide an engaging experience with advanced game settings, local database integration, and seamless management for controllers, admins, and players.

---

## 🛠️ Features

### **Core Functionalities**
- **Game Control**: The controller can shuffle numbers, manage players, and oversee the game flow.
- **Customizable Settings**:
  - Bonus activation.
  - Auto-call duration.
  - Dark mode for comfortable gaming sessions.
  - Adjustable call sounds.
  - Winning mode configuration.
- **Game Display**: Displays game updates and player progress on a screen for participants.

### **Player-Focused**
- Players can use a companion application (or digital cards) to trace numbers and call "Bingo" instead of physical cards.

### **Data Management**
- **Local Database**: Game history is stored using SQLite for offline accessibility.
- Remote access allows game administrators to manage history from their mobile phones.

### **Multilevel Administration**
- **Admin Roles**:
  - **Controller**: Handles number shuffling and game settings.
  - **Admin**: Manages players and game configurations.
  - **Super Admin**: Oversees all controls and provides advanced configurations.

---

## 🖥️ Technology Stack

- **Flutter**: Cross-platform framework for a seamless user experience.
- **Dart**: Programming language for rapid and efficient development.
- **SQLite**: Lightweight local database for game history storage.
- **Android Studio**: Development environment for managing Flutter builds and debugging.

---

## 🚀 How It Works

1. **Setup**:
   - The controller initializes the game, manages players, and configures settings.
   - Players join the game and track numbers using a companion app or the game screen.

2. **Game Flow**:
   - Numbers are shuffled and displayed on the main screen.
   - Players trace the numbers and call "Bingo" when they meet winning conditions.

3. **Game Management**:
   - Admins and super admins can remotely manage game history and settings via their devices.

---

## 💡 Challenges & Solutions

- **Challenge**: Integrating a local database for managing game history.
  - **Solution**: Used SQLite for reliable, fast, and lightweight storage.
  
- **Challenge**: Designing an intuitive and user-friendly interface.
  - **Solution**: Focused on clean, responsive UI components using Flutter's material design principles.

- **Challenge**: Managing roles and permissions across multiple admin levels.
  - **Solution**: Implemented role-based access to maintain a structured and secure flow.

---

## 🛠️ Installation & Setup

### Prerequisites
- Ensure you have Flutter installed. Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- Install a supported IDE like **Android Studio** or **VS Code**.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/bingo-game-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd bingo-game-app
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run -d windows
   ```
5. If you just want to see the application on your desktop please download and run the exe file:
   ```bash
   Top Bingo Setup.exe
   ```

---

## 🌟 Future Improvements

- **Cloud Database Integration**: Sync game history to a cloud-based database for accessibility across multiple devices.
- **Mobile Player App**: A dedicated mobile app for players to enhance usability.
- **Advanced Analytics**: Provide insights on game statistics and trends.
- **Multiplayer Online Support**: Enable online Bingo sessions for remote players.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Thanks to the Flutter and Dart communities for their robust tools and support.
- Special appreciation to the testers and contributors who helped refine this application.

---

## 🎉 Conclusion

The Bingo Game App is a modern solution for engaging, fun, and highly customizable Bingo games. With its robust features, user-friendly design, and offline database integration, it offers an unparalleled experience for controllers and players alike.

**Thank you for exploring the Bingo Game Application! Feel free to contribute, share feedback, or ask questions.**

---
```

### **Key Features of This README:**
1. **Professional Tone**: Clear and concise language with structured sections.
2. **Comprehensive Details**: Covers features, setup, technology stack, and future improvements.
3. **Developer Friendly**: Includes instructions for cloning, setting up, and running the app.
4. **Future-Oriented**: Mentions potential enhancements to show forward-thinking development.

Let me know if you'd like to adjust anything!
