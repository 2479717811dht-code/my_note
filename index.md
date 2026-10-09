---
layout: home

hero:
  name: "My Note"
  text: "AR15LAL"
  tagline: "一个没有对象的野指针 · 浙江大学计算机系数字花园"
  image:
    src: /cute.gif
    alt: "Digital Garden Mascot"
  actions:
    - theme: brand
      text: "开始漫游 🧭"
      link: /Cover/logic
    - theme: alt
      text: "GitHub 仓库 ✦"
      link: https://github.com/2479717811dht-code/my_note

features:
  - icon: "🧭"
    title: "Course Map · 知识图谱"
    details: "课程脉络与全局导航，系统化梳理大学计算机专业知识图谱与选课逻辑"
    link: /Cover/logic
    linkText: "探索知识图谱 →"

  - icon: "💻"
    title: "Theory Notes · 专业理论"
    details: "理论课深度笔记，涵盖数据结构、计算机组成、离散数学与经典算法"
    link: /Theory/theory
    linkText: "阅读理论课 →"

  - icon: "🧪"
    title: "Engineering Lab · 实验实战"
    details: "实验实战与设计报告，从 Verilog 硬件逻辑到软硬件协同代码归档"
    link: /Lab/lab
    linkText: "进入实验集 →"

  - icon: "☕"
    title: "Take a Break · 摸鱼小憩"
    details: "在学术与代码间隙停下脚步，赛博木鱼、贪吃蛇、2048与心境随笔"
    link: /Break/break
    linkText: "呼吸片刻 →"
---

<div style="text-align: center; margin-top: 1.8rem;">
  <div class="garden-badge">✨ 欢迎步入我的数字花园 · Digital Garden</div>
</div>

<div class="garden-quote-box">
  <div class="garden-quote-title">Moonlight & Starlight</div>
  <div class="garden-quote-content">
    “I got you, moonlight, you're my starlight. 在月光下与你紧紧相拥，你就是我的熠熠星辉。”
  </div>
</div>

<div class="garden-banner-card">
  <img :src="withBase('/indexPerson.png')" alt="Always With You" class="garden-banner-img" />
</div>

## 核心笔记直达 · Core Notes

精选热门理论笔记与实验实战直通车，一键开启阅读：

<div class="garden-quick-nav">
  <a :href="withBase('/Theory/Fundamentals_of_Data_Structure')" class="garden-nav-pill">
    <div class="pill-left">
      <span class="icon">🌲</span>
      <div>
        <span class="pill-title">数据结构基础</span>
        <span class="pill-desc">算法分析 · 树与图 · 堆与并查集</span>
      </div>
    </div>
    <span class="arrow">→</span>
  </a>

  <a :href="withBase('/Theory/Computer_Organization')" class="garden-nav-pill">
    <div class="pill-left">
      <span class="icon">🖥️</span>
      <div>
        <span class="pill-title">计算机组成与体系</span>
        <span class="pill-desc">MIPS 架构 · 数据通路 · 流水线</span>
      </div>
    </div>
    <span class="arrow">→</span>
  </a>

  <a :href="withBase('/Theory/dldnote')" class="garden-nav-pill">
    <div class="pill-left">
      <span class="icon">⚡</span>
      <div>
        <span class="pill-title">数字逻辑设计</span>
        <span class="pill-desc">组合逻辑 · 时序电路 · 状态机设计</span>
      </div>
    </div>
    <span class="arrow">→</span>
  </a>

  <a :href="withBase('/Break/break')" class="garden-nav-pill">
    <div class="pill-left">
      <span class="icon">🎮</span>
      <div>
        <span class="pill-title">摸鱼放松小站</span>
        <span class="pill-desc">赛博木鱼 · 极客贪吃蛇 · 2048小游戏</span>
      </div>
    </div>
    <span class="arrow">→</span>
  </a>
</div>

## 阅览与排版特性 · Features

全站面向学术笔记阅读体验深度打磨，具备以下特性：

- 📐 **LaTeX 公式支持**：复杂数学公式与算法渐近复杂度符号全量排版渲染。
- 📊 **Mermaid 结构图**：流程图、时序图与有限状态机直观呈现。
- 🎵 **背景音乐伴读**：右上角支持治愈系背景音乐开关（带轻柔光环律动）。
- 📑 **自动层级目录**：笔记内保留 `[toc]`，渲染引擎将自动生成树状速览导航。

## 学习心法 · Philosophy

> **格物致知 · 体系化推导**
> 
> 学习不是把零碎的概念机械背诵，而是逐渐建立起能够自己推导、解释与解决真实工程问题的思维框架。纸上得来终觉浅，绝知此事要躬行。

## 轻松一刻 · Memes

也许这些内容不太适合补天喵，但适合给紧绷的心情放个假 ~

<div class="garden-meme-gallery">
  <div class="garden-meme-item">
    <img :src="withBase('/pig_to_right.gif')" alt="奔跑吧1" />
  </div>
  <div class="garden-meme-item">
    <img :src="withBase('/pig_to_left.gif')" alt="奔跑吧2" />
  </div>
</div>

<div class="my-motto">
  “知止而后有定，定而后能静，静而后能安，安而后能虑，虑而后能得。”
  <div class="my-sign">—— H.T. Deng</div>
</div>

<script setup>
import { onMounted, onUnmounted } from 'vue'
import { withBase } from 'vitepress'

let intervalId = null;

onMounted(() => {
  if (typeof window === 'undefined') return;

  const symbols = ['✦', '✨', '♥', '❀', '✿'];
  const colors = ['#b85b44', '#cf6e57', '#d9822b', '#e29578', '#c68a4c'];

  function createPetal() {
    const existing = document.querySelectorAll('.garden-falling-petal');
    if (existing.length > 18) return;

    const petal = document.createElement('div');
    petal.className = 'garden-falling-petal';
    petal.innerText = symbols[Math.floor(Math.random() * symbols.length)];
    
    petal.style.position = 'fixed';
    petal.style.left = (Math.random() * 96 + 2) + 'vw';
    petal.style.top = '-6vh';
    petal.style.fontSize = (Math.random() * 14 + 10) + 'px';
    petal.style.zIndex = '9999';
    petal.style.pointerEvents = 'none';
    petal.style.color = colors[Math.floor(Math.random() * colors.length)];
    petal.style.opacity = '0';
    petal.style.textShadow = '0 0 10px rgba(184, 91, 68, 0.3)';
    
    document.body.appendChild(petal);
    
    const duration = (Math.random() * 4 + 6) * 1000;
    
    const animation = petal.animate([
      { transform: 'translateY(0) scale(0.6) rotate(0deg)', opacity: 0, offset: 0 },
      { opacity: 0.75, offset: 0.15 },
      { opacity: 0.6, offset: 0.8 },
      { transform: 'translateY(110vh) scale(1.1) rotate(' + (Math.random() * 360) + 'deg)', opacity: 0, offset: 1 }
    ], {
      duration: duration,
      easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)',
      fill: 'forwards'
    });
    
    animation.onfinish = () => {
      if (document.body.contains(petal)) {
        petal.remove();
      }
    };
  }

  intervalId = setInterval(createPetal, 850);
})

onUnmounted(() => {
  if (intervalId) {
    clearInterval(intervalId);
  }
  if (typeof document !== 'undefined') {
    document.querySelectorAll('.garden-falling-petal').forEach(el => el.remove());
  }
})
</script>
