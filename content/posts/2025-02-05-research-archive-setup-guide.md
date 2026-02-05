---
title: "研究资料归档系统搭建记录"
date: 2025-02-05T15:45:00+08:00
draft: false
tags: ["hugo", "papermod", "github-pages", "cloudflare", "部署", "静态网站"]
categories: ["技术实践", "建站记录"]
---

## 背景

为了更好地整理和归档研究调研内容，决定将散落在飞书文档中的报告统一迁移到一个可公开访问、易于维护的静态网站。目标是：

- **双平台部署**：GitHub Pages（主站）+ Cloudflare Pages（备份）
- **科技风格**：简洁、快速、支持暗色模式
- **零成本**：利用免费托管服务
- **易于维护**：Markdown 写作，Git 版本控制

## 技术选型

对比了多个静态网站生成器：

| 方案 | 优点 | 缺点 |
|------|------|------|
| Jekyll (Chirpy) | GitHub Pages 原生支持 | 构建较慢，Ruby 依赖 |
| **Hugo (PaperMod)** | **极速构建，单二进制文件** | 学习成本略高 |
| Astro | 现代化，性能好 | 相对较新，生态较小 |

最终选择 **Hugo + PaperMod**，原因：
- 构建速度极快（毫秒级）
- PaperMod 主题简洁美观，科技风格
- 支持搜索、标签、归档等完整功能
- 单二进制文件，部署简单

## 部署架构

```
GitHub Repository
       │
       ├─── GitHub Actions ─── Hugo Build ─── GitHub Pages
       │                              (baseURL: github.io)
       │
       └─── Cloudflare Pages ─── Hugo Build ─── CF CDN
                                     (baseURL: pages.dev)
```

## 关键配置

### 1. Hugo 配置 (hugo.toml)

```toml
baseURL = 'https://research-archive.pages.dev/'
languageCode = 'zh-CN'
title = '胡巧信的技术研究'
theme = 'PaperMod'

[params]
  defaultTheme = 'dark'
  ShowReadingTime = true
  ShowPostNavLinks = true
  ShowBreadCrumbs = true
  # ... 其他参数
```

**注意**：`baseURL` 设置为 Cloudflare 地址作为默认值。

### 2. GitHub Actions 配置

为支持双平台部署，GitHub Actions 明确覆盖 baseURL：

```yaml
- name: Build for GitHub Pages
  run: |
    hugo \
      --gc \
      --minify \
      --baseURL "https://huqiaoxin82.github.io/research-archive/"
```

### 3. Cloudflare Pages 配置

在 Cloudflare Dashboard → Pages → 项目设置中：

- **Framework preset**: Hugo
- **Build command**: `hugo --gc --minify --baseURL https://research-archive.pages.dev/`
- **Output directory**: `public`

## 遇到的问题与解决

### 问题 1：CSS 路径 404

**现象**：Cloudflare 上样式丢失，控制台报错：
```
Refused to apply style from '.../research-archive/assets/css/...'
because its MIME type ('text/html') is not a supported stylesheet MIME type
```

**原因**：`baseURL` 配置为 `/` 或 GitHub Pages 路径，导致 Cloudflare 部署时资源路径错误。

**解决**：
- `hugo.toml` 中设置 Cloudflare 地址作为默认 baseURL
- GitHub Actions 构建时通过 `--baseURL` 参数覆盖为 GitHub Pages 地址
- 两个平台各自使用正确的完整 URL

### 问题 2：GitHub Pages 构建失败

**现象**：GitHub Actions 提示 `could not read Username`

**原因**：远程仓库使用 HTTPS 协议，需要认证。

**解决**：切换到 SSH 协议或使用 Token 认证：
```bash
git remote set-url origin git@github.com:huqiaoxin82/research-archive.git
```

## 发布新文章流程

### 方法 1：使用 Hugo CLI

```bash
# 创建新文章
hugo new content/posts/2025-02-06-article-title.md

# 编辑内容
vim content/posts/2025-02-06-article-title.md

# 提交推送
git add .
git commit -m "Add new post"
git push origin main
```

### 方法 2：手动创建

在 `content/posts/` 目录下创建文件，格式：`YYYY-MM-DD-title.md`

Front matter 示例：
```yaml
---
title: "文章标题"
date: 2025-02-06T10:00:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类1"]
---

正文内容...
```

推送后 GitHub Actions 自动构建部署，约 1-2 分钟后生效。

## 访问地址

| 平台 | 地址 |
|------|------|
| GitHub Pages | https://huqiaoxin82.github.io/research-archive/ |
| Cloudflare Pages | https://research-archive.pages.dev/ |

## 后续优化方向

1. **自定义域名**：绑定个人域名，品牌更统一
2. **CDN 加速**：Cloudflare 自动提供全球 CDN
3. **评论系统**：集成 Giscus（GitHub Discussions）
4. **SEO 优化**：添加 sitemap，提交搜索引擎
5. **内容自动化**：开发 Skill 实现一键发布调研报告

## 总结

通过 Hugo + PaperMod + GitHub/Cloudflare 的组合，实现了：
- ✅ 零成本托管
- ✅ 极速访问体验
- ✅ 双平台备份
- ✅ Markdown 写作工作流

这套方案适合个人博客、文档站点、研究资料归档等场景。
