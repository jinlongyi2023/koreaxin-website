# 部署指南 · koreaxin.com

## 准备工作（部署前必做）

### 1. 放入个人照片
将你的形象照命名为 `photo.jpg`，放入网站根目录（与 index.html 同级）。

### 2. 配置 Supabase 下载计数

**Step 1** — 登录 [supabase.com](https://supabase.com)，进入你的项目（或新建一个免费项目）。

**Step 2** — 左侧菜单 → **SQL Editor** → 新建查询，把 `supabase_setup.sql` 的全部内容粘贴进去，点击 **Run**。

**Step 3** — 左侧菜单 → **Settings → API**，复制：
- `Project URL`（形如 `https://xxxxxx.supabase.co`）
- `anon public` key（以 `eyJh` 开头的长字符串）

**Step 4** — 打开 `index.html`，找到以下两行，替换成你的真实值：

```js
const SUPABASE_URL      = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

---

## 上传到 GitHub

```bash
cd 金龙一图书网站
git init
git add .
git commit -m "Initial release"
git branch -M main
git remote add origin https://github.com/你的用户名/koreaxin-website.git
git push -u origin main
```

> 中文文件夹名（图书介绍、资料下载、二维码图片）在 GitHub 完全支持，无需重命名。

---

## 部署到 Netlify

1. 登录 [netlify.com](https://netlify.com)
2. **Add new site → Import an existing project → GitHub**，选择刚才推送的仓库
3. Build settings 全部留空（纯静态，不需要构建命令）
4. 点击 **Deploy site**

部署完成后进入 **Site settings → Domain management**：
- 点击 **Add a domain**，输入 `koreaxin.com`
- 按照提示在你的域名注册商处添加 DNS 记录（CNAME 或 A 记录）
- Netlify 自动配置 HTTPS（免费）

---

## 后续更新购买链接

找到 index.html 中每本书的 `<a href="#" class="book-buy" ...>` 标签，把 `href="#"` 换成真实购买链接，并**删除** `onclick="buyPlaceholder(event)"` 属性即可。

示例：
```html
<!-- 改前 -->
<a href="#" class="book-buy" onclick="buyPlaceholder(event)">立即购买</a>

<!-- 改后 -->
<a href="https://item.taobao.com/item.htm?id=xxxxxx" class="book-buy" target="_blank">立即购买</a>
```

---

## 目录结构说明

```
koreaxin.com/
├── index.html                ← 主页（所有模块）
├── photo.jpg                 ← 【你需要放入】个人形象照
├── DEPLOY.md                 ← 本文件（部署说明）
├── supabase_setup.sql        ← Supabase 初始化 SQL
├── 图书介绍/                 ← 7本书的封面图片
│   ├── TOPIK中高级写作对策(第三版)/
│   ├── TOPIK历年真题词汇全解(中高级)/
│   └── ...
├── 资料下载/                 ← 3个下载文件
│   ├── TOPIK大作文范例100篇-中文翻译.pdf
│   ├── TOPIK必备词汇2017-初高中--正序版词汇表.pdf
│   └── 写作配套资料.zip
└── 二维码图片/               ← 5个平台二维码
    ├── qr-douyin.jpg
    ├── qr-xiaohongshu.jpg
    ├── qr-bilibili.jpg
    ├── qr-shipinhao.jpg
    └── qr-weibo.jpg
```
