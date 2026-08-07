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

> [!NOTE]
> :sparkles:我...真的...真的...真的...好喜欢你:sparkles:

<!-- === 暖陶主题相拥特效容器版 (适配你的 VitePress - 修复 SSR 报错) === -->
<div id="romantic-box" style="position: relative; overflow: hidden; background: linear-gradient(135deg, #fdf7f2 0%, #f4e8df 100%); border: 1px solid #ebdcd2; border-radius: 20px; padding: 3rem 1rem; margin: 2rem 0; display: flex; align-items: center; justify-content: center; box-shadow: 2px 6px 20px rgba(140, 70, 50, 0.08);">

  <style>
    /* 样式隔离 */
    #romantic-box * { box-sizing: border-box; }
    #romantic-box .hero-container-inner { display: flex; align-items: center; justify-content: center; gap: 2rem; width: 100%; max-width: 900px; position: relative; z-index: 10; flex-wrap: wrap; font-family: "LXGW WenKai Screen", "LXGW WenKai GB Screen", "霞鹜文楷 GB 屏幕阅读版", sans-serif; }
    
    /* 左侧文字 - 适配暖陶主色调 */
    #romantic-box .neon-title { 
      font-size: 2.5rem; 
      color: #9c4633; 
      text-shadow: 0 0 10px rgba(184, 91, 68, 0.3), 0 0 20px rgba(184, 91, 68, 0.2); 
      margin: 0 0 0.5rem 0; 
      font-weight: bold; 
      line-height: 1.2; 
      text-align: right; 
      -webkit-text-stroke: 0.6px #9c4633;
    }
    #romantic-box .sub-text { 
      color: #6b5c58; 
      font-size: 1.1rem; 
      line-height: 1.6; 
      text-align: right; 
      font-weight: 500;
    }
    
    /* 图片包装器与光晕 */
    #romantic-box .image-wrapper-inner { position: relative; animation: floatObj 6s ease-in-out infinite; margin: 1rem 0; }
    #romantic-box .image-wrapper-inner::before { 
      content: ''; position: absolute; top: -5%; left: -5%; width: 110%; height: 110%; 
      background: radial-gradient(circle, rgba(209, 117, 97, 0.4) 0%, rgba(184, 91, 68, 0.2) 50%, transparent 70%); 
      border-radius: 50%; z-index: 1; filter: blur(25px); animation: pulseGlowObj 4s infinite alternate; 
    }
    /* 图片本身，借用你全局定义的画框质感 */
    #romantic-box .main-image-inner { 
      width: 300px; max-width: 100%; height: auto; 
      border: 6px solid #fff; 
      outline: 2px solid #e3d2c8;
      border-radius: 20px; 
      position: relative; z-index: 2; 
      box-shadow: 0 10px 25px rgba(184, 91, 68, 0.15);
      transition: transform 0.4s ease, box-shadow 0.4s ease; display: block; 
    }
    #romantic-box .main-image-inner:hover { 
      transform: scale(1.03) translateY(-5px); 
      box-shadow: 0 15px 35px rgba(184, 91, 68, 0.25);
    }
    
    /* 右侧滚动歌词 */
    #romantic-box .side-right-inner { flex: 1; min-width: 200px; max-width: 300px; }
    #romantic-box .lyrics-container-inner { height: 250px; overflow: hidden; -webkit-mask-image: linear-gradient(to bottom, transparent 0%, black 20%, black 80%, transparent 100%); mask-image: linear-gradient(to bottom, transparent 0%, black 20%, black 80%, transparent 100%); }
    #romantic-box .lyrics-track-inner { display: flex; flex-direction: column; gap: 1rem; padding-top: 100px; animation: scrollLyricsInner 20s linear infinite; margin: 0; }
    #romantic-box .lyrics-container-inner:hover .lyrics-track-inner { animation-play-state: paused; }
    
    /* 歌词文字颜色调整为深色主题下可见 */
    #romantic-box .lyric-line-inner { color: #9c8a84; transition: all 0.3s; cursor: default; font-size: 1.05rem; margin: 0; font-weight: 500;}
    #romantic-box .lyric-line-inner:hover { 
      color: #b85b44; 
      transform: scale(1.08) translateX(10px); 
      text-shadow: 0 0 8px rgba(184, 91, 68, 0.4); 
    }
    
    /* 爱心粒子，颜色换成暖陶红 */
    #romantic-box .heart-particle { position: absolute; bottom: -30px; color: #b85b44; pointer-events: none; animation: floatUpHeart ease-in forwards; opacity: 0; z-index: 1; text-shadow: 0 0 10px rgba(184, 91, 68, 0.6); }
    
    @keyframes floatObj { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
    @keyframes pulseGlowObj { 0% { opacity: 0.5; transform: scale(0.95); } 100% { opacity: 0.8; transform: scale(1.05); } }
    @keyframes scrollLyricsInner { 0% { transform: translateY(0); } 100% { transform: translateY(-100%); } }
    @keyframes floatUpHeart { 0% { transform: translateY(0) scale(0.5) rotate(0deg); opacity: 0; } 20% { opacity: 0.7; } 100% { transform: translateY(-400px) scale(1.2) rotate(360deg); opacity: 0; } }
    
    /* 手机端适配 */
    @media (max-width: 768px) {
      #romantic-box .hero-container-inner { flex-direction: column; text-align: center; gap: 1.5rem; }
      #romantic-box .neon-title, #romantic-box .sub-text { text-align: center; }
      #romantic-box .lyric-line-inner:hover { transform: scale(1.08); }
    }
  </style>

  <div class="hero-container-inner">
    <!-- 左侧文案 -->
    <div class="side-left-inner">
      <h2 class="neon-title">Always<br>With You</h2>
      <p class="sub-text">星光坠落，时间定格。<br>在这浩瀚的宇宙里，<br>只为你一人停留。</p>
    </div>

    <!-- 中间图片 -->
    <div class="image-wrapper-inner">
      <img src="/indexPerson.png" alt="相拥" class="main-image-inner" />
    </div>

    <!-- 右侧滚动歌词 -->
    <div class="side-right-inner">
      <div class="lyrics-container-inner">
        <div class="lyrics-track-inner">
          <p class="lyric-line-inner">I found a love for me</p>
          <p class="lyric-line-inner">Darling just dive right in</p>
          <p class="lyric-line-inner">And follow my lead</p>
          <p class="lyric-line-inner">Well I found a girl beautiful and sweet</p>
          <p class="lyric-line-inner">I never knew you were the someone waiting for me</p>
          <p class="lyric-line-inner">'Cause we were just kids when we fell in love</p>
          <p class="lyric-line-inner">Not knowing what it was</p>
          <p class="lyric-line-inner">I will not give you up this time</p>
        </div>
      </div>
    </div>
  </div>

  <script>
    // 【关键修复】：检查是否在浏览器环境下运行
    if (typeof window !== 'undefined' && typeof document !== 'undefined') {
      (function() {
        const box = document.getElementById('romantic-box');
        if(!box) return;
        function createHeart() {
          const heart = document.createElement('div');
          heart.classList.add('heart-particle');
          const symbols = ['❤', '♥', '✨'];
          heart.innerHTML = symbols[Math.floor(Math.random() * symbols.length)];
          heart.style.left = Math.random() * 90 + '%';
          heart.style.animationDuration = (Math.random() * 3 + 4) + 's';
          heart.style.fontSize = (Math.random() * 12 + 10) + 'px';
          box.appendChild(heart);
          setTimeout(() => { heart.remove(); }, 6000);
        }
        setInterval(createHeart, 500);
      })();
    }
  </script>
</div>
<!-- === 暖陶容器版结束 === -->
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

