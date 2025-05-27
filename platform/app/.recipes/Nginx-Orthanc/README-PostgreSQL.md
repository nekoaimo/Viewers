# Orthanc with PostgreSQL Integration

## 概述

此配置将 Orthanc PACS 服务器与 PostgreSQL 数据库集成，而不是使用默认的 SQLite 文件存储。

## 配置变更

### 1. 数据库配置
- **数据库类型**: PostgreSQL 15
- **数据库名**: orthanc
- **用户名**: postgres
- **密码**: P@ss1234nekoaimo
- **端口**: 5432

### 2. Orthanc 配置修改
在 `config/orthanc.json` 中：
- 移除了 `StorageDirectory` 和 `IndexDirectory` 配置
- 添加了 `PostgreSQL` 配置块，包含数据库连接参数

### 3. Docker Compose 更新
- 添加了 PostgreSQL 服务
- 更新了 Orthanc 服务的依赖关系
- 移除了不必要的文件存储卷映射

## 启动服务

```bash
# 停止现有服务
docker-compose down

# 清理旧的数据（如果需要）
docker volume prune

# 启动服务
docker-compose up -d
```

## 数据持久化

- PostgreSQL 数据存储在 `./volumes/postgres_data/` 目录中
- Orthanc 的索引和存储都通过 PostgreSQL 管理

## 端口说明

- **8042**: Orthanc Web 界面和 REST API
- **4242**: DICOM 端口
- **5432**: PostgreSQL 数据库端口
- **80/443**: Nginx 代理端口

## 验证连接

1. 检查容器状态：
```bash
docker-compose ps
```

2. 查看 Orthanc 日志：
```bash
docker logs orthancPACS
```

3. 检查 PostgreSQL 连接：
```bash
docker exec -it postgres psql -U postgres -d orthanc -c "\dt"
```

## 数据库管理

### 连接到 PostgreSQL
```bash
docker exec -it postgres psql -U postgres -d orthanc
```

### 备份数据库
```bash
docker exec postgres pg_dump -U postgres orthanc > orthanc_backup.sql
```

### 恢复数据库
```bash
docker exec -i postgres psql -U postgres -d orthanc < orthanc_backup.sql
```

## 注意事项

1. **首次启动**: Orthanc PostgreSQL 插件会在首次连接时自动创建必要的数据库表
2. **性能**: PostgreSQL 通常比 SQLite 提供更好的并发性能
3. **备份**: 请定期备份 PostgreSQL 数据
4. **密码安全**: 在生产环境中请更改默认密码

## 故障排除

如果遇到连接问题：
1. 确保 PostgreSQL 容器已启动
2. 检查网络连接
3. 验证数据库凭据
4. 查看容器日志获取详细错误信息
