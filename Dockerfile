# Use newer Python base image
FROM python:3.12-slim

WORKDIR /app

# Install dependencies required by Chrome
RUN apt update && apt install -y \
    wget \
    unzip \
    gnupg \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxshmfence1 \
    libxss1 \
    libxt6 \
    libxtst6 \
    fonts-liberation \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome for Testing (stable, version-matched)
RUN wget https://storage.googleapis.com/chrome-for-testing-public/136.0.7103.59/linux64/chrome-linux64.zip \
    && unzip chrome-linux64.zip \
    && mv chrome-linux64 /opt/chrome \
    && ln -s /opt/chrome/chrome /usr/bin/google-chrome \
    && rm chrome-linux64.zip

# Install ChromeDriver (matching same version)
RUN wget https://storage.googleapis.com/chrome-for-testing-public/136.0.7103.59/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver \
    && chmod +x /usr/local/bin/chromedriver \
    && rm -rf chromedriver-linux64.zip chromedriver-linux64

# Install Python dependencies
RUN pip install --no-cache-dir selenium

# Copy the Selenium script
COPY firsttest.py .

# Run test
CMD ["python", "firsttest.py"]
