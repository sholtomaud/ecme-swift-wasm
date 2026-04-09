FROM swift:6.0-bookworm

# 1. Install System Dependencies
RUN apt-get update && apt-get install -y \
    make \
    git \
    curl \
    python3 \
    python3-pip \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Install pre-commit
RUN pip3 install pre-commit --break-system-packages

# 3. Install SwiftLint (Linux Binary)
# Note: SwiftLint on Linux is often installed via a specific release build
RUN SWIFTLINT_URL=$(curl -s https://api.github.com/repos/realm/SwiftLint/releases/latest | grep "browser_download_url.*swiftlint_linux.zip" | cut -d '"' -f 4) \
    && curl -L $SWIFTLINT_URL -o swiftlint.zip \
    && unzip swiftlint.zip -d /usr/local/bin \
    && rm swiftlint.zip

WORKDIR /app

# Copy package files first to cache dependencies
COPY Package.swift ./
RUN swift package resolve

COPY . .

# Initialize pre-commit hooks in the container
RUN git init && pre-commit install

CMD ["make", "test"]