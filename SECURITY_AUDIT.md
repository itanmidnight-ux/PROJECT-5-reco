# Security audit

Estado: revisado el 2026-08-11.

## Corregido

- Eliminado el fallback JWT predecible del dashboard. En producción `DASHBOARD_JWT_SECRET` es obligatorio; en desarrollo se genera un secreto aleatorio por proceso.
- API y backend móvil ya no permiten CORS `*` con credenciales. Usan `CORS_ORIGINS` como allowlist explícita.
- `.env.example` conserva solo placeholders y ya no propone `admin` como contraseña.

## Riesgos residuales

- El dashboard aún puede enlazarse a todas las interfaces si se ejecuta con su host por defecto; usar red privada o proxy HTTPS y limitar firewall.
- El uso de pickle/modelos requiere cargar únicamente artefactos locales confiables.
- Las credenciales reales deben permanecer fuera del repositorio y rotarse si fueron expuestas.

Validación: compilación Python de módulos y revisión de autenticación, CORS, subprocessos y carga de modelos.
