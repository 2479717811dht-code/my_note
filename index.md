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

<style>
  /* 1. 中间图片呼吸发光特效 */
  @keyframes glow-breathe {
    0% { box-shadow: 0 0 15px rgba(255, 105, 180, 0.3); transform: scale(1); }
    100% { box-shadow: 0 0 40px rgba(255, 105, 180, 0.7); transform: scale(1.02); }
  }
  /* 2. 右侧歌词滚动特效 */
  @keyframes scroll-lyrics {
    0% { transform: translateY(100%); }
    100% { transform: translateY(-120%); }
  }

  /* 3. 左侧宇宙星轨旋转特效 */
  @keyframes spin-right { 100% { transform: rotate(360deg); } }
  @keyframes spin-left { 100% { transform: rotate(-360deg); } }
  @keyframes pulse-core {
    0%, 100% { transform: scale(1); opacity: 0.8; }
    50% { transform: scale(1.1); opacity: 1; box-shadow: 0 0 25px var(--vp-c-brand-1); }
  }

  .orbit-box {
    position: relative;
    width: 120px;
    height: 120px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .orbit-ring {
    position: absolute;
    border-radius: 50%;
    border: 2px solid transparent;
  }
  .ring-1 {
    width: 120px; height: 120px;
    border-top: 2px solid var(--vp-c-brand-1);
    border-right: 2px solid var(--vp-c-brand-1);
    animation: spin-right 4s linear infinite;
  }
  .ring-2 {
    width: 90px; height: 90px;
    border-bottom: 2px dashed var(--vp-c-brand-soft);
    border-left: 2px dashed var(--vp-c-brand-soft);
    animation: spin-left 3s linear infinite;
  }
  .orbit-core {
    width: 45px; height: 45px;
    background: var(--vp-c-brand-1);
    border-radius: 50%;
    animation: pulse-core 2s ease-in-out infinite;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 11px;
    font-weight: bold;
    font-family: monospace;
    letter-spacing: 1px;
  }
</style>  

<div style="display: flex; justify-content: center; align-items: center; gap: 3rem; margin: 3rem 0; flex-wrap: wrap; background: var(--vp-c-bg-soft); padding: 2.5rem; border-radius: 24px; box-shadow: 0 8px 24px rgba(0,0,0,0.05);">

  <!-- 左侧：星轨环绕特效 -->
  <div style="width: 130px; display: flex; flex-direction: column; align-items: center; gap: 1rem;">
    <div class="orbit-box">
      <div class="orbit-ring ring-1"></div>
      <div class="orbit-ring ring-2"></div>
      <div class="orbit-core">LOVE</div>
    </div>
    <div style="font-family: monospace; font-size: 0.85rem; color: var(--vp-c-text-2); font-weight: bold; letter-spacing: 2px; margin-top: 0.5rem; text-align: center;">
      MY<br>UNIVERSE
    </div>
  </div>

  <!-- 中间：相拥图片 (带呼吸特效) -->
  <img 
    src="/indexPerson.png" 
    alt="相拥" 
    style="border-radius: 50%; width: 220px; height: 220px; object-fit: cover; border: 4px solid var(--vp-c-bg); animation: glow-breathe 3s infinite alternate ease-in-out; z-index: 2;" 
  />

  <!-- 右侧：滚动歌词 + 装饰性无声播放器 -->
  <div style="width: 240px; display: flex; flex-direction: column; align-items: center; gap: 1.2rem; border-left: 2px dashed var(--vp-c-divider); padding-left: 2rem;">
    
    <!-- 滚动歌词 (带上下渐隐遮罩) -->
    <div style="width: 100%; height: 100px; overflow: hidden; position: relative; -webkit-mask-image: linear-gradient(to bottom, transparent 0%, black 20%, black 80%, transparent 100%); mask-image: linear-gradient(to bottom, transparent 0%, black 20%, black 80%, transparent 100%);">
      <div style="position: absolute; top: 0; left: 0; right: 0; animation: scroll-lyrics 16s linear infinite; text-align: center; font-size: 0.9rem; line-height: 2.2; color: var(--vp-c-text-1);">
        如果離別是為了能再見一面<br>
        愛是想念後的拋物線<br>
        離開始漸行漸遠<br>
        和我們總是擦肩<br>
        這次再見如果是最後的一面<br>
        也是失眠後的分割線<br>
        春天已開始落葉<br>
        七月裡也會下雪<br>
        剛剛我錯過的大雨 握不住的盛夏<br>
        飄過的雲是你嗎? 一圈又一圈<br>
        我多想是路过你的风<br>
        忍不住落回你眼中<br>
        凭什么绕不开 翻不过的盛夏<br>
        有些远方 让风代替我们抵达<br>
        没勇气说完的那句话<br>
        希望有人听过它<br>
        这次再见如果是最后的一面<br>
        也是失眠后的分割线<br>
        春天已开始落叶<br>
        七月里也会下雪<br>
        刚刚我错过的大雨 握不住的盛夏<br>
        飘过的云是你吗? 一圈又一圈<br>
        我多想是路过你的风<br>
        忍不住落回你眼中<br>
        凭什么绕不开 翻不过的盛夏<br>
        有些远方 让风代替我们抵达<br>
        没勇气说完的那句话<br>
        希望有人听过它<br>
        让你听见风缓缓地 缓缓摇曳<br>
        时光卷起了回忆慢慢翩翩<br>
        让风替我说 说那句告别<br>
        在这个落叶像雪的季节<br>
        刚刚我错过的大雨 握不住的盛夏<br>
        飘过的云是你吗? 一圈又一圈<br>
        我多想是路过你的风<br>
        忍不住落回你眼中<br>
        凭什么绕不开 翻不过的盛夏<br>
        有些远方 让风代替我们抵达<br>
        没勇气说完的那句话<br>
        希望有人听过它<br>
        —— 🎵 单依纯《想你时风起》
      </div>
    </div>

    <!-- 纯 CSS 绘制的静音装饰播放器 -->
    <div style="width: 100%; height: 40px; background: var(--vp-c-bg); border: 1px solid var(--vp-c-divider); border-radius: 30px; display: flex; align-items: center; padding: 0 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); gap: 12px;">
      <!-- 播放图标 -->
      <div style="width: 0; height: 0; border-top: 6px solid transparent; border-bottom: 6px solid transparent; border-left: 10px solid var(--vp-c-brand-1);"></div>
      <!-- 进度条 -->
      <div style="flex-grow: 1; height: 4px; background: var(--vp-c-divider); border-radius: 2px; position: relative;">
        <div style="position: absolute; left: 0; top: 0; height: 100%; width: 45%; background: var(--vp-c-brand-1); border-radius: 2px;"></div>
        <div style="position: absolute; left: 45%; top: -3px; width: 10px; height: 10px; background: var(--vp-c-bg); border: 2px solid var(--vp-c-brand-1); border-radius: 50%;"></div>
      </div>
      <!-- 时间显示 -->
      <div style="font-size: 0.75rem; color: var(--vp-c-text-2); font-family: monospace;">02:14</div>
    </div>
    
  </div>
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

