# auth_flow_riverpod2
Inspired by the following project, whose workflow explanation was clear but manual code implementation proved cumbersome. The reference project itself was a complete implementation, making it less suitable as a learning starting point. This led to the idea of leveraging AI-generated code, resulting in the creation of this project.

**This project was primarily auto-generated by DeepSeek AI**, with minor modifications made by me.

**Key reference project**:
- [How to Build a Robust Flutter App Initialization Flow with Riverpod](https://codewithandrea.com/articles/robust-app-initialization-riverpod/)

## Core Prompts
> "Use GoRouter and Riverpod2's code generation to create a Flutter project with a splash page. The app should await initial operations including SharedPreferences and local database initialization, then check for existing user login status. If logged in, automatically navigate to the home page; otherwise, redirect to the login page. Generate an initial project with well-organized files for clarity and maintainability. Provide complete, runnable code."

## Implementation Highlights
- **AI-Generated Foundation**: Code structure and core logic generated via DeepSeek AI
- **Modern Architecture**:
    - Riverpod 2 code generation (`@riverpod`)
    - GoRouter for declarative routing
    - Clear separation of concerns (providers/services/screens)
- **Key Features**:
    - Splash screen with initialization workflow
    - Auth state persistence via SharedPreferences
    - Automatic login validation
    - Error handling and retry mechanisms
- **Production-Ready**: Includes error boundaries, async safety checks (`mounted`), and extensible service layers

> Note: This implementation focuses on core initialization/auth flows while maintaining minimal dependencies.


```shell
flutter pub get
flutter pub run build_runner
flutter run
```





