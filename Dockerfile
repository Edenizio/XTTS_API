# Usar uma imagem base com Python 3.11
FROM python:3.11-slim

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Atualizar e instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    build-essential \
    libsndfile1 \
    espeak-ng \
    ffmpeg \
    && git lfs install && apt-get clean

# Atualizar o pip antes de instalar as dependências
RUN python -m pip install --upgrade pip

# Copiar o arquivo de dependências para o container
COPY requirements.txt /app/requirements.txt

# Instalar as dependências listadas em requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Copiar o código do projeto e os modelos para o container
COPY . /app

# Expor a porta da API
EXPOSE 8000

# Comando para rodar a API
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--timeout-keep-alive", "120"]
