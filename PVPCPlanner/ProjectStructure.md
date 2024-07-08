# PVPC-iOS

# Project Structure

This project uses SwiftUI with an architecture based on MVVM and Clean Architecture principles. The following folder structure helps maintain a clear separation of responsibilities and facilitates code maintenance.



## Folder Description:

### App/
- **App.swift**: Main entry point of the application, initial setup, and main scene.

### Data/
- **DataSource/**: Contains data sources that can be remote (API) or local (database, UserDefaults).
  - **Remote/**: Implementations for fetching data from web services.
  - **Local/**: Implementations for fetching data from local storage.
- **Models/**: Data models used in the data layer.
- **Network/**: Configurations and utilities related to network connections.
- **Persistence/**: Classes and utilities for managing persistent data storage.
- **Repositories/**: Repository implementations acting as an intermediary layer between the data source and the domain layer.

### Domain/
- **Entities/**: Domain entities representing business objects.
- **Protocols/**: Protocols defining interfaces for repositories and other domain abstractions.
- **UseCases/**: Use cases encapsulating business logic and application rules.

### Presentation/
- **ViewModels/**: Contains ViewModels that handle presentation logic and link the view to the domain layer.
- **Views/**: SwiftUI views divided into:
  - **Components/**: Reusable and small UI components.
  - **Screens/**: Main views representing complete screens.

### Resources/
- **Assets.xcassets**: Asset catalog containing images, colors, etc.
- **Localization/**: Localization files to support multiple languages.
- **Fonts/**: Custom fonts used by the application.
- **Constants/**: Global constants and configurations.

