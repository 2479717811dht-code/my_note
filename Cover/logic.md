---
title: 知识图谱 · Course Map
description: 浙江大学计算机科学与技术专业课程脉络与知识图谱全局导览
---

# 知识图谱 · Course Map

<div class="garden-badge">🧭 体系化视野 · 浙江大学计算机科学专业培养逻辑</div>

Welcome to **My Note**，浙大计科学子与技术探索者的数字花园。

这里整理的是在学习浙江大学计算机科学与技术相关专业课时积累的深度笔记、数学推导、Verilog 硬件工程、易错点与期末复习总结。这些内容不是死记硬背的考前小抄，而是随着学习不断修正、重构与演进的知识宝库。

> **“These notes are your treasure. Start your journey, keep thinking, and enjoy learning.”**

[toc]

---

## 培养路线阶梯 · Curriculum Roadmap

计算机专业知识体系是一座自底向上的精密大厦，推荐循序渐进阅读：

<div class="roadmap-step-grid">
  <div class="roadmap-step-card">
    <span class="step-phase-badge">阶段一 · 筑基思维</span>
    <span class="step-title">程序设计与形式逻辑</span>
    <span class="step-desc">建立严密的结构化编程习惯与指针内存模型，掌握离散数学命题谓词与集合推导。</span>
    <div class="step-tags">
      <span class="step-tag-pill">FPA · 算法基础</span>
      <span class="step-tag-pill">DM · 离散数学</span>
    </div>
  </div>

  <div class="roadmap-step-card">
    <span class="step-phase-badge">阶段二 · 核心基石</span>
    <span class="step-title">硬件门级电路与数据结构</span>
    <span class="step-desc">自底向上理解卡诺图与有限状态机；掌握树、堆、图论与经典算法渐近复杂度分析。</span>
    <div class="step-tags">
      <span class="step-tag-pill">DLD · 数字逻辑</span>
      <span class="step-tag-pill">FDS · 数据结构</span>
    </div>
  </div>

  <div class="roadmap-step-card">
    <span class="step-phase-badge">阶段三 · 软硬协同</span>
    <span class="step-title">微体系结构与工程落地</span>
    <span class="step-desc">深入单周期与流水线数据通路、Cache层次；通过 Vivado 与 FPGA 上板实现真实电路。</span>
    <div class="step-tags">
      <span class="step-tag-pill">CO · 计算机组成</span>
      <span class="step-tag-pill">Labs · 硬件实验</span>
    </div>
  </div>

  <div class="roadmap-step-card">
    <span class="step-phase-badge">阶段四 · 高阶沉淀</span>
    <span class="step-title">高阶算法与通识素养</span>
    <span class="step-desc">探索平衡树进阶、摊还分析与近似算法；夯实概率统计模型与马克思主义唯物辩证法。</span>
    <div class="step-tags">
      <span class="step-tag-pill">ADS · 高阶算法</span>
      <span class="step-tag-pill">PMS · 概率统计</span>
      <span class="step-tag-pill">MARX · 马原</span>
    </div>
  </div>
</div>

---

## 核心科目专栏导航 · Courses

<div class="garden-bento-grid">
  <a href="../Theory/note-cs-code-cleaned.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">FPA</span>
        <span class="bento-tag-badge core">编程基石</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">💻</div>
        <div class="bento-content">
          <span class="bento-title">程序设计与算法基础</span>
          <span class="bento-desc">程序设计思维、C/C++规范、指针与内存模型、高频算法题型分析</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">C/C++ 实战</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/dldnote.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">DLD</span>
        <span class="bento-tag-badge core">硬件逻辑</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">⚡</div>
        <div class="bento-content">
          <span class="bento-title">数字逻辑设计</span>
          <span class="bento-desc">数制系统、布尔代数、卡诺图化简、时序电路、有限状态机与 Verilog</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">状态机设计</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Fundamentals_of_Data_Structure.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">FDS</span>
        <span class="bento-tag-badge core">算法核心</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🌲</div>
        <div class="bento-content">
          <span class="bento-title">数据结构基础</span>
          <span class="bento-desc">线性表、树与森林、二叉平衡树、优先队列、图论算法与散列技术</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">84K字精研</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Discrete_Mathematics.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">DM</span>
        <span class="bento-tag-badge math">数理形式化</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">📐</div>
        <div class="bento-content">
          <span class="bento-title">离散数学</span>
          <span class="bento-desc">命题谓词逻辑、集合与关系、等价偏序、图论定理、组合计数与生成函数</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">偏序/母函数</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Computer_Organization.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">CO</span>
        <span class="bento-tag-badge core">体系架构</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🖥️</div>
        <div class="bento-content">
          <span class="bento-title">计算机组成与体系</span>
          <span class="bento-desc">MIPS 架构、单周期与多周期控制器、流水线数据通路、冒险暂停与 Cache 映射</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">流水线微架构</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Advanced_Data_Structure_Algorithm_Analysis.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">ADS</span>
        <span class="bento-tag-badge core">高阶算法</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🚀</div>
        <div class="bento-content">
          <span class="bento-title">高级数据结构与算法</span>
          <span class="bento-desc">AVL 树、伸展树、B+ 树、左倾堆、红黑树、摊还分析与近似算法</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">cyll版讲义</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Probability_and_Mathematical_Statistics.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">PMS</span>
        <span class="bento-tag-badge math">数学课</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🎲</div>
        <div class="bento-content">
          <span class="bento-title">概率论与数理统计</span>
          <span class="bento-desc">随机变量及其分布律、极限定理、参数点估计与置信区间、假设检验推导</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">估计检验</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="../Theory/Marxism.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">MARX</span>
        <span class="bento-tag-badge math">闭卷要点</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🚩</div>
        <div class="bento-content">
          <span class="bento-title">马克思主义基本原理</span>
          <span class="bento-desc">唯物论辩证法、实践认识论、资本主义生产与剩余价值、考研核心考点</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <span class="bento-chip">背诵导图</span>
      <span class="bento-arrow">→</span>
    </div>
  </a>
</div>

---

## 研读自查清单 · Study Checklist

* [ ] 阅读课程核心概念与物理/数学直观
* [ ] 独立推导核心公式、定理证明与真值表
* [ ] 手算典型例题（如状态机化简、Dijkstra 每步过程）
* [ ] 定期总结易错点与极端边界条件（Corner Cases）
* [ ] 尝试用自己的语言向他人解释某概念（费曼学习法）
* [ ] 期末复习时回顾错题与易混淆概念对比

---

## 治学心法 · Thinking In Systems

学习计算机课程时，最宝贵的不是记住零散的最终结论，而是能自主解答这四个问题：

1. **这个概念或硬件机制到底在解决什么核心痛点？**
2. **为什么前人要这样设计，而非采用更简单的方式？**
3. **它和系统上下层（编译器、硬件、操作系统）有什么联动？**
4. **换一种题目形式或工程场景后，我还能不能自己严密推出答案？**

---

## 卷末寄语 · Final Remarks

最后，我想用 SGA 在 2026 年西决第七场不敌马刺的赛后采访中，他笑着说出的最后一句来作结，愿我们都能够：

<div style="text-align: center; margin: 2rem auto; font-size: 1.35rem; font-weight: 700; color: var(--wi-accent-dark); letter-spacing: 2px;">
  “拿得起，也放得下。”
</div>

<div class="garden-quote-box" style="text-align: center;">
  <div class="garden-quote-title">🏀 SGA's Summer Whisper</div>
  <div class="garden-quote-content" style="font-style: italic; font-family: Georgia, serif; font-size: 1.15rem;">
    “Thanks, guys. You have a great summer. See you.”
  </div>
  <div style="text-align: right; margin-top: 10px; font-weight: 700; color: var(--wi-accent);">
    —— Shai Gilgeous-Alexander ⚡
  </div>
</div>
