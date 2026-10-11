# Flutter web for school360techx.com. Ignores the root Coming Soon index.html.
FROM ghcr.io/cirruslabs/flutter:stable AS builder
WORKDIR /src
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY . .
RUN flutter pub get && flutter build web --release

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /src/build/web /srv
ENV PORT=3000
ENV API_UPSTREAM=api:8000
EXPOSE 3000
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
