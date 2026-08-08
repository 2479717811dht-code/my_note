---
layout: home

hero:
  name: "My Note"
  text: "MIX && CS"
  tagline: "H.T.Deng | AR15LAL"
  image:
    src: /cute.gif
    alt: "Logo"
  actions:
    - theme: brand
      text: "Start Reading"
      link: /Cover/logic
    - theme: alt
      text: "Check in GitHub"
      link: https://github.com/2479717811dht-code/my_note

features:
  - icon: "🧭"
    title: "Course Map"
    details: "课程总览，仅为内容完备性而写"
    link: /Cover/logic
    linkText: "Start Here"

  - icon: "💻"
    title: "Theory"
    details: "理论课的笔记整理，但不限计科专业课"
    link: /Theory/theory
    linkText: "Read Me"

  - icon: "🧪"
    title: "Lab"
    details: "实验课的 PPT 和一些报告（附代码）"
    link: /Lab/lab
    linkText: "Read Me"

  - icon: "☕"
    title: "Take a Break"
    details: "严肃放松一下，不是什么不可饶恕的罪过"
    link: /Break/break
    linkText: "Relax"
---

## Welcome

欢迎回来，想你了~

我只想在这样的桃花源拥有无限的治愈和温柔。

> :moon:I got you, moonlight, you're my starlight.:moon:
> 
> :sparkles:在月光下与你紧紧相拥，你就是我的熠熠星辉:sparkles:

<div style="margin: 2rem auto; width: 100%; max-width: 900px;">
  <style>
    .simple-hero-img {
      width: 100%;          /* 铺满父容器宽度 */
      height: auto;
      border-radius: 20px;  /* 还原之前大盒子的圆角 */
      border: 1px solid #ebdcd2; /* 还原大盒子的温柔边框颜色 */
      box-shadow: 2px 6px 20px rgba(140, 70, 50, 0.08); /* 还原大盒子的基础阴影 */
      transition: all 0.4s ease;
      display: block;
    }
    
    .simple-hero-img:hover {
      transform: translateY(-5px); /* 鼠标悬停时微微上浮 */
      box-shadow: 0 15px 35px rgba(184, 91, 68, 0.15); /* 阴影加深，产生呼吸感互动 */
    }
  </style>
  
  <img src="/indexPerson.png" alt="Always With You" class="simple-hero-img" />
</div>



## 使用方式

- 使用右侧“本页目录”快速跳转到文章章节。
- 页面支持深色与浅色模式。
- 所有代码块默认显示行号。
- 支持 Mermaid 流程图、数学公式、任务列表、脚注、上下标和高亮。
- 文章中继续写 `[toc]` 即可，网页会自动生成目录。

## Learning Notes

> 学习不是把内容机械记住，而是逐渐建立起能够自己解释、推导和解决问题的体系。

内容持续更新中。

## 写在最后

也许这些内容不太适合补天喵~

![](/20260625030353_324_1.jpg)

<script setup>
import { onMounted, onUnmounted } from 'vue'

let intervalId = null;

onMounted(() => {
  if (typeof window === 'undefined') return;

  const symbols = ['❤', '♥', '✨', '✦'];
  
  function createHeart() {
    const heart = document.createElement('div');
    heart.innerText = symbols[Math.floor(Math.random() * symbols.length)];
    
    // 【修改点 1】：起始位置从 bottom 改为 top，让它从屏幕最上方开始
    heart.style.position = 'fixed';
    heart.style.left = Math.random() * 100 + 'vw';
    heart.style.top = '-10vh'; // 从屏幕上方看不见的地方开始
    heart.style.fontSize = Math.random() * 25 + 10 + 'px'; 
    heart.style.zIndex = '9999';
    heart.style.pointerEvents = 'none'; 
    heart.style.color = '#ff2a5f';
    heart.style.textShadow = '0 0 15px #ff2a5f, 0 0 30px #ff2a5f'; 
    
    document.body.appendChild(heart);
    
    const duration = (Math.random() * 5 + 5) * 1000; 
    
    const animation = heart.animate([
      { transform: 'translateY(0) scale(0.5) rotate(0deg)', opacity: 0, offset: 0 },
      { opacity: 0.8, offset: 0.2 },
      // 【修改点 2】：translateY 的值从 -120vh 改成正数的 120vh，让它往下落
      { transform: 'translateY(120vh) scale(1.5) rotate(360deg)', opacity: 0, offset: 1 } 
    ], {
      duration: duration,
      easing: 'ease-in',
      fill: 'forwards'
    });
    
    animation.onfinish = () => {
      if (document.body.contains(heart)) {
        heart.remove();
      }
    };
  }

  intervalId = setInterval(createHeart, 300);
})

onUnmounted(() => {
  if (intervalId) {
    clearInterval(intervalId);
  }
})
</script>
