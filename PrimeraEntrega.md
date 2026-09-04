# BASE DE DATOS RELACIONAL PARA UNA PLATAFORMA DE GETIÓN DE EVENTOS Y CONFERENCIAS (EventCore)
*Laura Vanessa Camargo Ramirez - 2242749, Estefanny Cadena Ceballos - 2242739, Adriana de Cristo Pino Gómez, Danna Sofia Bautista Contreras - 2242750 y Robert Santiago Davila Rubriche - 2221936*

## 1. Introducción
Este documento corresponde a la primera entrega del proyecto de aula de Bases de Datos. El objetivo final es diseñar una base de datos relacional para una plataforma que permita gestionar eventos y conferencias de forma organizada, desde el registro de usuarios y la compra de entradas hasta el control de ingreso, la evaluación del evento y el análisis de las estadísticas de asistencia.

Antes de comenzar con el diseño de las tablas, se realizó una exploración previa del tema. Por eso este informe recoge tres cosas: los conceptos clave que hay que entender antes de modelar la base de datos, las tendencias actuales en este tipo de plataformas, y una revisión de dos herramientas que ya existen en el mercado, con el fin de tomar ideas para el desarrollo de nuestro proyecto.

## 2. Conceptos importantes 
Una plataforma de gestión de eventos es un sistema que administra todo el ciclo de vida de un evento, desde que una persona se registra hasta que el evento termina y se analizan sus resultados. Por esta razón, antes de diseñar la base de datos es importante tener claros algunos conceptos que estarán presentes durante el desarrollo del proyecto.
- **2.1 Base de datos relacional** 
Es la parte donde se almacena toda la información del sistema, organizada en diferentes tablas que están relacionadas entre sí, en este caso en una plataforma de eventos las principales tablas que se pueden encontrar son: Usuarios, Eventos, Entradas, Pagos, Servicios, Asistencias, Conferencias, Ponentes y Evaluaciones.
- **2.2 Gestión de usuarios** El sistema debe permitir manejar diferentes tipos de usuarios, ya que cada uno tendrá funciones y permisos específicos dentro de la plataforma. Estos usuarios son: administradores, organizadores, ponentes y asistentes.
- **2.3 Gestión de eventos** De cada evento será necesario guardar información básica como el nombre, la descripción, la fecha, el lugar donde se realizará, la cantidad máxima de asistentes, la categoría y su estado. Este estado permitirá saber si el evento está planeado, en curso o si ya finalizó.
- **2.4 Registro e inscripción** El proceso de inscripción debe ser sencillo para los asistentes. Primero, la persona deberá crear una cuenta, luego podrá inscribirse al evento y comprar su entrada. También sería importante permitir que pueda cancelar su asistencia cuando sea necesario.
- **2.5 Entradas y servicios asociados**Un mismo evento puede tener diferentes tipos de entradas, como general, VIP, estudiante o empresarial, por lo que cada tipo de entrada puede tener un precio, una cantidad de cupos y unos beneficios diferentes. Además, las entradas pueden incluir servicios adicionales como alimentación, parqueadero, certificado, material digital, acceso VIP o espacios para hacer networking. Esta parte es importante para el diseño de la base de datos ya que una entrada puede incluir varios servicios y un mismo servicio puede estar disponible para diferentes tipos de entradas. Por esta razón, la relación entre entradas y servicios es de muchos a muchos, por lo que se necesita una tabla intermedia para organizar esta información.
- **2.6 Pagos** La plataforma también debe guardar la información relacionada con los pagos realizados. Entre los datos se pueden incluir el valor pagado, el método de pago utilizado, la fecha y el estado del pago, que puede aparecer como pendiente, aprobado o rechazado.
- **2.7 Control de ingreso** Para controlar el ingreso al evento se puede utilizar un código QR, un código de barras o un número de registro. Al momento de entrar, la entrada se valida y queda registrada en el sistema, evitando que pueda utilizarse más de una vez.
- **2.8 Evaluación del evento** Después del evento, los asistentes pueden calificar la organización, los ponentes, las instalaciones, el contenido y su satisfacción general, esta información es necesaria ya que alimenta las estadísticas finales.
- **2.9 Estadisticas** La plataforma debe poder generar reportes como número de asistentes, entradas vendidas, ingresos, ocupación del aforo, eventos más populares y servicios más utilizados, estos indicadores son los que después le dan sentido a decisiones de diseño como usar vistas o tablas de resumen en la base de datos.
## 3. Tendencias actuales
Además de los conceptos básicos, también revisamos algunas de las tendencias que se están utilizando actualmente en las plataformas de gestión de eventos. Esto nos permite tener una idea de las funciones que podrían ser útiles dentro de nuestro proyecto.
- **3.1 Inteligencia artificial** Se está usando cada vez más para recomendar eventos, responder preguntas mediante chatbots, analizar la satisfacción de los asistentes y automatizar procesos administrativos.
- **3.2 Códigos QR** Los códigos QR siguen siendo una de las herramientas más utilizadas para registrar asistentes, controlar el acceso y validar las entradas de una manera rápida.
- **3.3 Eventos híbridos** Cada vez son más comunes los eventos híbridos, que combinan la asistencia presencial con una transmisión virtual para que las personas puedan participar de diferentes maneras.
- **3.4 Analítica de datos** Las plataformas actuales permiten analizar la información de los eventos mediante dashboards o paneles donde se pueden consultar datos como la ocupación, los ingresos, la participación y los resultados de las evaluaciones, muchas veces en tiempo real.
- **3.5 Aplicaciones móviles** Desde una aplicación móvil, los asistentes pueden consultar la agenda, recibir notificaciones, descargar certificados, ubicar las salas y mostrar o escanear su entrada para ingresar al evento.
- **3.6 Automatización** Procesos como la confirmación de inscripción, el envío de correos, los recordatorios y la generación de certificados se automatizan casi por completo.
- **3.7 Pasarelas de pago** Las plataformas actuales suelen integrar diferentes métodos de pago, como tarjetas, PSE, PayPal, Mercado Pago y Apple Pay, entre otros, para que los usuarios puedan escoger la opción que les resulte más cómoda.

## 4. Herramientas existentes en el mercado 
Para esta parte revisamos dos plataformas conocidas que resuelven un problema parecido al de nuestro proyecto, pero con enfoques distintos: Eventbrite, que es más sencilla y está orientada al autoservicio, y Cvent, que es más completa y se utiliza principalmente para eventos empresariales o de mayor tamaño.

- **4.1 Eventbrite** Es una de las plataformas más conocidas para organizar eventos y vender entradas.
Entre sus características principales están el registro de asistentes, la venta de entradas, los pagos en línea, los códigos QR, el control de ingreso, los reportes estadísticos y la aplicación móvil.
    - **Ventajas:** Es muy fácil de usar y tiene buena difusión de eventos, maneja un buen sistema de estadísticas y varios métodos de pago integrados.
    - **Desventajas:** Algunas funciones son de pago y la personalización en el plan gratuito es limitada.
- **4.1 Eventbrite** Es una plataforma profesional usada por empresas y universidades para eventos de gran escala, la cual cubre la gestión de asistentes, el registro en línea, la agenda del evento, el control de acceso, encuestas, reportes y eventos híbridos.
    - **Ventajas:** Es muy completa, ideal para eventos grandes y con gran capacidad de personalización y análisis.
    - **Desventajas:** Es costosa, más compleja de usar y requiere capacitación para aprovecharla al máximo.
 
 ## 5. Diagrama Entidad Relación
 ![image alt](https://github.com/RobertDavila1/EventCore/blob/8b753ba4e15e9939703d400ad7bdb43eddd0bcfd/DIagram%20ER.jpg)


