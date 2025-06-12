# resource "aws_key_pair" "ssh_key" {
#   key_name   = var.key_name
#   public_key = file("/home/cristian/.ssh/id_rsa.pub")
# }

# Crear una VPC para alojar la Subnet y el Security Group
resource "aws_vpc" "n8n_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "n8nVPC"
  }
}

# Crear una Internet Gateway
resource "aws_internet_gateway" "n8n_igw" {
  vpc_id = aws_vpc.n8n_vpc.id

  tags = {
    Name = "n8nIGW"
  }
}

# Crear una Tabla de Rutas para acceso a Internet
resource "aws_route_table" "n8n_rt" {
  vpc_id = aws_vpc.n8n_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.n8n_igw.id
  }

  tags = {
    Name = "n8nRouteTable"
  }
}

# Crear una Subnet pública dentro de la VPC
resource "aws_subnet" "n8n_subnet" {
  vpc_id                  = aws_vpc.n8n_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true  # Se asigna IP pública automáticamente

  tags = {
    Name = "n8nSubnet"
  }
}

# Asociar la Subnet a la Tabla de Rutas para acceso a Internet
resource "aws_route_table_association" "n8n_rta" {
  subnet_id      = aws_subnet.n8n_subnet.id
  route_table_id = aws_route_table.n8n_rt.id
}

# Security Group
resource "aws_security_group" "ssh_access" {
  name        = "allow_tcp"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.n8n_vpc.id

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2 ahora usa la Subnet con acceso a Internet
resource "aws_instance" "n8n_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  # key_name      = var.key_name

  subnet_id              = aws_subnet.n8n_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  associate_public_ip_address = true  # Asegura que tenga IP pública

  tags = {
    Name = "n8nServer"
  }



  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker ec2-user

    # Instalar Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Crear estructura de archivos
    mkdir -p /home/ec2-user/n8n
    cd /home/ec2-user/n8n

    # Crear el archivo docker-compose.yaml
    cat <<EOF2 > docker-compose.yaml
    version: '3'
    services:
      reverse-proxy:
        image: traefik:v2.10
        command:
          - --log.level=INFO
          - --api.insecure=true
          - --providers.docker=true
          - --providers.docker.exposedbydefault=false
          - --entryPoints.web.address=:80
          - --entryPoints.websecure.address=:443
          - --certificatesResolvers.myresolver.acme.email=cristian@laboratoriosconcristian.site
          - --certificatesResolvers.myresolver.acme.storage=/etc/traefik/acme.json
          - --certificatesResolvers.myresolver.acme.httpChallenge.entryPoint=web
        ports:
          - "80:80"
          - "443:443"
          - "8080:8080"
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - ./traefik:/etc/traefik/

      n8n:
        image: n8nio/n8n
        labels:
          - "traefik.enable=true"
          - "traefik.http.routers.n8n.rule=Host(%%BACKTICK%%${var.n8n_domain}%%BACKTICK%%)"
          - "traefik.http.routers.n8n.entryPoints=websecure"
          - "traefik.http.routers.n8n.tls.certResolver=myresolver"
        container_name: n8n
        restart: always
        volumes:
          - n8n_data:/home/node/.n8n

    volumes:
      n8n_data:
    EOF2

    # Reemplazar el marcador por la tilde invertida real
    sed -i 's/%%BACKTICK%%/\`/g' /home/ec2-user/n8n/docker-compose.yaml
    
    cd /home/ec2-user/n8n
    docker-compose up -d
  EOF

}
