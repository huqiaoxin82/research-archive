# 设置指南 - 研究资料归档系统

## 第一步：创建 GitHub 仓库

### 方式 1: 使用 GitHub 网站 (推荐)

1. 登录 GitHub: https://github.com
2. 点击右上角 "+" → "New repository"
3. 填写信息:
   - Repository name: `research-archive`
   - Description: `个人研究笔记与调研报告归档`
   - Visibility: Public (或 Private)
   - **不要**勾选 "Initialize this repository with a README"
4. 点击 "Create repository"

### 方式 2: 命令行创建 (需配置 GitHub Token)

```bash
# 设置 GitHub Token
export GITHUB_TOKEN=ghp_your_token_here

# 使用 curl 创建仓库
curl -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d '{
    "name": "research-archive",
    "description": "个人研究笔记与调研报告归档",
    "private": false
  }'
```

## 第二步：推送代码到 GitHub

在本地仓库目录执行：

```bash
cd /home/admin/clawd/research-archive

# 配置 Git 用户信息 (如未配置)
git config user.name "胡巧信"
git config user.email "your.email@example.com"

# 推送代码
git push -u origin main
```

**注意**: 如果需要身份验证，可以使用:
- GitHub Personal Access Token
- SSH 密钥
- GitHub CLI

## 第三步：启用 GitHub Pages

1. 打开仓库页面: https://github.com/huqiaoxin82/research-archive
2. 点击 "Settings" 标签
3. 左侧菜单选择 "Pages"
4. Source 选择:
   - **Deploy from a branch**
   - Branch: `main` / `docs`
5. 点击 "Save"

等待几分钟后，访问:
**https://huqiaoxin82.github.io/research-archive/**

## 第四步：设置 Cloudflare Pages (可选)

### 4.1 登录 Cloudflare

访问: https://dash.cloudflare.com

### 4.2 创建 Pages 项目

1. 点击左侧 "Workers & Pages"
2. 点击 "Create application"
3. 选择 "Pages" → "Connect to Git"

### 4.3 配置构建设置

- **Git provider**: GitHub
- **Repository**: huqiaoxin82/research-archive
- **Production branch**: main
- **Framework preset**: None
- **Build command**: (留空)
- **Build output directory**: `docs`

### 4.4 完成部署

点击 "Save and Deploy"

访问地址: **https://research-archive.pages.dev**

### 4.5 配置自定义域名 (可选)

1. 在 Pages 项目设置中点击 "Custom domains"
2. 添加你的域名
3. 按照提示配置 DNS

## 第五步：配置 Skill (可选)

编辑 Skill 配置文件，设置环境变量：

```bash
# 编辑 ~/.bashrc 或 ~/.zshrc
export GITHUB_TOKEN=ghp_your_github_token
export GITHUB_REPO=huqiaoxin82/research-archive
export CF_API_TOKEN=your_cloudflare_api_token
export CF_ACCOUNT_ID=your_cloudflare_account_id
```

然后重新加载配置:
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

## 验证部署

### 检查 GitHub Pages 状态

1. 访问仓库的 "Actions" 标签
2. 查看 "Deploy to GitHub Pages" 工作流运行状态

### 检查 Cloudflare Pages 状态

1. 登录 Cloudflare Dashboard
2. 进入 Pages 项目
3. 查看 "Deployments" 标签

## 故障排除

### Git 推送失败

```bash
# 检查远程仓库
git remote -v

# 重新设置远程仓库
git remote remove origin
git remote add origin https://github.com/huqiaoxin82/research-archive.git
```

### GitHub Pages 404

- 确认仓库是 Public (Private 仓库需要 GitHub Pro)
- 确认 `_config.yml` 存在且格式正确
- 检查 Actions 工作流是否成功运行

### Cloudflare Pages 构建失败

- 确认 Build output directory 设置为 `docs`
- 检查仓库文件是否正确推送
- 查看部署日志获取详细错误信息

## 后续操作

### 添加新研究报告

```bash
# 使用 Skill
cd /home/admin/clawd/research-archive
~/.openclaw/skills/research-publisher/publish.sh \
  --title "新研究报告" \
  --category "2025-03" \
  --tags "AI,技术" \
  --file ./new-report.md

# 或使用仓库脚本
./scripts/publish.sh "新研究报告" "2025-03" ./new-report.md
```

### 手动添加报告

1. 在 `docs/research/YYYY-MM/` 目录创建 Markdown 文件
2. 添加 YAML Front Matter 头部
3. 提交并推送: `git add . && git commit -m "添加报告" && git push`

---

**完成!** 你现在拥有一个完全自动化的研究资料归档系统。
