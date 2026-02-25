1. Análisis del Dominio

-Descripción del escenario

El sistema propuesto corresponde a una tienda en línea que necesita administrar su catálogo de productos organizados por categorías, controlar el inventario mediante el registro de precios y stock disponible, permitir que usuarios registrados agreguen productos a un carrito de compras y gestionar roles y permisos para diferentes tipos de usuarios.

-Objetivo del análisis del dominio

El objetivo de este análisis es identificar los elementos del mundo real que el sistema debe almacenar y gestionar, para posteriormente convertirlos en entidades dentro del Modelo Entidad-Relación.

Este paso es fundamental porque permite entender correctamente el problema antes de diseñar la base de datos, evitando errores estructurales en el modelo.

Conceptos relacionados con el catálogo

* Tienda
* Producto
* Categoría
* Inventario
* Precio
* Stock

Estos elementos permiten organizar los productos disponibles y controlar su disponibilidad.

Conceptos relacionados con usuarios

* Persona
* Usuario
* Registro
* Cuenta

Estos conceptos representan a las personas que interactúan con el sistema y sus credenciales de acceso.

Conceptos relacionados con compras

* Carrito
* Item de carrito
* Cantidad
* Total de compra

Estos elementos representan el proceso de selección de productos antes de realizar una compra.

Conceptos relacionados con seguridad

* Rol
* Permiso
* Módulo
* Acceso

Permiten definir qué acciones puede realizar cada usuario dentro del sistema.

Interpretación del escenario

A partir del análisis se concluye que el sistema debe permitir:

1. Organizar productos por categorías.
2. Controlar inventario con stock y precio.
3. Registrar usuarios y permitir carritos de compra.
4. Gestionar roles y permisos para seguridad.

Esto indica que el sistema necesita almacenar información estructurada y relaciones entre distintos tipos de datos.

Suposiciones del sistema

Para completar el análisis se establecen algunas reglas razonables:

* Cada producto pertenece a una categoría.
* Cada producto tiene información de inventario.
* Una persona puede tener una cuenta de usuario.
* Un usuario puede tener uno o varios carritos.
* Un carrito puede contener varios productos.
* Los roles determinan los permisos de acceso.

Estas suposiciones ayudan a definir mejor el modelo.

Resultado del análisis del dominio

Después del análisis se identifican los principales conceptos que se convertirán en entidades del modelo:

* Category
* Product
* Inventory
* Person
* User
* Shopping_Cart
* Shopping_Cart_Item
* Role
* Permission
* Module

Estos elementos representan los objetos reales que el sistema debe almacenar para funcionar correctamente.

Identificación de Entidades

Después de analizar el dominio del sistema de tienda en línea, se procede a identificar las entidades principales que representarán los objetos del mundo real dentro de la base de datos.

2.1 Entidades de Catálogo

Estas entidades permiten organizar y gestionar los productos disponibles en la tienda.

Entidades identificadas:

*Category
*Product
*Inventory

Justificación:

*Category* organiza los productos por tipo.
*Product* representa los artículos que se venden.
*Inventory* controla el stock y el precio de cada producto.

Estas entidades son fundamentales porque permiten conocer qué productos existen y si están disponibles.

Entidades de Usuarios

Estas entidades representan a las personas que interactúan con el sistema.

Entidades identificadas:

*Person
*User

Justificación:

*Person almacena información personal como nombre o fecha de nacimiento.
*User almacena credenciales del sistema como username y password.

Se separan porque no todas las personas necesariamente tienen acceso al sistema, y una persona puede tener diferentes cuentas en algunos casos.

2.3 Entidades de Negocio

Estas entidades manejan la lógica del carrito de compras.

Entidades identificadas:

*Shopping_Cart*
*Shopping_Cart_Item*

Justificación:

*Shopping_Cart  representa el carrito de cada usuario.
*Shopping_Cart_Item representa los productos agregados al carrito con su cantidad.

Esto permite que un carrito tenga varios productos y un producto pueda estar en muchos carritos.

2.4 Entidades de Seguridad

Estas entidades permiten controlar accesos dentro del sistema.

Entidades identificadas:

*Role
*Module
*Role_Permission

Justificación:

*Role define tipos de usuarios (admin, cliente, vendedor).
*Module  represena arte del sistema (inventario, ventas, reportes).
*Role_Permission define qué permisos tiene cada rol sobre cada módulo.

Esto permite controlar quién puede crear, editar o eliminar información.

 2.5 Lista Final de Entidades del Sistema

Después de clasificar el sistema, las entidades principales son:

* Category
* Product
* Inventory
* Person
* User
* Shopping_Cart
* Shopping_Cart_Item
* Role
* Module
* Role_Permission

Estas entidades serán utilizadas para construir el Modelo Entidad-Relación.

Definición de Atributos (Diccionario de Datos)

En este paso se definieron los atributos de cada entidad identificada en el dominio, incluyendo claves primarias, claves foráneas y restricciones para garantizar la integridad de la base de datos.

- Entity: Category

| Atributo    | Tipo         | Clave | Restricciones    | Descripción         |
| ----------- | ------------ | ----- | ---------------- | ------------------- |
| category_id | INT          | PK    | NOT NULL, AUTO   | Identificador único |
| name        | VARCHAR(80)  |       | NOT NULL, UNIQUE | Nombre de categoría |
| description | VARCHAR(200) |       | NULL             | Descripción         |
| is_active   | BOOLEAN      |       | DEFAULT TRUE     | Estado              |

Entity: Product

| Atributo    | Tipo         | Clave | Restricciones  | Descripción            |
| ----------- | ------------ | ----- | -------------- | ---------------------- |
| product_id  | INT          | PK    | NOT NULL, AUTO | Identificador          |
| category_id | INT          | FK    | NOT NULL       | Categoría del producto |
| name        | VARCHAR(120) |       | NOT NULL       | Nombre                 |
| sku         | VARCHAR(30)  |       | UNIQUE         | Código producto        |
| is_active   | BOOLEAN      |       | DEFAULT TRUE   | Estado                 |

Entity: User

| Atributo      | Tipo         | Clave | Restricciones | Descripción      |
| ------------- | ------------ | ----- | ------------- | ---------------- |
| user_id       | INT          | PK    | NOT NULL      | Identificador    |
| person_id     | INT          | FK    | NOT NULL      | Persona asociada |
| username      | VARCHAR(40)  |       | UNIQUE        | Usuario          |
| password_hash | VARCHAR(255) |       | NOT NULL      | Contraseña       |

Relaciones y Cardinalidades

En este paso se definen las relaciones entre las entidades identificadas en el dominio, estableciendo cómo interactúan entre sí dentro del sistema de tienda en línea. También se determinan las cardinalidades para indicar cuántos registros de una entidad pueden relacionarse con otra.

4.1 Relaciones del Catálogo

Category — Product

Relación: Una categoría tiene muchos productos.
Cardinalidad: 1 : N

Justificación:
Cada producto pertenece a una sola categoría, pero una categoría puede contener varios productos.
Ejemplo: Categoría *Bebidas* → Coca-Cola, Pepsi, Jugo.

Product — Inventory

Relación: Un producto tiene un registro de inventario.
Cardinalidad: 1 : 1

Justificación:
Cada producto tiene un precio y stock asociado. En este modelo se considera un solo inventario por producto.

4.2 Relaciones de Usuarios

Person — User

Relación: Una persona puede tener un usuario.
Cardinalidad: 1 : 1

Justificación:
Una persona registrada en el sistema tiene una cuenta de usuario asociada. Se separan para no mezclar datos personales con credenciales.

Role — User

Relación: Un rol puede estar asignado a muchos usuarios.
Cardinalidad: 1 : N

Justificación:
Muchos usuarios pueden tener el mismo rol, como CLIENTE o ADMIN.

4.3 Relaciones del Carrito

User — Shopping_Cart

Relación: Un usuario puede tener varios carritos.
Cardinalidad: 1 : N

Justificación:
Un usuario puede tener carritos históricos o activos.

Shopping_Cart — Shopping_Cart_Item

Relación:Un carrito tiene muchos items.
Cardinalidad: 1 : N

Justificación:
Un carrito puede contener varios productos.

Product — Shopping_Cart_Item

Relación: Un producto puede estar en muchos items.
Cardinalidad: 1 : N
*Justificación:
El mismo producto puede estar en diferentes carritos.

 4.4 Relaciones de Seguridad

Role — Role_Permission

Relación: Un rol tiene muchos permisos.
Cardinalidad: 1 : N

Module — Role_Permission

Relación: Un módulo tiene muchos permisos.
Cardinalidad: 1 : N

Justificación:
Un rol puede tener permisos en varios módulos, y un módulo puede ser accesible por varios roles.

 4.5 Resumen de Cardinalidades

| Relación                           | Cardinalidad |
| ---------------------------------- | ------------ |
| Category → Product                 | 1 : N        |
| Product → Inventory                | 1 : 1        |
| Person → User                      | 1 : 1        |
| Role → User                        | 1 : N        |
| User → Shopping_Cart               | 1 : N        |
| Shopping_Cart → Shopping_Cart_Item | 1 : N        |
| Product → Shopping_Cart_Item       | 1 : N        |
| Role → Role_Permission             | 1 : N        |
| Module → Role_Permission           | 1 : N        |

5. Modelo Relacional

En este paso se transforma el Modelo Entidad-Relación en un conjunto de tablas relacionales listas para implementarse en una base de datos.
Cada entidad se convierte en una tabla, y las relaciones se representan mediante claves foráneas.

5.1 Tablas del Sistema

 Category


Category(
    category_id PK,
    name UNIQUE NOT NULL,
    description,
    is_active,
    created_at
)
 Product


Product(
    product_id PK,
    category_id FK → Category(category_id),
    name NOT NULL,
    description,
    sku UNIQUE,
    is_active,
    created_at
)
 Inventory

Inventory(
    inventory_id PK,
    product_id FK → Product(product_id) UNIQUE,
    price NOT NULL,
    stock DEFAULT 0,
    last_update
)
 Person


Person(
    person_id PK,
    first_name NOT NULL,
    last_name NOT NULL,
    birth_date,
    email UNIQUE,
    phone,
    created_at
)
 Role

Role(
    role_id PK,
    name UNIQUE NOT NULL,
    description
)
 User

User(
    user_id PK,
    person_id FK → Person(person_id) UNIQUE,
    role_id FK → Role(role_id),
    username UNIQUE NOT NULL,
    password_hash NOT NULL,
    is_active,
    created_at
)

Shopping_Cart

Shopping_Cart(
    cart_id PK,
    user_id FK → User(user_id),
    status,
    created_at
)
Shopping_Cart_Item

Shopping_Cart_Item(
    cart_item_id PK,
    cart_id FK → Shopping_Cart(cart_id),
    product_id FK → Product(product_id),
    quantity DEFAULT 1,
    unit_price
)
 Module

Module(
    module_id PK,
    name UNIQUE NOT NULL,
    description
)
Role_Permission

Role_Permission(
    role_permission_id PK,
    role_id FK → Role(role_id),
    module_id FK → Module(module_id),
    can_create,
    can_read,
    can_update,
    can_delete
)
 5.2 Integridad Referencial

Las claves foráneas garantizan la coherencia de los datos:

* category_id conecta productos con su categoría.
* product_id conecta inventario con producto.
* person_id conecta usuario con persona.
* role_id conecta usuario con rol.
* cart_id conecta items con carrito.

Transformar a Modelo Relacional

En este paso se convierte el Modelo Entidad–Relación (MER) en el Modelo Relacional (MR), donde cada entidad se transforma en una tabla y las relaciones se representan mediante claves foráneas.

Este proceso permite definir cómo se estructurará la base de datos antes de implementarla en Excel o en un gestor como MySQL o PostgreSQL.

Reglas aplicadas

Durante la transformación se aplicaron las siguientes reglas:

* Cada entidad del MER se convirtió en una tabla.
* Cada atributo de la entidad se convirtió en una columna.
* Las relaciones 1:N se representaron con claves foráneas en la tabla del lado N.
* Las relaciones N:M se representaron con tablas intermedias.
* Se definieron restricciones como NOT NULL, UNIQUE y DEFAULT.

Estas reglas garantizan integridad referencial y consistencia en la base de datos.

Tablas resultantes

Las tablas obtenidas del modelo relacional fueron:

* Category
* Product
* Inventory
* Person
* User
* Role
* Module
* Role_Permission
* Shopping_Cart
* Shopping_Cart_Item

Cada una contiene su clave primaria y las claves foráneas necesarias para mantener las relaciones del sistema.

Ejemplos de Relaciones Transformadas

* Category → Product
  Se agregó **category_id** como FK en Product.

* Product → Inventory
  Se agregó **product_id** como FK en Inventory.

* User → Shopping_Cart
  Se agregó **user_id** como FK en Shopping_Cart.

* Shopping_Cart ↔ Product
  Se creó la tabla intermedia **Shopping_Cart_Item**.

* Role ↔ Module
  Se creó la tabla intermedia **Role_Permission**.


