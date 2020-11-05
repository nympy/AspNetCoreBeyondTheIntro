#!/bin/bash
dotnet pack ../RequestDiagnostics/RequestDiagnostics.csproj -o ../RuntimeStore/deployment/packages
dotnet store --manifest ./RuntimeStore.csproj --runtime linux-x64 --output ./deployment/store --skip-optimization
dotnet publish RuntimeStore.csproj -o ./deployment/temp

# Windows does this as xcopy ./deployment/temp/RuntimeStore.deps.json ./deployment/additionalDeps/shared/Microsoft.AspNetCore.App/3.1.0/RequestDiagnostics.deps.json* /y
mkdir -p ./deployment/additionalDeps/shared/Microsoft.AspNetCore.App/3.1.0/
cp ./deployment/temp/RuntimeStore.deps.json ./deployment/additionalDeps/shared/Microsoft.AspNetCore.App/3.1.0/RequestDiagnostics.deps.json
echo Delete the RuntimeStore/1.0.0 sections from the targets and libraries sections of ./deployment/additionalDeps/shared/Microsoft.AspNetCore.App/3.1.0/RequestDiagnostics.deps.json