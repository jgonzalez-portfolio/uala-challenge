# 🌎 Globuala

Aplicación iOS desarrollada en **SwiftUI**, sin librerías externas tal como se solicitaba en el challenge, que permite visualizar ciudades, marcarlas como favoritas, y acceder a información detallada.

---

## 📱 Características

- Lista de ciudades con detalles de coordenadas.
- Marcado de ciudades como favoritas.
- Persistencia local usando `UserDefaults`.
- Navegación moderna con `NavigationSplitView`.
- Arquitectura basada en MVVM + Clean Architecture.
- Networking Layer con principios SOLID para futuras extensiones en caso de querer conectarnos a mas de una API
- Use Cases con el propósito de separar responsabilidades aplicando a Single Responsability Principe
- UI Test base implementado para flujos principales
- Unit test base implementado para ViewModels y Query Search


---

## 🧠 Arquitectura
Presentation (SwiftUI Views)
└── ViewModel (ObservableObject)
├── UseCase
│   └── Repository
│       ├── RemoteDataSource
│       └── LocalDataSource (UserDefaults)
---

## 📁 Estructura de carpetas
Globuala/
├── Presentation/
├── Domain/
├── Data/
├── Utils/
---

Jonatan Gonzalez
- LinkedIn: [Joni iOS Dev](https://www.linkedin.com/in/joni-iosdev/l)