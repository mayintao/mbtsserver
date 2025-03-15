FROM openjdk:17-jdk-slim
WORKDIR /app

# 安装 Tesseract OCR 及依赖
RUN apt-get update && apt-get install -y \
    wget \
    tesseract-ocr \
    libtesseract-dev \
    && rm -rf /var/lib/apt/lists/*

# 下载高精度 chi_sim.best 语言包
RUN wget -O /usr/share/tesseract-ocr/4.00/tessdata/chi_sim.traineddata \
    "https://github.com/tesseract-ocr/tessdata_best/raw/main/chi_sim.traineddata"

# 下载 GitHub Releases 里的 JAR
RUN wget -O app.jar "https://github.com/mayintao/mbtsserver/releases/download/mbts-0315-1/app-0.0.1-SNAPSHOT.jar"

# 让 Docker 监听 10000 端口
EXPOSE 10000

# 运行 JAR
CMD ["java", "-jar", "app.jar"]
