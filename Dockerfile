FROM mintplexlabs/anythingllm@sha256:a68a37266c23f826a7288d546149e0c79fdd6a5fc52026049bd00e620c4adb45
USER root
COPY k8sgpt_amd64.deb /tmp/
RUN dpkg -i /tmp/k8sgpt_amd64.deb \
    && cp /usr/bin/k8sgpt /app/k8sgpt \
    && chmod 755 /app/k8sgpt \
    && rm /tmp/k8sgpt_amd64.deb
ENV UV_TOOL_DIR=/opt/mcp/tools \
    UV_TOOL_BIN_DIR=/opt/mcp/bin \
    UV_PYTHON_INSTALL_DIR=/opt/mcp/python \
    UV_HTTP_TIMEOUT=300
RUN uv tool install mcp-grafana \
    && uv tool install prometheus-mcp-server \
    && chmod -R a+rX /opt/mcp \
    && ls /opt/mcp/bin
ENV PATH="/opt/mcp/bin:${PATH}"
