# 1️⃣ 使用 OpenJDK 17 作为基础镜像
FROM openjdk:17-jdk-slim

# 2️⃣ 设置工作目录
WORKDIR /app

# 3️⃣ 安装必要工具和 Tesseract OCR
RUN apt-get update && apt-get install -y \
    wget \
    tesseract-ocr \
    libtesseract-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # 清理无用缓存，减小镜像体积

# 4️⃣ 设置 OCR 语言包目录
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 5️⃣ 下载高精度 `chi_sim` 和 `chi_sim_vert` 语言包
RUN wget -q -O ${TESSDATA_PREFIX}/chi_sim.traineddata \
    "https://github.com/tesseract-ocr/tessdata_best/raw/main/chi_sim.traineddata" \
    && wget -q -O ${TESSDATA_PREFIX}/chi_sim_vert.traineddata \
    "https://github.com/tesseract-ocr/tessdata_best/raw/main/chi_sim_vert.traineddata"

# 6️⃣ 下载 JAR 文件
RUN wget -q -O app.jar \
    "https://github.com/mayintao/mbtsserver/releases/download/mbts-0515-1/app-0.0.1-SNAPSHOT.jar"

# 7️⃣ 监听 10000 端口
EXPOSE 10000

# 8️⃣ 运行 JAR，并增加容器内存限制，防止 OOM
CMD ["java", "-Xms512m", "-Xmx512m", "-Xlog:gc*", "-jar", "app.jar"]
