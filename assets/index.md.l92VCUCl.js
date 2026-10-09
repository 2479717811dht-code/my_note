import{v as b,x as p,o as v,c as h,a4 as e,j as n,k as t,g as o,a as g}from"./chunks/framework.BaMAT_0D.js";const _={class:"garden-banner-card"},u=["src"],m={class:"bento-cluster"},f={class:"garden-bento-grid"},y=["href"],T={class:"bento-cluster"},S={class:"garden-bento-grid"},x=["href"],A={class:"bento-cluster"},P={class:"garden-bento-grid"},C=["href"],w={class:"garden-meme-gallery"},M={class:"garden-meme-item"},k=["src"],D={class:"garden-meme-item"},I=["src"],N=JSON.parse('{"title":"","description":"","frontmatter":{"layout":"home","hero":{"name":"My Note","text":"AR15LAL","tagline":"一个没有对象的野指针 · 浙江大学计算机系数字花园","image":{"src":"/cute.gif","alt":"Digital Garden Mascot"},"actions":[{"theme":"brand","text":"开始漫游 🧭","link":"/Cover/logic"},{"theme":"alt","text":"GitHub 仓库 ✦","link":"https://github.com/2479717811dht-code/my_note"}]},"features":[{"icon":"🧭","title":"Course Map · 知识图谱","details":"课程脉络与全局导航，系统化梳理大学计算机专业知识图谱与选课逻辑","link":"/Cover/logic","linkText":"探索知识图谱 →"},{"icon":"💻","title":"Theory Notes · 专业理论","details":"理论课深度笔记，涵盖数据结构、计算机组成、离散数学与经典算法","link":"/Theory/theory","linkText":"阅读理论课 →"},{"icon":"🧪","title":"Engineering Lab · 实验实战","details":"实验实战与设计报告，从 Verilog 硬件逻辑到软硬件协同代码归档","link":"/Lab/lab","linkText":"进入实验集 →"},{"icon":"☕","title":"Take a Break · 摸鱼小憩","details":"在学术与代码间隙停下脚步，赛博木鱼、贪吃蛇、2048与心境随笔","link":"/Break/break","linkText":"呼吸片刻 →"}]},"headers":[],"relativePath":"index.md","filePath":"index.md","lastUpdated":1791514926000}'),V={name:"index.md"},q=Object.assign(V,{setup(L){let d=null;return b(()=>{if(typeof window>"u")return;const i=["✦","✨","♥","❀","✿"],s=["#b85b44","#cf6e57","#d9822b","#e29578","#c68a4c"];function c(){if(document.querySelectorAll(".garden-falling-petal").length>18)return;const a=document.createElement("div");a.className="garden-falling-petal",a.innerText=i[Math.floor(Math.random()*i.length)],a.style.position="fixed",a.style.left=Math.random()*96+2+"vw",a.style.top="-6vh",a.style.fontSize=Math.random()*14+10+"px",a.style.zIndex="9999",a.style.pointerEvents="none",a.style.color=s[Math.floor(Math.random()*s.length)],a.style.opacity="0",a.style.textShadow="0 0 10px rgba(184, 91, 68, 0.3)",document.body.appendChild(a);const l=(Math.random()*4+6)*1e3,r=a.animate([{transform:"translateY(0) scale(0.6) rotate(0deg)",opacity:0,offset:0},{opacity:.75,offset:.15},{opacity:.6,offset:.8},{transform:"translateY(110vh) scale(1.1) rotate("+Math.random()*360+"deg)",opacity:0,offset:1}],{duration:l,easing:"cubic-bezier(0.25, 0.46, 0.45, 0.94)",fill:"forwards"});r.onfinish=()=>{document.body.contains(a)&&a.remove()}}d=setInterval(c,850)}),p(()=>{d&&clearInterval(d),typeof document<"u"&&document.querySelectorAll(".garden-falling-petal").forEach(i=>i.remove())}),(i,s)=>(v(),h("div",null,[s[9]||(s[9]=e('<div style="text-align:center;margin-top:1.8rem;"><div class="garden-badge">✨ 欢迎步入我的数字花园 · Digital Garden</div></div><div class="garden-quote-box"><div class="garden-quote-title">Moonlight &amp; Starlight</div><div class="garden-quote-content"> “I got you, moonlight, you&#39;re my starlight. 在月光下与你紧紧相拥，你就是我的熠熠星辉。” </div></div>',2)),n("div",_,[n("img",{src:t(o)("/indexPerson.png"),alt:"Always With You",class:"garden-banner-img"},null,8,u)]),s[10]||(s[10]=n("h2",{id:"全景知识矩阵-·-course-notes-hub",tabindex:"-1"},[g("全景知识矩阵 · Course & Notes Hub "),n("a",{class:"header-anchor",href:"#全景知识矩阵-·-course-notes-hub","aria-label":'Permalink to "全景知识矩阵 · Course & Notes Hub"'},"​")],-1)),s[11]||(s[11]=n("p",null,"涵盖理论专业课、数理基础、工程实验与后花园，全景速达：",-1)),n("div",m,[s[2]||(s[2]=n("div",{class:"bento-section-header"},[n("div",{class:"bento-section-title"},"💻 计算理论与系统架构 · Core Systems"),n("div",{class:"bento-section-subtitle"},"计算机系必修硬核专业课")],-1)),n("div",f,[n("a",{href:t(o)("/Theory/Fundamentals_of_Data_Structure"),class:"bento-card"},[...s[0]||(s[0]=[e('<div><div class="bento-card-top"><span class="bento-code-badge">FDS</span><span class="bento-tag-badge core">专业核心</span></div><div class="bento-card-body"><div class="bento-icon-box">🌲</div><div class="bento-content"><span class="bento-title">数据结构基础</span><span class="bento-desc">树与森林 · 堆与优先队列 · 散列表 · 图论最短路径与并查集</span></div></div></div><div class="bento-card-footer"><div class="bento-chips"><span class="bento-chip">84K字精研</span><span class="bento-chip">图算法</span></div><span class="bento-arrow">→</span></div>',2)])],8,y),s[1]||(s[1]=n("pre",null,[n("code",null,`<a :href="withBase('/Theory/Advanced_Data_Structure_Algorithm_Analysis')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">ADS</span>
      <span class="bento-tag-badge core">进阶算法</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">🚀</div>
      <div class="bento-content">
        <span class="bento-title">高级数据结构与算法</span>
        <span class="bento-desc">AVL 树 · 伸展树 · B+ 树 · 左倾堆 · 摊还分析与近似算法</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">cyll版讲义</span>
      <span class="bento-chip">摊还分析</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>

<a :href="withBase('/Theory/Computer_Organization')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">CO</span>
      <span class="bento-tag-badge core">硬件系统</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">🖥️</div>
      <div class="bento-content">
        <span class="bento-title">计算机组成与体系</span>
        <span class="bento-desc">MIPS 架构 · 指令集 · 单周期/流水线数据通路 · Cache 存储层次</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">流水线冒险</span>
      <span class="bento-chip">Cache 映射</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>

<a :href="withBase('/Theory/dldnote')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">DLD</span>
      <span class="bento-tag-badge core">硬件基石</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">⚡</div>
      <div class="bento-content">
        <span class="bento-title">数字逻辑设计</span>
        <span class="bento-desc">布尔代数 · 卡诺图化简 · 组合时序逻辑 · 状态机 · Verilog 设计</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">卡诺图</span>
      <span class="bento-chip">FSM 状态机</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>

<a :href="withBase('/Theory/note-cs-code-cleaned')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">FPA</span>
      <span class="bento-tag-badge core">编程基石</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">💻</div>
      <div class="bento-content">
        <span class="bento-title">程序设计与算法基础</span>
        <span class="bento-desc">C/C++ 核心语法 · 指针内存模型 · 面向对象 · 基础算法与题型解析</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">指针机制</span>
      <span class="bento-chip">STL与算法</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>
`)],-1))])]),n("div",T,[s[5]||(s[5]=n("div",{class:"bento-section-header"},[n("div",{class:"bento-section-title"},"📐 数理基石与通识素养 · Math & GenEd"),n("div",{class:"bento-section-subtitle"},"推导思维与考研核心")],-1)),n("div",S,[n("a",{href:t(o)("/Theory/Discrete_Mathematics"),class:"bento-card"},[...s[3]||(s[3]=[e('<div><div class="bento-card-top"><span class="bento-code-badge">DM</span><span class="bento-tag-badge math">数理基石</span></div><div class="bento-card-body"><div class="bento-icon-box">📐</div><div class="bento-content"><span class="bento-title">离散数学</span><span class="bento-desc">命题谓词逻辑 · 集合与等价偏序关系 · 图论与树 · 组合计数与母函数</span></div></div></div><div class="bento-card-footer"><div class="bento-chips"><span class="bento-chip">偏序关系</span><span class="bento-chip">图论推导</span></div><span class="bento-arrow">→</span></div>',2)])],8,x),s[4]||(s[4]=n("pre",null,[n("code",null,`<a :href="withBase('/Theory/Probability_and_Mathematical_Statistics')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">PMS</span>
      <span class="bento-tag-badge math">数理基石</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">🎲</div>
      <div class="bento-content">
        <span class="bento-title">概率论与数理统计</span>
        <span class="bento-desc">随机变量及分布 · 期望与方差 · 大数定律与极限定理 · 参数估计与假设检验</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">分布律模型</span>
      <span class="bento-chip">估计检验</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>

<a :href="withBase('/Theory/Marxism')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">MARX</span>
      <span class="bento-tag-badge math">闭卷重点</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">🚩</div>
      <div class="bento-content">
        <span class="bento-title">马克思主义基本原理</span>
        <span class="bento-desc">唯物论辩证法 · 认识论与实践 · 资本论与唯物史观 · 期末及考研要点</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">考点梳理</span>
      <span class="bento-chip">背诵导图</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>
`)],-1))])]),n("div",A,[s[8]||(s[8]=n("div",{class:"bento-section-header"},[n("div",{class:"bento-section-title"},"🔬 硬件实战与工程落地 · Engineering Labs"),n("div",{class:"bento-section-subtitle"},"从 Verilog 电路到 CPU 设计")],-1)),n("div",P,[n("a",{href:t(o)("/Lab/Digital-Logic-Design-Lab"),class:"bento-card"},[...s[6]||(s[6]=[e('<div><div class="bento-card-top"><span class="bento-code-badge">DLD LAB</span><span class="bento-tag-badge lab">硬件实战</span></div><div class="bento-card-body"><div class="bento-icon-box">🧪</div><div class="bento-content"><span class="bento-title">数字逻辑设计实验</span><span class="bento-desc">Vivado 仿真与综合 · FPGA 板卡开发 · 组合时序实验报告与大作业</span></div></div></div><div class="bento-card-footer"><div class="bento-chips"><span class="bento-chip">Verilog HDL</span><span class="bento-chip">大作业代码</span></div><span class="bento-arrow">→</span></div>',2)])],8,C),s[7]||(s[7]=n("pre",null,[n("code",null,`<a :href="withBase('/Lab/Computer-Organization-Lab')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">CO LAB</span>
      <span class="bento-tag-badge lab">CPU架构</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">⚙️</div>
      <div class="bento-content">
        <span class="bento-title">计算机组成体系实验</span>
        <span class="bento-desc">MIPS 单周期 CPU 设计 · 汇编指令调试 · 中断异常与软硬件协同验证</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">MIPS 汇编</span>
      <span class="bento-chip">数据通路测试</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>

<a :href="withBase('/Cover/logic')" class="bento-card">
  <div>
    <div class="bento-card-top">
      <span class="bento-code-badge">MAP</span>
      <span class="bento-tag-badge life">全局导引</span>
    </div>
    <div class="bento-card-body">
      <div class="bento-icon-box">🧭</div>
      <div class="bento-content">
        <span class="bento-title">课程体系知识图谱</span>
        <span class="bento-desc">浙江大学计科培养方案全局脉络 · 选课指引 · 学习心法与 SGA 寄语</span>
      </div>
    </div>
  </div>
  <div class="bento-card-footer">
    <div class="bento-chips">
      <span class="bento-chip">培养路线</span>
      <span class="bento-chip">全局框架</span>
    </div>
    <span class="bento-arrow">→</span>
  </div>
</a>
`)],-1))])]),s[12]||(s[12]=e('<h2 id="阅览与排版特性-·-features" tabindex="-1">阅览与排版特性 · Features <a class="header-anchor" href="#阅览与排版特性-·-features" aria-label="Permalink to &quot;阅览与排版特性 · Features&quot;">​</a></h2><p>全站面向学术笔记阅读体验深度打磨，具备以下特性：</p><ul><li>📐 <strong>LaTeX 公式支持</strong>：复杂数学公式与算法渐近复杂度符号全量排版渲染。</li><li>📊 <strong>Mermaid 结构图</strong>：流程图、时序图与有限状态机直观呈现。</li><li>🎵 <strong>背景音乐伴读</strong>：右上角支持治愈系背景音乐开关（带轻柔光环律动）。</li><li>📑 <strong>自动层级目录</strong>：笔记内保留 <code>[toc]</code>，渲染引擎将自动生成树状速览导航。</li></ul><h2 id="学习心法-·-philosophy" tabindex="-1">学习心法 · Philosophy <a class="header-anchor" href="#学习心法-·-philosophy" aria-label="Permalink to &quot;学习心法 · Philosophy&quot;">​</a></h2><blockquote><p><strong>格物致知 · 体系化推导</strong></p><p>学习不是把零碎的概念机械背诵，而是逐渐建立起能够自己推导、解释与解决真实工程问题的思维框架。纸上得来终觉浅，绝知此事要躬行。</p></blockquote><h2 id="轻松一刻-·-memes" tabindex="-1">轻松一刻 · Memes <a class="header-anchor" href="#轻松一刻-·-memes" aria-label="Permalink to &quot;轻松一刻 · Memes&quot;">​</a></h2><p>也许这些内容不太适合补天喵，但适合给紧绷的心情放个假 ~</p>',7)),n("div",w,[n("div",M,[n("img",{src:t(o)("/pig_to_right.gif"),alt:"奔跑吧1"},null,8,k)]),n("div",D,[n("img",{src:t(o)("/pig_to_left.gif"),alt:"奔跑吧2"},null,8,I)])]),s[13]||(s[13]=e('<div class="lebron-motto"><div class="motto-crown-icon">👑</div><div class="motto-tagline">STRIVE FOR GREATNESS · 追求伟大</div><div class="motto-quote-en">“In Northeast Ohio, nothing is given. Everything is earned. You work for what you have.”</div><div class="motto-quote-cn">“在俄亥俄州东北部，没有什么是理所当然给予你的，一切都必须靠自己去赢取。唯有拼尽全力，方能追求伟大。”</div><div class="motto-author">—— LeBron Raymone James Sr. 👑</div></div>',1))]))}});export{N as __pageData,q as default};
