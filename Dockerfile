FROM node:latest

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HUBOT_SLACK_TOKEN xoxb-nope-nope
ENV HUBOT_NAME hangbot
ENV HUBOT_OWNER sntxrr
ENV HUBOT_DESCRIPTION Hangbot a HangOps #job-board Hubot
ENV EXTERNAL_SCRIPTS "hubot-help,hubot-pugme"

RUN useradd hangbot -m

RUN npm install -g hubot coffee-script yo generator-hubot

USER hangbot

WORKDIR /home/hangbot

#RUN yo hubot --owner="${HUBOT_OWNER}" --name="${HUBOT_NAME}" --description="${HUBOT_DESCRIPTION}" --defaults && sed -i /heroku/d ./external-scripts.json && sed -i /redis-brain/d ./external-scripts.json && npm install hubot-scripts && npm install hubot-slack --save

VOLUME ["/home/hubot/scripts"]

CMD node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
	npm install $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))") && \
	bin/hubot -n $HUBOT_NAME --adapter slack