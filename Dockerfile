FROM node:16-alpine
USER root
RUN apk upgrade --available
RUN apk add --no-cache -U jq socat && rm -rf /var/cache/apk/*
RUN npm config set user root \
	&& npm config set registry https://registry.npm.taobao.org \
	&& npm install -g joplin 
RUN mkdir -p /joplin/profile 
COPY runtime.sh /
VOLUME /joplin/profile
EXPOSE 41182
CMD chown root:root /etc/crontabs/root && /usr/sbin/crond -f
ENTRYPOINT ["/runtime.sh"]