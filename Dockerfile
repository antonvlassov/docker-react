FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# fase final nao precisa de label
# imagem do nginx ja possui um startup command para subir o nginx, assim nao eh necessario explicitar o CMD
# tag --from=label esepcifica a referencia da fase anterior
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
