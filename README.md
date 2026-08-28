# Tienda Online - Carrera de Diseño Gráfico
**Universidad San Gregorio de Portoviejo (USGP)**

Sistema *e-commerce* desarrollado en el marco de prácticas preprofesionales para la **Universidad San Gregorio de Portoviejo (USGP)**.

---

## 📋 Requisitos del Entorno
Para el correcto despliegue y ejecución del aplicativo en entorno local, se recomienda:
- **Servidor Web:** Apache 2.4+ (vía XAMPP, Laragon, WampServer o similar).
- **PHP:** Versión 7.4 o superior (recomendado PHP 8.x con extensiones `pdo_mysql`, `curl` y `openssl` habilitadas).
- **Base de Datos:** MySQL 5.7+.
- **Navegador Web:** Google Chrome, Mozilla Firefox, Microsoft Edge o cualquier navegador moderno.

---

## ⚙️ Instrucciones de Instalación y Despliegue

### 1. Ubicación del Proyecto
1. Descomprima el paquete del proyecto.
2. Copie la carpeta completa en el directorio raíz de su servidor web local:
   - **XAMPP:** `C:/xampp/htdocs/tienda-online/`
   - **Laragon:** `C:/laragon/www/tienda-online/`

### 2. Configuración de la Base de Datos
1. Inicie los servicios de **Apache** y **MySQL** desde el panel de control de su servidor local.
2. Abra su gestor de bases de datos (ej. phpMyAdmin en `http://localhost/phpmyadmin`).
3. Cree una nueva base de datos con los siguientes parámetros:
   - **Nombre de la BD:** `usgpcommerce`
   - **Cotejamiento (Collation):** `utf8mb4_unicode_ci` o `utf8mb4_general_ci`
4. Seleccione la base de datos `usgpcommerce` y diríjase a la pestaña **Importar**.
5. Cargue el archivo `base_datos.sql` adjunto en la entrega y haga clic en **Continuar / Importar**.

### 3. Parámetros de Conexión (`admin/db/conexion.php`)
El archivo de conexión principal a la base de datos utiliza **PDO** con los siguientes valores predeterminados para entorno local:

```php
$host = '127.0.0.1';     // o 'localhost'
$db_name = 'usgpcommerce';
$username = 'root';        // Usuario de MySQL
$password = '';            // Contraseña de MySQL
$charset = 'utf8mb4';
```

> *Nota:* Si su entorno MySQL tiene contraseña asignada o utiliza un puerto distinto a 3306, actualice estas variables directamente en `admin/db/conexion.php`.

### 4. Configuración de Pasarelas de Pago
- **PayPal:** Credenciales y configuración en `admin/db/config_paypal.php`.
- **PayPhone:** Parámetros y token de integración en `admin/db/config_payphone.php`.

### 5. Ejecución del Aplicativo
Abra su navegador web e ingrese a las siguientes direcciones:
- **Tienda (Catálogo y Clientes):** `http://localhost/PASANTIAS-USGP-main/index.php`
- **Panel Administrativo:** `http://localhost/PASANTIAS-USGP-main/admin/Alogin.php`

---

## 🔐 Credenciales de Acceso (Entorno de Pruebas)

### Panel de Administración (`/admin/Alogin.php`)
- **Usuario:** `[jnavarrete8251@utm.edu.ec]`
- **Contraseña:** `[admin123]`

---

## 📂 Estructura General del Directorio

```text
PASANTIAS-USGP-main/
├── admin/                         # Panel de administración y gestión
│   ├── css/                       # Hojas de estilo del área administrativa
│   ├── db/                        # Conexión a BD (conexion.php) y configs de pagos
│   ├── js/                        # Lógica y scripts interactivos de admin
│   ├── libs/PHPMailer/            # Librería PHPMailer para envío de correos
│   ├── usuario_admin/             # Gestión de roles y administradores
│   └── *.php                      # Vistas y controladores de administración
├── bases/                         # Plantillas modulares (header, footer, config_sesion)
├── style/                         # Recursos del cliente (CSS, JS e imágenes por categoría)
├── uploads/                       # Directorio de subidas (banners, productos, logos)
├── usuario/                       # Módulo de clientes (registro, perfil, login)
│   └── pagos/                     # Lógica y callbacks de pasarelas de pago
├── *.php                          # Vistas principales de la tienda (index, categorias, checkout)
├── base_datos.sql                 # Script para importar la base de datos
└── README.md                      # Documentación e instrucciones de instalación
```
