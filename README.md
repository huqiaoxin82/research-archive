# 胡巧信的技术研究博客

> 基于 Jekyll Chirpy 主题的科技风格博客
> 记录技术研究、项目调研与实践经验

## 🌐 访问地址

**https://huqiaoxin82.github.io/research-archive**

---

## 📚 博客内容

### 文章分类

- **技术研究** - 自动化工具、AI应用、开发效率
- **项目调研** - 内容变现、网站运营、商业模式
- **实践经验** - 项目复盘、踩坑记录、最佳实践

### 已发布文章

| 日期 | 标题 | 分类 |
|------|------|------|
| 2025-02-05 | [OpenClaw Skills 项目整理](./_posts/2025-02-05-openclaw-skills-project.md) | 技术研究 |
| 2025-02-03 | [X/YouTube视频搬运至B站变现调研](./_posts/2025-02-03-youtube-bilibili-content-migration.md) | 项目调研 |
| 2025-02-04 | [自动化内容站+Adsense变现调研](./_posts/2025-02-04-automated-content-site-adsense.md) | 项目调研 |

---

## 🛠 技术栈

- **静态站点生成器**: [Jekyll](https://jekyllrb.com/)
- **主题**: [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) - 科技风格主题
- **部署**: [GitHub Pages](https://pages.github.com/) + GitHub Actions
- **语言**: 中文 (zh-CN)
- **主题模式**: 暗色模式

---

## 🚀 快速开始

### 本地开发

```bash
# 克隆仓库
git clone https://github.com/huqiaoxin82/research-archive.git
cd research-archive

# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve --livereload
```

访问 http://localhost:4000/research-archive/

---

## 📝 发布新文章

### 方法1: 手动创建

1. 在 `_posts/` 目录创建新文件，文件名格式：`YYYY-MM-DD-title.md`

2. 文件格式：

```markdown
---
title: "文章标题"
date: 2025-02-06 10:00:00 +0800
categories: [分类1, 分类2]
tags: [标签1, 标签2, 标签3]
---

## 正文内容

使用 Markdown 格式编写文章...
```

3. 提交并推送：

```bash
git add _posts/2025-02-06-title.md
git commit -m "Add new article: 文章标题"
git push origin main
```

### 方法2: 使用脚本 (推荐)

```bash
# 创建新文章
cat > _posts/$(date +%Y-%m-%d)-new-article.md << 'EOF'
---
title: "新文章标题"
date: $(date '+%Y-%m-%d %H:%M:%S %z')
categories: [未分类]
tags: []
---

## 概述

文章内容...
EOF

# 推送
git add . && git commit -m "Add new article" && git push
```

---

## 📁 项目结构

```
research-archive/
├── _config.yml              # 站点主配置
├── _posts/                  # 博客文章目录
│   ├── 2025-02-03-youtube-bilibili-content-migration.md
│   ├── 2025-02-04-automated-content-site-adsense.md
│   └── 2025-02-05-openclaw-skills-project.md
├── _tabs/                   # 导航页面
│   ├── about.md             # 关于页面
│   ├── archives.md          # 归档页面
│   ├── categories.md        # 分类页面
│   └── tags.md              # 标签页面
├── _layouts/                # 页面模板
├── _includes/               # 模板组件
├── _sass/                   # 样式文件
├── assets/                  # 静态资源
│   └── img/                 # 图片资源
└── .github/workflows/       # CI/CD配置
    └── pages-deploy.yml     # 自动部署工作流
```

---

## ⚙️ 配置说明

### 站点配置 (`_config.yml`)

```yaml
title: 胡巧信的技术研究           # 网站标题
tagline: 技术调研 · 项目实践 · 行业观察  # 副标题
description: 博客描述
url: https://huqiaoxin82.github.io
baseurl: /research-archive        # 子路径
lang: zh-CN                       # 中文
theme_mode: dark                  # 暗色主题
```

### Front Matter 说明

每篇文章开头需要包含：

```yaml
---
title: 文章标题                    # 必填
date: 2025-02-06 10:00:00 +0800   # 必填
categories: [分类1, 分类2]         # 可选
tags: [标签1, 标签2]               # 可选
toc: true                         # 可选：显示目录
---
```

---

## 🎨 主题定制

### 修改主题颜色

编辑 `_sass/themes/_dark.scss` (暗色) 或 `_sass/themes/_light.scss` (亮色)

### 添加头像

上传头像图片到 `assets/img/avatar.png`，并在 `_config.yml` 中配置：

```yaml
avatar: "/assets/img/avatar.png"
```

### 添加社交链接

在 `_config.yml` 中配置：

```yaml
social:
  name: 胡巧信
  email: your@email.com
  links:
    - https://github.com/huqiaoxin82
    - https://twitter.com/yourusername
```

---

## 📄 许可证

- **主题**: [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) (MIT License)
- **内容**: 仅供学习研究使用

---

## 📧 联系方式

- GitHub: [@huqiaoxin82](https://github.com/huqiaoxin82)

---

*最后更新: 2025-02-05*
