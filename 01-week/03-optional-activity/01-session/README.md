### ¿Qué criterios usaría para decidir cuándo migrar de archivos planos a un SGBD?

Migraría de archivos planos a un Sistema de Gestión de Bases de Datos (SGBD) cuando se presenten problemas como duplicación de información, inconsistencias en los datos, dificultad para consultar información histórica y aumento en el volumen de datos.  
También sería un criterio importante la necesidad de garantizar la integridad de la información, controlar el acceso a los datos y permitir que varios usuarios trabajen simultáneamente sin generar errores.  
Cuando el manejo manual de archivos deja de ser eficiente, seguro o escalable, el uso de un SGBD se vuelve necesario.

### ¿Qué tipo de SGBD (relacional o NoSQL) parece más adecuado para este contexto y por qué?

Para este contexto, el SGBD más adecuado es un sistema relacional, ya que la información manejada (estudiantes, asignaturas y notas) tiene una estructura bien definida y relaciones claras entre los datos.  
Un SGBD relacional permite aplicar claves primarias y foráneas, asegurar la integridad referencial y realizar consultas SQL para obtener reportes consolidados, como el historial académico de un estudiante.  
Los sistemas NoSQL son más apropiados para datos no estructurados o de gran volumen sin relaciones estrictas, lo cual no es el caso de este escenario académico.