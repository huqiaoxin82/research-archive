---
layout: default
title: 使用指南
category: guide
---

# 📖 使用指南

## 如何添加新研究报告

### 方法 1: 使用 Research Publisher Skill (推荐)

```bash
# 准备你的 Markdown 报告
echo "# 我的研究报告

这是报告内容..." > /tmp/my-report.md

# 使用 Skill 发布
~/.openclaw/skills/research-publisher/publish.sh \
  --title "我的新研究" \
  --category "2025-03" \
  --tags "AI,技术,趋势" \
  --file /tmp/my-report.md
```

### 方法 2: 使用仓库脚本

```bash
cd /path/to/research-archive

./scripts/publish.sh "报告标题" "2025-03" ./path/to/report.md
```

### 方法 3: 手动添加

1. 创建 Markdown 文件:
```bash
# 文件名使用小写和连字符
touch docs/research/2025-03/my-new-research.md
```

2. 添加文件头 (Front Matter):
```yaml
---
layout: default
title: "报告标题"
date: 2025-03-15
category: "2025-03"
tags: ["AI", "技术"]
author: "胡巧信"
---
```

3. 提交并推送:
```bash
git add docs/research/2025-03/my-new-research.md
git commit -m "添加研究报告: 报告标题"
git push origin main
```

## 报告模板

```markdown
---
layout: default
title: "报告标题"
date: 2025-03-15
category: "2025-03"
tags: ["标签1", "标签2"]
author: "胡巧信"
---

# 报告标题

> 调研日期: 2025-03-15  
> 分类: 2025-03

---

## 概述

简述研究背景和目的。

## 正文内容

### 1. 章节一

内容...

### 2. 章节二

内容...

## 结论

总结和建议。

---

## 相关资源

- [链接1](https://example.com)
- [链接2](https://example.com)

## 标签

#标签1 #标签2 #研究
```

## 文件命名规范

- 使用小写字母
- 单词之间用连字符 `-` 连接
- 简洁明了

**示例**:
- ✅ `ai-trends-2025.md`
- ✅ `youtube-bilibili-monetization.md`
- ❌ `AI Trends 2025.md` (包含空格和大写)
- ❌ `report_final_v2.md` (包含下划线)

## 目录结构

```
docs/research/
├── 2025-02/           # 按年月分类
│   ├── report-1.md
│   └── report-2.md
├── 2025-03/
│   └── report-3.md
└── 2025-04/
    └── report-4.md
```

## 同步到 Cloudflare

### 自动同步

由于 Cloudflare Pages 已与 GitHub 集成，推送到 GitHub 会自动触发 Cloudflare 部署。

### 手动触发

```bash
# 使用脚本
./scripts/sync-cloudflare.sh deploy

# 或使用 Skill
~/.openclaw/skills/research-publisher/publish.sh \
  --title "报告" --file ./report.md --cloudflare
```

## 本地预览

如果你想在本地预览网站：

```bash
cd docs

# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve

# 访问 http://localhost:4000
```

## 常见问题

### Q: 报告添加后没有显示在网站上？

A: 
1. 检查是否已成功推送到 GitHub
2. 查看 GitHub Actions 是否成功运行
3. 等待几分钟 (GitHub Pages 部署可能需要 1-5 分钟)
4. 清除浏览器缓存后刷新

### Q: 如何修改已发布的报告？

A:
```bash
# 直接编辑文件
vim docs/research/2025-03/my-report.md

# 提交更改
git add .
git commit -m "更新报告"
git push
```

### Q: 如何删除报告？

A:
```bash
# 删除文件
git rm docs/research/2025-03/my-report.md
git commit -m "删除报告"
git push
```

### Q: 可以设置报告为草稿吗？

A: 可以，在 Front Matter 中添加 `published: false`:
```yaml
---
layout: default
title: "草稿报告"
published: false
---
```
