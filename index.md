---
layout: home

hero:
  name: "My Note"
  text: "AR15LAL"
  tagline: "一个没有对象的野指针 · 计算机专业数字花园与学术沉淀"
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
    title: "Course Map"
    details: "课程脉络与全局导航，系统化梳理大学计算机专业知识图谱与选课逻辑"
    link: /Cover/logic
    linkText: "探索知识图谱 →"

  - icon: "💻"
    title: "Theory Notes"
    details: "理论课深度笔记，涵盖数据结构、计算机组成、离散数学与经典算法"
    link: /Theory/theory
    linkText: "阅读理论课 →"

  - icon: "🧪"
    title: "Engineering Lab"
    details: "实验实战与设计报告，从 Verilog 逻辑硬件到软硬件协同代码归档"
    link: /Lab/lab
    linkText: "进入实验集 →"

  - icon: "☕"
    title: "Take a Break"
    details: "在学术与代码间隙停下脚步，严肃放松一下，拥抱无限的治愈与温柔"
    link: /Break/break
    linkText: "呼吸片刻 →"
---

<div style="text-align: center; margin-top: 1.5rem;">
  <div class="garden-badge">✨ 欢迎步入我的数字花园 · Digital Garden</div>
</div>

<div class="garden-quote-box">
  <div class="garden-quote-title">Moonlight & Starlight</div>
  <div class="garden-quote-content">
    “I got you, moonlight, you're my starlight. 在月光下与你紧紧相拥，你就是我的熠熠星辉。”
  </div>
</div>

<div class="garden-banner-card">
  <img src="/indexPerson.png" alt="Always With You" class="garden-banner-img" />
</div>

## 快速导航 · Quick Navigation

<div class="garden-quick-nav">
  <a href="/Cover/logic" class="garden-nav-pill">
    <span><span class="icon">🧭</span>课程总览与导引</span>
    <span class="arrow">→</span>
  </a>
  <a href="/Theory/theory" class="garden-nav-pill">
    <span><span class="icon">💻</span>理论专业课笔记</span>
    <span class="arrow">→</span>
  </a>
  <a href="/Lab/lab" class="garden-nav-pill">
    <span><span class="icon">🧪</span>实验设计与代码</span>
    <span class="arrow">→</span>
  </a>
  <a href="/Break/break" class="garden-nav-pill">
    <span><span class="icon">☕</span>日常小憩与随笔</span>
    <span class="arrow">→</span>
  </a>
</div>

## 阅览指南 · Reading Guide

- **高效跳转**：文章篇幅较长时，可使用右侧「本页目录」或文章顶部的目录快速定位。
- **排版支持**：全站支持 **LaTeX / MathJax 公式**、**Mermaid 结构图**、任务列表、脚注及代码行号。
- **目录书写**：笔记中直接键入 `[toc]`，渲染引擎将自动解析生成层级目录树。
- **背景音乐**：右上角导航栏支持**背景音乐播放切换**，戴上耳机沉浸阅读体验更佳。

## 学习理念 · Philosophy

> **格物致知 · 体系化推导**
> 
> 学习不是把零碎的概念机械背诵，而是逐渐建立起能够自己推导、解释与解决真实工程问题的思维框架。纸上得来终觉浅，绝知此事要躬行。

## 轻松一刻 · Memes

也许这些内容不太适合补天喵，但适合给紧绷的心情放个假 ~

<div class="garden-meme-gallery">
  <div class="garden-meme-item">
    <img src="/pig_to_right.gif" alt="奔跑吧1" />
  </div>
  <div class="garden-meme-item">
    <img src="/pig_to_left.gif" alt="奔跑吧2" />
  </div>
</div>

<div class="my-motto">
  “知止而后有定，定而后能静，静而后能安，安而后能虑，虑而后能得。”
  <div class="my-sign">—— H.T. Deng</div>
</div>

<script setup>
import { onMounted, onUnmounted } from 'vue'

let intervalId = null;

onMounted(() => {
  if (typeof window === 'undefined') return;

  const symbols = ['✦', '✨', '♥', '❀', '✿'];
  const colors = ['#b85b44', '#cf6e57', '#d9822b', '#e29578', '#c68a4c'];

  function createPetal() {
    // 限制页面上最多同时存在 18 个微粒，避免内存累积
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

  // 间隔提升为 800ms，优雅轻盈，不抢夺正文注意力
  intervalId = setInterval(createPetal, 800);
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
