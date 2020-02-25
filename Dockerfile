FROM nginx:1.17-alpine

COPY index.html /usr/share/nginx/html

RUN apt-get update

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]