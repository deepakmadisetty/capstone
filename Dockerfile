FROM nginx:1.17-alpine

COPY index.html /usr/share/nginx/html

WORKDIR /app 

COPY kubernetes /app/kubernetes

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]