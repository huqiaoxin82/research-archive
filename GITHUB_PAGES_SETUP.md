# GitHub Pages 手动启用指南

## 问题
GitHub Pages 未启用，导致 404 错误。

## 解决步骤

### 1. 登录 GitHub 并访问仓库设置
打开: https://github.com/huqiaoxin82/research-archive/settings/pages

### 2. 配置 Source
在 "Build and deployment" 部分:
- **Source**: 选择 "GitHub Actions"

### 3. 保存并等待
点击 "Save" 后，GitHub Actions 会自动构建并部署。

### 4. 验证部署
等待 1-2 分钟后访问:
- https://huqiaoxin82.github.io/research-archive/

## 当前配置检查

仓库已配置 Hugo + GitHub Actions 工作流:
- 工作流文件: `.github/workflows/hugo-deploy.yml`
- 构建命令: `hugo --gc --minify --baseURL "https://huqiaoxin82.github.io/research-archive/"`
- 输出目录: `public/`

## 备用方案

如果 GitHub Actions 有问题，可以改为分支部署:
1. Source 选择 "Deploy from a branch"
2. Branch 选择 "gh-pages" / "(root)"
3. 需要额外配置工作流来推送到 gh-pages 分支
