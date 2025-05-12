FROM humbertovarona/nginxlite:v1

ARG BUILD_DATE
ARG VERSION="v1"

LABEL maintainer="VaronaTech"
LABEL build_version="GenCitation version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL org.opencontainers.image.authors="HL Varona <humberto.varona@gmail.com>"
LABEL org.opencontainers.image.description="DOI metadata generation"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"

ENV TIMEZONE=America/Recife
ENV REDIRECT_TO_HTTPS=no
ENV AUTOCERT=no

COPY src/index.html            /config/www/index.html
COPY src/script.js             /config/www/script.js
COPY src/styles.css            /config/www/styles.css
COPY src/formats.json          /config/www/formats.json

EXPOSE 80 443
