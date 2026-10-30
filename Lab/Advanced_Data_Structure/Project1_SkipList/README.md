# Mini Search Engine

基于 C 的 positional inverted index，数据集为 **37 Shakespeare plays / 37 dramatic works**，一部作品对应一个 document。保持哈希表、文档链表、位置链表及 `inverted_index.txt + doc_map.txt` 两文件格式。诗歌未纳入本次实验。

## 文件与目录

```text
project1/
  program/
    project_1.c                 建索引与四种查询
    stemmer.c, stemmer.h         Martin Porter 的 ANSI C stemmer
    stopwords.txt               31 个 stop words
    data/                       37 篇清理后的作品正文
    inverted_index.txt          词干、文档 ID、频次、原始位置
    doc_map.txt                 文档 ID 与文件名
    project_1.exe               本次实际编译的 Windows 程序
  search_word_count/
    word_count.py               HTML/txt 清理与原始词频统计
    word_frequency.txt          原始 token 词频与 df
    summary.txt                 原始统计摘要
    stopword_analysis.txt       stop words 的频次、覆盖率与选择理由
    stopword_candidates.txt     统计规则产生的候选集合
  tests/
    1.txt, 2.txt, 3.txt          可人工验证的小语料
    run_tests.py                C 程序回归测试
    test_preparation.py         数据准备测试
    verify_real.py              37 篇作品的查询、重载与结果记录
    run_all.py                  全部检查及编译日志的统一入口
    results/                    实际运行文本与指标
  report/
    mini_search_engine_report.tex  独立 LaTeX 报告
    mini_search_engine_report.pdf  编译后的报告
    prepare_plot.py, *.tsv       从原始统计生成的绘图数据
  test_results.md
  docs/
    CHANGELOG.md                 功能修改记录
    REPORT_SYNC.md               原报告需要同步的内容
    CLEANUP.md                   目录整理与文件替换记录
  archive/
    project1报告.docx             原报告，内容未修改
    Mini Search Engine 项目问题清单.docx  原问题清单，内容未修改
    data_history/               历史去重记录与原始样本
```

## 编译与运行

目前保留现有 Windows 文件枚举接口，使用 Windows GCC / MinGW。在 `program/` 中执行：

```powershell
gcc project_1.c stemmer.c -o project_1
./project_1.exe
```

1. 首次选择 `1. Build Index`。程序读取 `data/*.txt`，保存 `doc_map.txt` 和 `inverted_index.txt`，然后进入查询菜单，可以立即验证刚构建的内存索引。
2. 输入 `0` 退出；再次运行并选择 `2. Search`。该模式读取索引与文档映射，使用 `stopwords.txt` 做查询标准化，**不会重新枚举或扫描 data**。
3. 四种查询菜单：`1` Word Query；`2` Minimum Match Count Query；`3` Phrase Query；`4` Query Thresholding。每次先输入查询文本，多词查询再输入 k 或百分比。
4. 更新语料、stop words 或标准化规则后，需要重新 Build；索引中的位置必须对应同一版本的原始 txt。

代码严格检查命令：

```powershell
gcc -Wall -Wextra -Werror -c project_1.c -o project_1.o
gcc -Wall -Wextra -Werror -Wno-parentheses project_1.c stemmer.c -o project_1
```

第二条仅关闭第三方原版 `stemmer.c` 中既有的运算符括号风格诊断，保留算法代码原样。要求的普通编译命令无 warning/error。

## 分词、标准化与 stop words

文档和所有查询使用同一个 C tokenizer：连续 ASCII alphanumeric `[A-Za-z0-9]+` 是一个 token，转换为小写；标点、撇号和换行都是分隔符。数字和有意义的单字母词保留，例如 `x`、`o`；不会统一删除单字母词。Python 原始词频统计采用相同规则。

`normalizeWord` 顺序固定为 **小写 → 原词 stop-word 检查 → Porter stemming → 词干 stop-word 检查**。Build、Word Query、Minimum Match Count Query、Query Thresholding 均复用。`being → be`、`having → have`、`yours → your` 等不会把 stop words 重新带入索引。

保留原有 24 个高频语法词。候选规则为 token 占比至少 0.6% 且文档覆盖率至少 90%，然后人工审查；它不是“删除全部高频词”的规则。例如 `thou` 保留以支持古英语文本检索。另加入 `s/d/t/ll/re/ve/m`，处理 `king's / we'd / don't / I'll / we're / I've / I'm` 拆分出的后缀片段。原始统计仍保留这些片段，索引过滤它们；该选择会同时过滤同拼写的独立 token，这是明确的语料处理约定。

清理后统计为 905286 个原始 token、22926 种原始 token；31 个 stop words；14375 个索引词干；610307 个索引位置。原词 stop words 占 293889 次；另有 1090 次在 stemming 后被过滤。详见统计文件与 [测试结果](test_results.md)。

## 查询语义

**Word Query**：例如 `CoNnEcTiNg!`；先分词再标准化，要求恰好一个有效词干，输出文档文件名与词干在文档中的频次。

**Minimum Match Count Query**：保留原来的“至少命中 k 个词”功能。`king, queen powerful`、k=3 要求三个不同词干全部命中。标准化之后去重，`king king queen` 只有两个有效词；k 大于有效词数会明确提示。k≤0、非整数、空查询均不产生错误结果。

**Query Thresholding**：例如 `fairy witch ghost sword night`，百分比输入 `60` 或 `60%`。

1. 分词、标准化、按词干去重，得到 n 个有效 query terms，输出原始有效词及 `原词 → 词干 (df)`。
2. df 表示包含该词干的文档数；按 df 升序排列，df 相同时按词干字典序排序，便于复现实验。
3. 保留前 `ceil(n * percentage / 100)` 个词干，输出实际采用的词；对它们执行 **AND / intersection**，要求所有采用词都命中。
4. 索引中不存在的有效词仍保留，df=0；它不会被悄悄丢弃，采用它时交集为空。百分比范围是 `(0,100]`，支持小数；拒绝 NaN、Infinity、非数字、≤0 和 >100。

该功能与 Minimum Match Count Query 含义不同。固定查询的百分比升高时，采用词的集合逐步扩大，AND 结果只能保持或缩小；不应把返回数减少直接解释成 precision 提升。

**Phrase Query**：先用标准化后的词干和原始位置偏移寻找候选；再按需打开 `data/<filename>`，调用同一个原始 tokenizer，逐词验证完整的小写 phrase，包括 stop words，并输出匹配次数。

- `love king` 要求这两个原始 token 连续。
- `love the king` 必须验证中间 token 为 `the`，`love a king` 不会被误算。
- `to be or not to be` 在真实数据中只命中 `hamlet.txt`，1 次。
- 严格验证也检查内容词的原始拼写：`love` 与 `loves` 在 Word Query 中合并，在 Phrase Query 中仍不同。
- 全由 stop words 组成的 phrase（如 `to be`）通过扫描原文支持，速度较慢；不会把空 phrase 当作匹配所有文档。
- 依照 token 规则忽略标点和换行，允许跨行匹配；人物名和舞台说明也属于 token 序列。源文件缺失会明确报告验证不完整。

## 数据准备与统计复现

在 `search_word_count/` 中执行：

```powershell
python -X utf8 -B word_count.py ../program/data --clean
```

`--clean` 从 MIT 导航末尾截取正文；保留序幕与开场引子，不能直接从 ACT I 截断。去掉 `Shakespeare homepage`、`Entire play` 和网页标题；`Henry IV, part 2` 原网页的开头 `None` 空标题也去掉。脚本可重复执行。省略目录参数时也默认读取 `program/data/`；统计与搜索共用唯一的 `program/stopwords.txt`，统计输出仍写在当前目录。`--sync-to` 仍可用于自行导出数据副本，提交目录不再保留重复语料。

如有本地整部戏剧 HTML，可使用以下命令；`html_source` 是用户自行准备的源页面目录，不是提交中的既有目录：

```powershell
python -X utf8 -B word_count.py html_source --html-to ../program/data
```

HTML 解析只用标准库，过滤 `head/script/style` 与 `play/nav` 页面元素，再提取戏剧正文。输出文件名取 HTML basename；对于 `作品目录/full.html`，取作品目录名。输入目录应只放整部戏剧页面，避免把场次页面作为额外文档。

**Stage directions and character labels are treated as part of the document.** 人物名、Enter、Exeunt 和舞台说明影响词频，保留这一约定；不是仅对白统计，也不是完整 Complete Works。

## 自动测试与报告

在本目录 `project1/` 执行，测试使用临时工作目录，不覆盖正式语料：

```powershell
python -X utf8 -B tests/run_all.py
```

也可以分别执行：

```powershell
python -X utf8 -B tests/run_tests.py
python -X utf8 -B tests/test_preparation.py
python -X utf8 -B tests/verify_real.py
```

前两条分别验证 24 项 C 回归测试和 3 项数据准备测试。第三条实际重建正式索引，比较 19 个真实查询在 Build 与重启 Search 下的输出，使用独立原始 token 扫描验证短语，并更新 `test_results.md` 和 `tests/results/`。测试数据确实位于 `tests/1.txt`、`2.txt`、`3.txt`，不存在 `tests/data`，也不以截图作为运行证据。

单独报告源码见项目仓库中的 `report/mini_search_engine_report.tex`（未同步到本站），用 XeLaTeX 连续编译两次：

```powershell
cd report
python -X utf8 -B prepare_plot.py
xelatex -interaction=nonstopmode -halt-on-error mini_search_engine_report.tex
xelatex -interaction=nonstopmode -halt-on-error mini_search_engine_report.tex
```

原有报告已归档到项目仓库中的 `archive/project1报告.docx`（未同步到本站），内容未修改；需同步的章节、数字与描述列在项目仓库的 `docs/REPORT_SYNC.md`。原问题清单和历史去重材料也放在 `archive/`，不参加统计或建索引。目录整理记录见 `docs/CLEANUP.md`。

## 索引格式与边界

`inverted_index.txt` 每行格式不变：`stem doc_id:count[pos1,pos2,...] ...`。位置从 0 开始，stop words 仍占据位置。`doc_map.txt` 每行 `ID filename`；Search 恢复所有频次、位置及文档名，保存→加载→再保存的两份文件逐字节相同。

保留现有容量：最多 999 篇文档、100000 个词干、每个 token 最多 49 个 ASCII 字符、每个查询最多 50 个不同有效词干（phrase 最多 50 个原始 token）。超限会报错；加载已移除 65536 字节单行和 10000 位置截断限制。新增 `DocNode.tail` 使追加位置为 O(1)，建索引利用文档顺序避免遍历旧 posting 链。

## 来源

- 作品正文：[MIT Shakespeare](https://shakespeare.mit.edu/)。本次为 37 部戏剧。
- Martin F. Porter, **An Algorithm for Suffix Stripping**, *Program*, 14(3), 130–137, 1980。
- Porter 官方实现页面：[The Porter Stemming Algorithm](https://tartarus.org/martin/PorterStemmer/)。`stemmer.c` 使用 Martin Porter 的 ANSI C 实现，本次文件内容与算法均未修改。
