FROM zamith/phoenix
MAINTAINER Zamith <luis@zamith.pt>

WORKDIR /app

ENV MIX_ENV prod
COPY *.js* /app/
COPY mix.* /app/
COPY config /app/

RUN mix do deps.get --only prod, deps.compile
RUN npm install
RUN /app/node_modules/brunch/bin/brunch build --production

COPY . /app/
RUN mix compile && mix phoenix.digest

CMD ["mix", "phoenix.server"]
