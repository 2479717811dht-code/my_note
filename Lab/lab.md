---
title: 实验实战与课设 · Engineering Lab
description: 浙江大学计算机科学与技术专业实验报告、Vivado 工程与 MIPS CPU 设计归档
---

# 实验实战与课设 · Engineering Lab

<div class="garden-badge">🧪 软硬件协同实战 · 从代码逻辑到硅片硬件</div>

这里归档了计算机系专业实验课的 PPT、电路工程源码、Vivado 约束文件与完整实验报告，供学术交流与课设参考。

---

## 核心硬件与系统实验 · Core Labs

点击卡片直接进入实验报告与设计代码归档：

<div class="garden-bento-grid">
  <a href="./Digital-Logic-Design-Lab.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">DLD LAB</span>
        <span class="bento-tag-badge lab">FPGA 实战</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">⚡</div>
        <div class="bento-content">
          <span class="bento-title">数字逻辑设计实验</span>
          <span class="bento-desc">Vivado 仿真与综合、FPGA 板卡管脚约束、状态机、经典实验报告与期末大作业</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <div class="bento-chips">
        <span class="bento-chip">Verilog HDL</span>
        <span class="bento-chip">大作业完整工程</span>
      </div>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="./Computer-Organization-Lab.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">CO LAB</span>
        <span class="bento-tag-badge lab">CPU 架构</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🖥️</div>
        <div class="bento-content">
          <span class="bento-title">计算机组成体系实验</span>
          <span class="bento-desc">MIPS 单周期 CPU 设计、汇编指令集仿真调试、流水线冒险机制与软硬件协同验证</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <div class="bento-chips">
        <span class="bento-chip">MIPS 汇编</span>
        <span class="bento-chip">CPU 数据通路</span>
      </div>
      <span class="bento-arrow">→</span>
    </div>
  </a>
</div>

---

## 实验避坑要诀 · Lab Tips & Notes

::: warning ⚠️ 实验代码与报告参考避坑提示
- **关于数逻实验（DLD Lab）**：本归档中数逻实验在 `Lab 9` 之后的实验部分存在部分时钟域和状态转移逻辑瑕疵，请各位同学参考时务必结合自身板卡逻辑独立推导验证；**但期末大作业部分是经过全功能上板测试与答辩的完整可用版本**，可安心参考思路！
- **关于计组实验（CO Lab）**：单周期 CPU 核心在于控制信号真值表的严密推导；流水线实验中务必关注数据冒险（Data Hazard）的前推旁路与分支预测清空机制，学会抓取 ModelSim / Vivado 仿真波形逐周期定位 Bug。
- **关于硬件调试**：硬件描述语言不同于顺序执行的高级语言，牢记「电路并发思维」，杜绝将非阻塞赋值（`<=`）与阻塞赋值（`=`）混用的常见陷阱。
:::

---

## 助学智囊团 · AI Research Assistants

遇到硬件报错、Verilog 语法迷思或汇编段错误时，可借助 AI 工具辅助排查：

<div class="ai-assistant-grid">
  <a href="https://chatgpt.com/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">🤖</div>
    <div class="ai-card-info">
      <span class="ai-card-name">ChatGPT</span>
      <span class="ai-card-desc">综合能力强，适合 Verilog 语法纠错与 MIPS 指令模拟</span>
    </div>
  </a>

  <a href="https://claude.ai/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">🧠</div>
    <div class="ai-card-info">
      <span class="ai-card-name">Claude</span>
      <span class="ai-card-desc">严谨细致，擅长分析长代码工程与硬件时序状态机逻辑</span>
    </div>
  </a>

  <a href="https://deepseek.com/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">⚡</div>
    <div class="ai-card-info">
      <span class="ai-card-name">DeepSeek</span>
      <span class="ai-card-desc">国产推理利器，擅长算法推导、C/汇编调试与逻辑分析</span>
    </div>
  </a>

  <a href="https://gemini.google.com/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">💎</div>
    <div class="ai-card-info">
      <span class="ai-card-name">Gemini</span>
      <span class="ai-card-desc">多模态能力出众，可上传电路原理图与波形截图辅助分析</span>
    </div>
  </a>

  <a href="https://kimi.moonshot.cn/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">🌙</div>
    <div class="ai-card-info">
      <span class="ai-card-name">Kimi</span>
      <span class="ai-card-desc">长文本阅读利器，擅长速读芯片手册 Datasheet 与实验指导书</span>
    </div>
  </a>

  <a href="https://grok.com/" target="_blank" rel="noopener noreferrer" class="ai-assistant-card">
    <div class="ai-card-icon">🚀</div>
    <div class="ai-card-info">
      <span class="ai-card-name">Grok</span>
      <span class="ai-card-desc">风格直接幽默，快速探讨前沿硬件架构与极客技巧</span>
    </div>
  </a>
</div>

<div class="garden-photo-frame">
  <img src="/20260602160047_1014_180.jpg" alt="Lab Focus" />
  <div class="garden-photo-caption">Practice Makes Perfect · 软硬协同，行而不辍，履践致远</div>
</div>
