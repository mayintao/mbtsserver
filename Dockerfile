FROM openjdk:17-jdk-slim
WORKDIR /app

# 安装 wget
RUN apt-get update && apt-get install -y wget

# 下载 GitHub Releases 里的 JAR
RUN wget -O app.jar "https://github.com/mayintao/mbtsserver/releases/download/0227-3/app-0.0.1-SNAPSHOT.jar"

# 让 Docker 监听 10000 端口
EXPOSE 10000

# 运行 JAR
CMD ["java", "-jar", "app.jar"]
