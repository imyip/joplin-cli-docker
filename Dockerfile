FROM node:16-alpine

RUN apk upgrade --available
RUN apk add --no-cache -U dcron libcap jq socat

RUN npm config set user root \
	&& npm config set registry https://registry.npm.taobao.org \
	&& npm install -g joplin 

RUN mkdir -p /joplin/profile \
	&& chown node:node /joplin/profile

RUN chown node:node /usr/sbin/crond \
	&& setcap cap_setgid=ep /usr/sbin/crond

COPY runtime.sh /
USER node

RUN chmod +x /runtime.sh

VOLUME /joplin/profile
EXPOSE  41182

ENTRYPOINT ["/runtime.sh"]