---
title: 计算机组成与系统实验 · Computer Organization Lab
description: 计算机系统硬件实验：单周期与流水线 CPU 微架构、Vivado 仿真与 IP2SOC 软硬件系统实战
---

# 计算机组成与系统实验 · Computer Organization Lab

<div class="garden-badge">🖥️ 软硬贯通 · 从门级电路到 SoC 计算机系统</div>

浙江大学计算机科学与技术专业核心系统实验，旨在打通数字逻辑电路、微架构指令集与软硬件协同系统之间的设计鸿沟。

---

## 核心实验模块

<div class="garden-bento-grid">
  <a href="./Lab_for_all/Computer_Organization/IP2SOC/README.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">Lab 02</span>
        <span class="bento-tag-badge core">SoC 系统</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">⚙️</div>
        <div class="bento-content">
          <span class="bento-title">OExp02 · IP2SOC 片上系统设计与集成</span>
          <span class="bento-desc">将自研 CPU 核心与总线、多功能外设（七段数码管、LED、按键、RAM/ROM）协同封装为 SoC 片上微系统</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <div class="bento-chips">
        <span class="bento-chip">IP 核打包</span>
        <span class="bento-chip">总线互联</span>
      </div>
      <span class="bento-arrow">→</span>
    </div>
  </a>

  <a href="/Theory/Computer_Organization_Midterm.html" class="bento-card">
    <div>
      <div class="bento-card-top">
        <span class="bento-code-badge">Architecture</span>
        <span class="bento-tag-badge core">体系推导</span>
      </div>
      <div class="bento-card-body">
        <div class="bento-icon-box">🧠</div>
        <div class="bento-content">
          <span class="bento-title">CPU 数据通路与流水线控制手册</span>
          <span class="bento-desc">单周期微架构、五级流水线（IF/ID/EX/MEM/WB）、结构冒险/数据冒险（Forwarding）与分支预测深度推导</span>
        </div>
      </div>
    </div>
    <div class="bento-card-footer">
      <div class="bento-chips">
        <span class="bento-chip">流水线冒险</span>
        <span class="bento-chip">Forwarding 旁路</span>
      </div>
      <span class="bento-arrow">→</span>
    </div>
  </a>
</div>

---

## 实验体系全景图

```mermaid
flowchart LR
    A["Verilog 门级逻辑基础 (DLD)"] --> B["ALU 与寄存器堆设计"]
    B --> C["单周期 CPU 控制器与数据通路"]
    C --> D["五级流水线 CPU 架构设计"]
    D --> E["Hazard Detection & Forwarding 单元"]
    E --> F["IP2SOC 片上系统外设与总线集成"]
    F --> G["FPGA 板卡真实运行与自检"]
```
