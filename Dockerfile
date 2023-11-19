FROM denoland/deno:alpine

EXPOSE 8000

WORKDIR /app

# Cache the dependencies as a layer (the following two steps are re-run only when deps.ts is modified).
# ADD deps.ts .
# RUN deno cache deps.ts

# These steps will be re-run upon each file change in your working directory:
ADD . .
RUN deno cache app.ts

# These are passed as deno run <flags> main.ts
CMD ["run", "--allow-net", "app.ts"]
