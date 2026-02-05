---
# the default layout is 'page'
icon: fas fa-info-circle
order: 4
---

## 关于本站

欢迎来到**胡巧信的技术研究**博客！

这是一个记录技术研究、项目调研与实践经验的知识库。本站基于 [Jekyll](https://jekyllrb.com/) 和 [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 主题构建，托管于 [GitHub Pages](https://pages.github.com/)。

### 内容方向

- **技术研究**: 自动化工具、AI应用、开发效率
- **项目调研**: 内容变现、网站运营、商业模式
- **实践经验**: 项目复盘、踩坑记录、最佳实践

### 最新文章

{% assign posts = site.posts | limit: 5 %}
{% for post in posts %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {{ post.date | date: "%Y-%m-%d" }}
{% endfor %}

### 联系方式

- GitHub: [@huqiaoxin82](https://github.com/huqiaoxin82)

---

*本站内容仅供学习交流，转载请注明出处。*
