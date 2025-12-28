<div align="center">

# 💰 PayFlow
### Modern Digital Wallet & Payment Platform

[![CI/CD Pipeline](https://github.com/VIKASH5203/payflow-app/actions/workflows/ci-cd.yaml/badge.svg)](https://github.com/VIKASH5203/payflow-app/actions/workflows/ci-cd.yaml)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-6DB33F?logo=spring-boot&logoColor=white)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=white)](https://reactjs.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<br/>

*A real-time digital wallet and payment platform built with microservices architecture, featuring event-driven communication, comprehensive monitoring, and modern CI/CD practices.*

<br/>

[Features](#-features) • [Architecture](#-architecture) • [Screenshots](#-screenshots) • [Quick Start](#-quick-start) • [Development](#-development-guide) • [Monitoring](#-monitoring)

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 💳 Core Features
- ✅ **Multi-Account Management** - Create & manage multiple wallets
- ✅ **Instant Transfers** - Real-time money transfers between accounts
- ✅ **Transaction History** - Complete audit trail of all transactions
- ✅ **Account Balance Tracking** - Live balance updates
- ✅ **Notifications** - Real-time transaction alerts

</td>
<td width="50%">

### 🔧 Technical Features
- ✅ **Microservices Architecture** - 4 independent scalable services
- ✅ **Event-Driven Design** - Apache Kafka for async communication
- ✅ **API Gateway** - Centralized routing & load balancing
- ✅ **Comprehensive Monitoring** - Prometheus + Grafana dashboards
- ✅ **CI/CD Pipeline** - Automated builds & deployments

</td>
</tr>
</table>

---

## 🏗️ Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                                    PayFlow Platform                                  │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                      │
│    ┌────────────┐         ┌─────────────────────────────────────────────────────┐   │
│    │            │         │              Kubernetes Cluster                      │   │
│    │   Users    │ ──────► │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐│   │
│    │            │         │  │ React   │  │  API    │  │Account  │  │  Txn    ││   │
│    └────────────┘         │  │Frontend │─►│ Gateway │─►│ Service │  │ Service ││   │
│                           │  │  :80    │  │  :8080  │  │  :8081  │  │  :8082  ││   │
│    ┌────────────┐         │  └─────────┘  └─────────┘  └────┬────┘  └────┬────┘│   │
│    │            │         │                                  │            │      │   │
│    │  Grafana   │◄────────│  ┌──────────────────────────────┴────────────┴───┐  │   │
│    │  :3001     │         │  │                Apache Kafka                    │  │   │
│    │            │         │  │            Event-Driven Messaging              │  │   │
│    └────────────┘         │  └──────────────────────────────┬────────────────┘  │   │
│                           │                                  │                    │   │
│    ┌────────────┐         │  ┌─────────┐  ┌─────────┐  ┌────┴────┐              │   │
│    │            │         │  │Postgres │  │Prometheus│  │ Notify  │              │   │
│    │ Prometheus │◄────────│  │  :5432  │  │  :9090  │  │ Service │              │   │
│    │  :9090     │         │  └─────────┘  └─────────┘  │  :8083  │              │   │
│    └────────────┘         │                            └─────────┘              │   │
│                           └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

### Microservices Communication Flow

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                           Transaction Flow (Event-Driven)                         │
├──────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│   ┌─────────┐    POST /transfer     ┌─────────────────┐                          │
│   │ Frontend│ ───────────────────►  │ Transaction Svc │                          │
│   └─────────┘                       └────────┬────────┘                          │
│                                              │                                    │
│                                              │ 1. Publish: transaction-initiated  │
│                                              ▼                                    │
│                                     ┌──────────────┐                             │
│                                     │    KAFKA     │                             │
│                                     └──────┬───────┘                             │
│                                            │                                      │
│              ┌────────────────────────────┬┴─────────────────────────────┐       │
│              │                            │                               │       │
│              ▼                            ▼                               ▼       │
│   ┌──────────────────┐        ┌──────────────────┐          ┌─────────────────┐  │
│   │  Account Service │        │  Account Service │          │ Notification Svc│  │
│   │   (Debit Acc)    │        │   (Credit Acc)   │          │  (Send Alert)   │  │
│   └────────┬─────────┘        └────────┬─────────┘          └─────────────────┘  │
│            │                           │                                          │
│            │ 2. debit-completed        │ 3. credit-completed                     │
│            └──────────┬────────────────┘                                          │
│                       ▼                                                           │
│              ┌──────────────┐                                                    │
│              │    KAFKA     │ ──► 4. transaction-completed ──► Notification      │
│              └──────────────┘                                                    │
│                                                                                   │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Technology Stack

<table>
<tr>
<th>Layer</th>
<th>Technology</th>
<th>Version</th>
<th>Purpose</th>
</tr>
<tr>
<td><b>🎨 Frontend</b></td>
<td>React, TypeScript, Tailwind CSS, Vite</td>
<td>18.x</td>
<td>Modern responsive UI</td>
</tr>
<tr>
<td><b>⚙️ Backend</b></td>
<td>Java, Spring Boot, Spring Cloud Gateway</td>
<td>21 / 3.2</td>
<td>Microservices framework</td>
</tr>
<tr>
<td><b>🗄️ Database</b></td>
<td>PostgreSQL</td>
<td>15</td>
<td>Relational data storage</td>
</tr>
<tr>
<td><b>📨 Messaging</b></td>
<td>Apache Kafka</td>
<td>3.7</td>
<td>Event-driven communication</td>
</tr>
<tr>
<td><b>🐳 Containers</b></td>
<td>Docker, Docker Compose</td>
<td>24.x</td>
<td>Containerization</td>
</tr>
<tr>
<td><b>☸️ Orchestration</b></td>
<td>Kubernetes (Docker Desktop / K3s)</td>
<td>1.28+</td>
<td>Container orchestration</td>
</tr>
<tr>
<td><b>🔄 CI/CD</b></td>
<td>GitHub Actions, GHCR</td>
<td>-</td>
<td>Automated pipeline</td>
</tr>
<tr>
<td><b>📊 Monitoring</b></td>
<td>Prometheus, Grafana, Micrometer</td>
<td>2.48 / 10.2</td>
<td>Metrics & dashboards</td>
</tr>
<tr>
<td><b>🔀 Reverse Proxy</b></td>
<td>NGINX</td>
<td>1.25</td>
<td>Load balancing & routing</td>
</tr>
</table>

---

## 📁 Project Structure

```
payflow-app/
│
├── 🎨 frontend/                    # React Frontend Application
│   ├── src/
│   │   ├── components/            # Reusable UI components
│   │   ├── pages/                 # Page components (Dashboard, Accounts, etc.)
│   │   ├── services/              # API service layer
│   │   └── styles/                # Tailwind CSS styles
│   ├── Dockerfile                 # Frontend container
│   └── nginx.conf                 # NGINX config for SPA routing
│
├── ⚙️ services/                    # Backend Microservices
│   ├── api-gateway/               # API Gateway (Port 8080)
│   │   └── Spring Cloud Gateway routing
│   ├── account-service/           # Account Management (Port 8081)
│   │   └── Account CRUD, Balance management
│   ├── transaction-service/       # Transaction Processing (Port 8082)
│   │   └── Money transfers, Transaction history
│   └── notification-service/      # Notifications (Port 8083)
│       └── Email/SMS alerts, Event consumers
│
├── ☸️ k8s/                         # Kubernetes Manifests
│   ├── deployments/               # Deployment configs
│   ├── services/                  # Service definitions
│   ├── configmaps/                # Configuration data
│   ├── secrets/                   # Sensitive data
│   ├── monitoring/                # Prometheus & Grafana
│   │   ├── prometheus.yaml
│   │   ├── grafana.yaml
│   │   └── kafka-exporter.yaml
│   └── setup-k8s.ps1              # K8s deployment script
│
├── 🔀 nginx/                       # NGINX Reverse Proxy
│   └── nginx.conf                 # Routing configuration
│
├── 🔄 .github/workflows/           # CI/CD Pipeline
│   └── ci-cd.yaml                 # GitHub Actions workflow
│
└── 🐳 docker-compose.yml           # Local development setup
```

---

## 🚀 Quick Start

### Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Java | 21+ | Backend services |
| Maven | 3.8+ | Build tool |
| Node.js | 20+ | Frontend |
| Docker | 24+ | Containers |
| kubectl | 1.28+ | Kubernetes CLI |

### Option 1: Docker Compose (Recommended for Development)

```bash
# Clone the repository
git clone https://github.com/VIKASH5203/payflow-app.git
cd payflow-app

# Start all services
docker-compose up -d

# Access the application
# Frontend: http://localhost:8000
# API Gateway: http://localhost:8080
```

### Option 2: Kubernetes (Production-like)

```powershell
# Enable Kubernetes in Docker Desktop

# Deploy all services
.\k8s\setup-k8s.ps1

# Port-forward to access services
kubectl port-forward svc/frontend 8000:80 -n payflow

# Access the application
# Frontend: http://localhost:8000
# Grafana: http://localhost:3001
```

---

## 🔧 Development Guide

### Step 1: Local Environment Setup

```bash
# Verify prerequisites
java -version      # Should be 21+
mvn -version       # Should be 3.8+
node -version      # Should be 20+
docker --version   # Should be 24+
```

### Step 2: Build Backend Services

```bash
# Build all services
cd services
mvn clean package -DskipTests

# Or build individually
cd account-service
mvn clean package
```

### Step 3: Build Frontend

```bash
cd frontend
npm install
npm run build
```

### Step 4: Run with Docker Compose

```bash
# Build and start all containers
docker-compose build
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Step 5: Run on Kubernetes

```powershell
# Apply all manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/secrets/
kubectl apply -f k8s/configmaps/
kubectl apply -f k8s/deployments/
kubectl apply -f k8s/services/
kubectl apply -f k8s/monitoring/

# Check pod status
kubectl get pods -n payflow

# Port forward for access
kubectl port-forward svc/frontend 8000:80 -n payflow
kubectl port-forward svc/grafana 3001:3000 -n payflow
```

---

## 📨 API Reference

### Account Service (Port 8081)

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/accounts` | Create new account |
| `GET` | `/api/accounts/{id}` | Get account by ID |
| `GET` | `/api/accounts/number/{num}` | Get by account number |
| `GET` | `/api/accounts` | List all accounts |
| `PUT` | `/api/accounts/balance` | Update balance |

### Transaction Service (Port 8082)

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/transactions` | Initiate transfer |
| `GET` | `/api/transactions/{id}` | Get transaction |
| `GET` | `/api/transactions/account/{num}` | Get by account |

### API Gateway Routes (Port 8080)

| Route | Target Service |
|-------|----------------|
| `/api/accounts/**` | Account Service |
| `/api/transactions/**` | Transaction Service |
| `/api/notifications/**` | Notification Service |

---

## 🔄 Kafka Event Topics

```
┌────────────────────────────────────────────────────────────────────────┐
│                         Kafka Topics Flow                               │
├────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   transaction-initiated  ──► Account Service (process debit/credit)   │
│                                                                         │
│   debit-completed       ──► Transaction Service (update status)        │
│                                                                         │
│   credit-completed      ──► Transaction Service (complete transfer)    │
│                                                                         │
│   transaction-completed ──► Notification Service (send alerts)         │
│                                                                         │
│   transaction-failed    ──► Notification Service (failure alerts)      │
│                                                                         │
│   account-created       ──► Notification Service (welcome message)     │
│                                                                         │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 📊 Monitoring

### Grafana Dashboards

Access Grafana at `http://localhost:3001` (Credentials: `admin` / `payflow123`)

#### Available Metrics:

| Section | Metrics |
|---------|---------|
| **HTTP Traffic** | Request rate, Response time by service |
| **Apache Kafka** | Active brokers, Topic partitions, Consumer lag |
| **JVM Memory** | Heap usage, Memory percentage |
| **CPU & Threads** | CPU usage, Live threads per service |
| **Service Health** | UP/DOWN status for all services |

### Prometheus Targets

Access Prometheus at `http://localhost:9090/targets`

| Target | Endpoint | Metrics |
|--------|----------|---------|
| account-service | `:8081/actuator/prometheus` | JVM, HTTP, custom |
| transaction-service | `:8082/actuator/prometheus` | JVM, HTTP, custom |
| notification-service | `:8083/actuator/prometheus` | JVM, HTTP, custom |
| api-gateway | `:8080/actuator/prometheus` | JVM, HTTP, routing |
| kafka-exporter | `:9308/metrics` | Kafka broker metrics |

---

## 🔄 CI/CD Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           GitHub Actions CI/CD                                   │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   ┌─────────┐      ┌─────────┐      ┌─────────┐      ┌─────────┐              │
│   │  Code   │ ──►  │  Build  │ ──►  │  Test   │ ──►  │  Push   │              │
│   │  Push   │      │ Maven   │      │ JUnit   │      │  GHCR   │              │
│   └─────────┘      └─────────┘      └─────────┘      └─────────┘              │
│                                                                                  │
│   Triggers:                                                                      │
│   • Push to main/develop branches                                               │
│   • Pull requests                                                                │
│   • Path-based filtering (only build changed services)                          │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Branch Strategy (GitFlow)

| Branch | Purpose | Deploys To |
|--------|---------|------------|
| `main` | Production-ready code | Production |
| `develop` | Integration branch | Staging |
| `feature/*` | New features | - |
| `hotfix/*` | Production fixes | Production |

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 👨‍💻 Author

<div align="center">

**Vikash Kumar**

[![GitHub](https://img.shields.io/badge/GitHub-VIKASH5203-181717?logo=github)](https://github.com/VIKASH5203)

</div>

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

### ⭐ Star this repo if you found it helpful!

Made with ❤️ using Spring Boot, React & Kubernetes

</div>
