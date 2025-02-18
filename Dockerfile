# Gebruik een node image om te bouwen
FROM node:18 AS build

# Zet de werkdirectory
WORKDIR /app

# Kopieer je projectbestanden naar de container
COPY . .

# Installeer de dependencies
RUN npm install

# Bouw de Svelte-applicatie
RUN npm run build

# Gebruik een lichte webserver om de applicatie te serveren
FROM nginx:alpine

# Kopieer de gebouwde bestanden naar de Nginx container
COPY --from=build /app/public /usr/share/nginx/html

# Stel poort in
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
