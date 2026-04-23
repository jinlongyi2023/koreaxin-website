-- ════════════════════════════════════════════════
--  金龙一图书网站 · Supabase 初始化 SQL
--  在 Supabase 控制台 → SQL Editor 中运行此文件
-- ════════════════════════════════════════════════

-- 1. 创建下载计数表
CREATE TABLE IF NOT EXISTS downloads (
    filename         TEXT PRIMARY KEY,
    count            INTEGER NOT NULL DEFAULT 0,
    last_downloaded  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 插入三个初始记录
INSERT INTO downloads (filename, count) VALUES
    ('TOPIK大作文范例100篇-中文翻译.pdf',          0),
    ('TOPIK必备词汇2017-初高中--正序版词汇表.pdf',  0),
    ('写作配套资料.zip',                            0)
ON CONFLICT (filename) DO NOTHING;

-- 3. 开启行级安全（RLS）
ALTER TABLE downloads ENABLE ROW LEVEL SECURITY;

-- 4. 允许公开读取（任何人可以看到下载次数）
CREATE POLICY "public_read" ON downloads
    FOR SELECT USING (true);

-- 5. 禁止直接 UPDATE（只允许通过函数更新，防止篡改）
-- （不创建 UPDATE policy，所有更新走下面的 RPC 函数）

-- 6. 创建原子自增函数（防止并发竞争）
CREATE OR REPLACE FUNCTION increment_download(fname TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER   -- 以函数 owner 权限执行，绕过 RLS
AS $$
BEGIN
    INSERT INTO downloads (filename, count, last_downloaded)
    VALUES (fname, 1, NOW())
    ON CONFLICT (filename)
    DO UPDATE SET
        count           = downloads.count + 1,
        last_downloaded = NOW();
END;
$$;

-- ════════════════════════════════════════════════
--  验证：运行后查看数据
-- ════════════════════════════════════════════════
-- SELECT * FROM downloads;
