# 研究资料归档系统

> 个人研究笔记与调研报告归档仓库
> 作者：胡巧信

## 📚 访问地址

- **GitHub Pages**: https://huqiaoxin82.github.io/research-archive/
- **Cloudflare Pages**: https://research-archive.pages.dev (备用镜像)

## 📁 目录结构

```
research-archive/
├── docs/                          # GitHub Pages 源文件
│   ├── index.md                   # 首页/索引
│   ├── _config.yml                # Jekyll 配置
│   └── research/                  # 研究报告目录
│       └── 2025-02/               # 按日期分类
│           ├── openclaw-skills.md
│           ├── x-youtube-to-bilibili.md
│           └── content-site-adsense.md
├── scripts/                       # 自动化脚本
│   ├── publish.sh                 # 发布新研究报告
│   └── sync-cloudflare.sh         # 同步到 Cloudflare
├── README.md                      # 本文件
└── .github/workflows/             # GitHub Actions
    └── deploy.yml                 # 自动部署配置
```

## 📖 现有研究报告

| 日期 | 标题 | 关键词 |
|------|------|--------|
| 2025-02 | [OpenClaw Skills 项目整理](./docs/research/2025-02/openclaw-skills.md) | OpenClaw, Skills, 项目整理 |
| 2025-02 | [X/YouTube视频搬运至B站变现调研](./docs/research/2025-02/x-youtube-to-bilibili.md) | 视频搬运, B站, 变现, YouTube |
| 2025-02 | [自动化内容站+Adsense变现调研](./docs/research/2025-02/content-site-adsense.md) | 内容站, Adsense, 自动化, SEO |

## 🚀 快速开始

### 本地预览

```bash
# 克隆仓库
git clone https://github.com/huqiaoxin82/research-archive.git
cd research-archive

# 启动 Jekyll 本地服务器
cd docs
bundle install
bundle exec jekyll serve
```

### 添加新研究报告

使用提供的 Skill 自动发布：

```bash
# 方式1：使用 OpenClaw Skill
openclaw skill run research-publisher --title "报告标题" --file report.md

# 方式2：手动添加
./scripts/publish.sh "报告标题" "分类标签" ./path/to/report.md
```

## 🔧 技术栈

- **静态站点生成**: Jekyll + GitHub Pages
- **主题**: Cayman (简洁学术风格)
- **部署**: GitHub Actions 自动部署
- **备份**: Cloudflare Pages 镜像

## 📄 许可证

本仓库内容仅供个人学习研究使用。
