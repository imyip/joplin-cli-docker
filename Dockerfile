
ARG DENO_VERSION=1.22.0
FROM denoland/deno:bin-$DENO_VERSION AS deno
FROM node:16-alpine
COPY --from=deno /deno /usr/local/bin/deno
USER root
RUN apk update
RUN apk add --no-cache -U socat && rm -rf /var/cache/apk/*
RUN npm config set user root \
	&& npm config set registry https://registry.npm.taobao.org \
	&& npm install -g joplin 
RUN mkdir -p /joplin/profile 
COPY runtime.sh /root/
VOLUME /joplin/profile
EXPOSE 41182
ENTRYPOINT ["/root/runtime.sh"]