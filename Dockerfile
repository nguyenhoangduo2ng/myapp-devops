# --- GIAI ĐOẠN 1: BUILD ---
# Dùng image python đầy đủ để cài đặt thư viện
FROM python:3.12-slim AS builder

WORKDIR /app
COPY requirements.txt .

# Cài thư viện vào một thư mục riêng (--prefix)
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- GIAI ĐOẠN 2: RUNTIME ---
# Dùng một image siêu nhỏ (alpine) để chạy
FROM python:3.12-alpine

WORKDIR /app

# CHỈ COPY thư viện đã cài từ giai đoạn build sang
COPY --from=builder /install /usr/local

# Copy code ứng dụng
COPY app.py .

EXPOSE 500
CMD ["python", "app.py"]
