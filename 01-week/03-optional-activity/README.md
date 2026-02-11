### ¿Qué criterios usaría para decidir cuándo migrar de archivos planos a un SGBD?

Se decidiría migrar de archivos planos a un Sistema de Gestión de Bases de Datos (SGBD cuando la cantidad de registros almacenados sea considerablemente amplia, ya que el manejo manual de grandes volúmenes de datos dificulta su organización y mantenimiento.

Otro criterio importante es cuando muchas personas manipulan simultáneamente los datos, pues los archivos planos no garantizan el control de concurrencia, lo que puede generar inconsistencias, pérdida de información o errores en los registros.

Finalmente, la latencia en los tiempos de respuesta al consultar información también es un factor clave. Cuando acceder a ciertos datos se vuelve lento o poco eficiente, un SGBD permite optimizar las consultas, mejorar el rendimiento y asegurar un acceso más rápido y confiable a la información.
