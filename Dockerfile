FROM ubuntu:21.04
RUN apt-get update && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -yq \
		build-essential \
		curl \
		clang \
		file \
		git \
		meson \
		sudo \
		&& \
	apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -LS https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-12/wasi-sdk_12.0_amd64.deb -o wasi-sdk_12.0_amd64.deb \
	&& echo "64f623ad77828755becf43476c3e19dfef236867813fa79cff8d21ca0fb8a753  wasi-sdk_12.0_amd64.deb" | sha256sum -c \
	&& dpkg -i wasi-sdk_12.0_amd64.deb \
	&& rm wasi-sdk_12.0_amd64.deb \
	&& mv /opt/wasi-sdk/bin/wasm-ld /opt/wasi-sdk/bin/wasm-ld-orig
COPY wasm-ld-fix.sh /opt/wasi-sdk/bin/wasm-ld
WORKDIR /src
COPY meson.build ./
COPY subprojects subprojects
RUN meson subprojects download
COPY . .
RUN meson build --buildtype release --cross-file wasm-wasi.txt && ninja -Cbuild
