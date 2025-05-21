# 🌎 Globuala

Aplicación iOS desarrollada en **SwiftUI**, sin librerías externas tal como se solicitaba en el challenge, que permite visualizar ciudades, marcarlas como favoritas, y acceder a información detallada.

---

## 📱 Características

- **Lista de ciudades** con detalles de coordenadas.
- **Marcado de ciudades como favoritas**.
- **Persistencia local** usando `UserDefaults`.
- **Navegación moderna** con `NavigationSplitView`.
- **Arquitectura** basada en MVVM + Clean Architecture.
- **Capa de Networking** con principios SOLID para futuras extensiones en caso de querer conectarnos a más de una API.
- **Use Cases** con el propósito de separar responsabilidades aplicando el Principio de Responsabilidad Única (SRP).
- **UI Tests** base implementados para flujos principales.
- **Unit Tests** base implementados para ViewModels y Query Search.

---

## 🧠 Arquitectura

```plaintext
Presentation (SwiftUI Views)
└── ViewModel (ObservableObject)
    ├── UseCase
    │   └── Repository
    │       ├── RemoteDataSource
    │       └── LocalDataSource (UserDefaults)
```

---

## 📁 Estructura de carpetas

```plaintext
Globuala/
├── Presentation/
├── Domain/
├── Data/
├── Utils/
```

---

## 👤 Autor

**Jonatan Gonzalez**

- LinkedIn: [Joni iOS Dev](https://www.linkedin.com/in/joni-iosdev/l)