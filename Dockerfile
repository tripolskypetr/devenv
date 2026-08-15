FROM ubuntu:24.04

WORKDIR /app
RUN cd /app

RUN apt update
RUN apt install -y curl wget tmux unzip zip bash git

RUN bash -xc "$(curl -fsSL https://bun.sh/install)"
RUN bash -xc "$(curl -fsSL https://deb.nodesource.com/setup_25.x)"
RUN bash -xc "$(curl -fsSL https://claude.ai/install.sh)"

RUN curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc > /dev/null
RUN echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" > /etc/apt/sources.list.d/ngrok.list
RUN apt update && apt install -y ngrok

RUN apt install -y nodejs

RUN npm install -g pm2 --verbose
RUN npm install -g serve --verbose
RUN npm install -g dotenv --verbose
RUN npm install -g kill-port --verbose
RUN npm install -g rimraf --verbose
RUN npm install -g http-server --verbose

ENV BUN_INSTALL="/root/.bun"
ENV PATH="/root/.bun/bin:/root/.local/bin:$PATH"

RUN printf '\n# devenv tools\nexport BUN_INSTALL="$HOME/.bun"\nexport PATH="$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"\n' >> /root/.bashrc

EXPOSE 60050

CMD ["sleep", "infinity"]
