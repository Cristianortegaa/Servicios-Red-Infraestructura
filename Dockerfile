FROM ubuntu:20.04

# Evitar preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar Nginx y el módulo LDAP
RUN apt-get update && \
    apt-get install -y nginx libnginx-mod-http-auth-ldap && \
    rm -rf /var/lib/apt/lists/* && \
    # Eliminar la configuración por defecto para evitar conflictos de puerto
    rm /etc/nginx/sites-enabled/default

# Redirigir logs a la salida estándar de Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
