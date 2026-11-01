# Grupo PARA VOLQUETES
Web corporativa y CRM inicial. HTML/CSS/JavaScript sin dependencias de compilación, desplegable en Vercel.

## Estado
- Web: identidad proporcionada, seis familias referenciales y preparación de consultas para Facebook. El formulario NO envía ni almacena datos.
- CRM demo: productos, clientes, cotización de un producto por registro, seguimiento, CSV e impresión a PDF. Datos SOLO en memoria.
- CRM persistente: adaptador Supabase implementado; pendiente elegir proyecto, ejecutar database/setup.sql, crear miembros y configurar variables. No probado contra una base real.
- Catálogo público por familias; no sincroniza registros del CRM. Modelos, fichas, fotos, precios, contacto actualizado y stock pendientes de proporcionar/validar.
- Cotizaciones en PEN con precios IGV incluido. No genera comprobantes fiscales ni descuenta inventario al marcar Ganada. Stock editable manualmente.
- Las sesiones se guardan solo en memoria: al recargar se requiere ingresar nuevamente. No hay registro público; usuarios autorizados por pv_members.

## Ejecutar
`npm run dev` y abrir http://localhost:3000. En local sin API, usar demostración.
`npm test` para pruebas de validación, importes, escape y CSV.

## Activar datos compartidos
1. Seleccionar un proyecto NUEVO de Supabase en la organización acordada.
2. Ejecutar database/setup.sql una sola vez; habilita RLS en todas las tablas.
3. Crear/invitar usuarios en Auth; insertar sus UUID en pv_members desde consola administrativa.
4. Configurar SUPABASE_URL y SUPABASE_PUBLISHABLE_KEY en Vercel (nunca service_role). /api/config solo expone valores públicos.
5. Desplegar nuevamente; probar acceso autorizado, denegación a no miembros y CRUD persistente con dos sesiones.
6. Deshabilitar altas públicas si no se necesitan. No añadir usuarios a pv_members automáticamente.

## GitHub y despliegue
Repositorio: https://github.com/DelCaribeX/ParaVolquetes (público, creado por el usuario).
Proyecto Vercel creado: prj_PXH0aFA9enJuWyhzHWBw0RQUaqtq.
Dominio propio www.paravolquetes.com requiere confirmar titularidad y DNS antes de vincular. No se compró ningún dominio.

## Fuentes
- Logo adjuntado por el usuario.
- https://hidrovol.pe/ (referencia de estructura y familias, no contactos de PARA VOLQUETES).
- https://www.facebook.com/paravolquetes/ (enlace provisto; fotos no accesibles).
- Directorio Guía del Mecánico 2021: líneas de tomas de fuerza, adaptadores, bombas, tanques y válvulas. Datos históricos de contacto no publicados.
- Camión e iconos: ilustraciones SVG referenciales, no fotografías de productos ni modelos ofertados.

## Pendientes de producción
Validar catálogo y contactos; conectar y verificar base; repositorio GitHub; dominio propio y DNS; usuarios iniciales. Verificado en navegador: búsqueda de catálogo, cotización con total S/37.05 y actualización a Ganada en el resumen.
