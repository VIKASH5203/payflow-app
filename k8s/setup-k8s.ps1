# PayFlow Kubernetes Local Deployment Script
# Run this to deploy the entire application to local Kubernetes

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PayFlow Kubernetes Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Create Namespace
Write-Host "`n[1/6] Creating namespace..." -ForegroundColor Yellow
kubectl apply -f namespace.yaml

# Step 2: Create Secrets and ConfigMaps
Write-Host "`n[2/6] Creating secrets and configmaps..." -ForegroundColor Yellow
kubectl apply -f secrets/
kubectl apply -f configmaps/

# Step 3: Deploy Infrastructure (Postgres, Kafka)
Write-Host "`n[3/6] Deploying infrastructure (Postgres, Kafka)..." -ForegroundColor Yellow
kubectl apply -f deployments/postgres.yaml
kubectl apply -f deployments/kafka.yaml

Write-Host "Waiting for infrastructure to be ready..." -ForegroundColor Gray
Start-Sleep -Seconds 15

# Step 4: Deploy Backend Services
Write-Host "`n[4/6] Deploying backend services..." -ForegroundColor Yellow
kubectl apply -f deployments/account-service.yaml
kubectl apply -f deployments/transaction-service.yaml
kubectl apply -f deployments/notification-service.yaml
kubectl apply -f deployments/api-gateway.yaml

# Step 5: Deploy Frontend
Write-Host "`n[5/6] Deploying frontend..." -ForegroundColor Yellow
kubectl apply -f deployments/frontend.yaml

# Step 6: Create Services (ClusterIP for internal communication)
Write-Host "`n[6/6] Creating internal services..." -ForegroundColor Yellow
kubectl apply -f services/

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  Deployment Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nNext Step - Start Port Forwarding:" -ForegroundColor Cyan
Write-Host "  .\port-forward.ps1 all     # Forward all services" -ForegroundColor White
Write-Host ""
Write-Host "Then access:" -ForegroundColor Cyan
Write-Host "  Frontend:    http://localhost:8000" -ForegroundColor White
Write-Host "  API Gateway: http://localhost:8080" -ForegroundColor White
Write-Host "  Swagger UI:  http://localhost:8080/swagger-ui.html" -ForegroundColor White

Write-Host "`nUseful commands:" -ForegroundColor Cyan
Write-Host "  kubectl get pods -n payflow           # Check pod status" -ForegroundColor Gray
Write-Host "  kubectl logs -f <pod-name> -n payflow # View logs" -ForegroundColor Gray
Write-Host "  .\port-forward.ps1 stop               # Stop port-forwards" -ForegroundColor Gray
