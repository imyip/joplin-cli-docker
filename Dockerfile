FROM node:16-alpine
RUN apk upgrade --available
RUN apk add --no-cache -U dcron jq socat
RUN npm config set user root \
	&& npm config set registry https://registry.npm.taobao.org \
	&& npm install -g joplin 
RUN mkdir -p /joplin/profile \
	&& chown node:node /joplin/profile \
	&& chown node:node /usr/sbin/crond 
COPY runtime.sh /
USER node
VOLUME /joplin/profile
EXPOSE 41182
ENTRYPOINT ["/runtime.sh"]