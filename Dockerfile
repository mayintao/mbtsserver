FROM openjdk:17-jdk-slim
WORKDIR /app

# 1️⃣ 安装 wget、Tesseract OCR 及所需依赖
RUN apt-get update && apt-get install -y \
    wget \
    tesseract-ocr \
    libtesseract-dev \
    && apt-get clean

# 2️⃣ 设置 OCR 语言包目录
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 3️⃣ 下载高精度 chi_sim 语言包
RUN wget -O ${TESSDATA_PREFIX}/chi_sim.traineddata "https://github.com/tesseract-ocr/tessdata_best/raw/main/chi_sim.traineddata"

# 4️⃣ 下载你的 JAR 文件
RUN wget -O app.jar "https://github.com/mayintao/mbtsserver/releases/download/mbts-0315-3/app-0.0.1-SNAPSHOT.jar"

# 5️⃣ 监听 10000 端口
EXPOSE 10000

# 6️⃣ 运行 JAR
CMD ["java", "-Xms512m", "-Xmx1024m", "-XX:+PrintGCDetails", "-jar", "app.jar"]

