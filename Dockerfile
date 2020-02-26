FROM nginx:1.17-alpine

WORKDIR /usr

COPY index.html /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]