FROM techempower/nodejs8:0.1

COPY ./ ./

RUN npm install

ENV NODE_HANDLER mongoose

CMD ["node", "app.js"]