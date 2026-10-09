<!-- .vitepress/theme/CourseMatrix.vue -->
<script setup>
import { ref, computed } from 'vue'
import { withBase } from 'vitepress'

const currentCategory = ref('all') // 'all' | 'core' | 'math' | 'lab'

const categories = [
  { key: 'all', name: '全部科目', icon: '📚' },
  { key: 'core', name: '计算理论与核心', icon: '💻' },
  { key: 'math', name: '数理基石与人文', icon: '📐' },
  { key: 'lab', name: '硬件实验与图谱', icon: '🔬' }
]

const courses = [
  {
    category: 'core',
    code: 'FDS',
    tag: '专业核心',
    tagType: 'core',
    icon: '🌲',
    title: '数据结构基础',
    desc: '树与森林 · 优先队列与堆 · 散列表 · 图论最短路径与并查集',
    chips: ['84K字精研', '图算法'],
    link: '/Theory/Fundamentals_of_Data_Structure'
  },
  {
    category: 'core',
    code: 'ADS',
    tag: '进阶算法',
    tagType: 'core',
    icon: '🚀',
    title: '高级数据结构与算法',
    desc: 'AVL 树 · 伸展树 · B+ 树 · 左倾堆 · 摊还分析与近似算法',
    chips: ['cyll版讲义', '摊还分析'],
    link: '/Theory/Advanced_Data_Structure_Algorithm_Analysis'
  },
  {
    category: 'core',
    code: 'CO',
    tag: '硬件系统',
    tagType: 'core',
    icon: '🖥️',
    title: '计算机组成与体系',
    desc: 'MIPS 架构 · 指令集 · 单周期/流水线数据通路 · Cache 存储层次',
    chips: ['流水线微架构', 'Cache 映射'],
    link: '/Theory/Computer_Organization'
  },
  {
    category: 'core',
    code: 'DLD',
    tag: '硬件基石',
    tagType: 'core',
    icon: '⚡',
    title: '数字逻辑设计',
    desc: '布尔代数 · 卡诺图化简 · 组合时序逻辑 · 有限状态机 · Verilog 设计',
    chips: ['卡诺图', 'FSM 状态机'],
    link: '/Theory/dldnote'
  },
  {
    category: 'core',
    code: 'FPA',
    tag: '编程基石',
    tagType: 'core',
    icon: '💻',
    title: '程序设计与算法基础',
    desc: 'C/C++ 核心语法 · 指针内存模型 · 面向对象 · 基础算法与题型解析',
    chips: ['指针机制', '算法实战'],
    link: '/Theory/note-cs-code-cleaned'
  },
  {
    category: 'math',
    code: 'DM',
    tag: '数理基石',
    tagType: 'math',
    icon: '📐',
    title: '离散数学',
    desc: '命题谓词逻辑 · 集合与等价偏序关系 · 图论与树 · 组合计数与母函数',
    chips: ['偏序关系', '图论定理'],
    link: '/Theory/Discrete_Mathematics'
  },
  {
    category: 'math',
    code: 'PMS',
    tag: '数理基石',
    tagType: 'math',
    icon: '🎲',
    title: '概率论与数理统计',
    desc: '随机变量及分布 · 期望与方差 · 大数定律极限定理 · 参数估计与假设检验',
    chips: ['分布律模型', '置信区间'],
    link: '/Theory/Probability_and_Mathematical_Statistics'
  },
  {
    category: 'math',
    code: 'MARX',
    tag: '闭卷核心',
    tagType: 'math',
    icon: '🚩',
    title: '马克思主义基本原理',
    desc: '唯物辩证法 · 实践与认识论 · 资本论与剩余价值 · 期末与考研背诵要点',
    chips: ['考点大纲', '背诵导图'],
    link: '/Theory/Marxism'
  },
  {
    category: 'lab',
    code: 'DLD LAB',
    tag: 'FPGA 实战',
    tagType: 'lab',
    icon: '🧪',
    title: '数字逻辑设计实验',
    desc: 'Vivado 仿真综合 · FPGA 板卡管脚约束 · 组合时序报告与大作业工程',
    chips: ['Verilog HDL', '大作业代码'],
    link: '/Lab/Digital-Logic-Design-Lab'
  },
  {
    category: 'lab',
    code: 'CO LAB',
    tag: 'CPU 架构',
    tagType: 'lab',
    icon: '⚙️',
    title: '计算机组成体系实验',
    desc: 'MIPS 单周期 CPU 设计 · 汇编指令调试 · 中断异常与软硬件协同验证',
    chips: ['MIPS 汇编', 'CPU 数据通路'],
    link: '/Lab/Computer-Organization-Lab'
  },
  {
    category: 'lab',
    code: 'MAP',
    tag: '全局导引',
    tagType: 'life',
    icon: '🧭',
    title: '课程体系知识图谱',
    desc: '浙江大学计科培养方案全局脉络 · 选课规划 · 学习心法与 SGA 寄语',
    chips: ['培养路线', '全局框架'],
    link: '/Cover/logic'
  },
  {
    category: 'lab',
    code: 'BREAK',
    tag: '摸鱼小憩',
    tagType: 'life',
    icon: '☕',
    title: '摸鱼放松小站',
    desc: '赛博木鱼积攒功德 · 怀旧贪吃蛇 · 2048消除 · 极客冲浪社区与随笔',
    chips: ['木鱼功德+1', '益智街机'],
    link: '/Break/break'
  }
]

const filteredCourses = computed(() => {
  if (currentCategory.value === 'all') return courses
  return courses.filter(item => item.category === currentCategory.value)
})
</script>

<template>
  <div class="matrix-container">
    <!-- 分类切换导航条 -->
    <div class="matrix-filter-bar">
      <button
        v-for="cat in categories"
        :key="cat.key"
        type="button"
        :class="['matrix-filter-btn', { active: currentCategory === cat.key }]"
        @click="currentCategory = cat.key"
      >
        <span class="btn-icon">{{ cat.icon }}</span>
        <span>{{ cat.name }}</span>
        <span v-if="cat.key === 'all'" class="count-pill">{{ courses.length }}</span>
      </button>
    </div>

    <!-- 课程卡片网格 -->
    <div class="matrix-grid">
      <a
        v-for="item in filteredCourses"
        :key="item.code"
        :href="withBase(item.link)"
        class="matrix-card"
      >
        <div class="card-top">
          <span class="code-badge">{{ item.code }}</span>
          <span :class="['tag-badge', item.tagType]">{{ item.tag }}</span>
        </div>

        <div class="card-body">
          <div class="icon-box">{{ item.icon }}</div>
          <div class="info-box">
            <span class="card-title">{{ item.title }}</span>
            <span class="card-desc">{{ item.desc }}</span>
          </div>
        </div>

        <div class="card-footer">
          <div class="chips-group">
            <span v-for="chip in item.chips" :key="chip" class="chip-item">
              {{ chip }}
            </span>
          </div>
          <span class="card-arrow">→</span>
        </div>
      </a>
    </div>
  </div>
</template>

<style scoped>
.matrix-container {
  margin: 1.6rem 0 2.8rem;
  width: 100%;
}

/* 分类切换栏 */
.matrix-filter-bar {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 20px;
  background: rgba(184, 91, 68, 0.06);
  padding: 6px;
  border-radius: 14px;
  border: 1px solid rgba(184, 91, 68, 0.1);
  width: fit-content;
  max-width: 100%;
}

.matrix-filter-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  border-radius: 10px;
  border: none;
  background: transparent;
  color: var(--wi-text-soft, #63544e);
  font-size: 0.88rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
  white-space: nowrap;
}

.matrix-filter-btn:hover {
  color: var(--wi-accent, #b85b44);
  background: rgba(255, 255, 255, 0.6);
}

.matrix-filter-btn.active {
  background: #ffffff;
  color: var(--wi-accent, #b85b44);
  font-weight: 700;
  box-shadow: 0 2px 8px rgba(184, 91, 68, 0.14), 0 1px 3px rgba(0, 0, 0, 0.03);
}

.btn-icon {
  font-size: 0.95rem;
}

.count-pill {
  font-size: 0.72rem;
  background: rgba(184, 91, 68, 0.1);
  color: var(--wi-accent-dark, #963d28);
  padding: 1px 6px;
  border-radius: 999px;
  margin-left: 2px;
}

/* 卡片网格 */
.matrix-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
  width: 100%;
}

.matrix-card {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 18px 20px;
  background: linear-gradient(145deg, rgba(255, 255, 255, 0.94) 0%, rgba(253, 249, 243, 0.82) 100%);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(184, 91, 68, 0.14);
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(184, 91, 68, 0.05);
  text-decoration: none !important;
  color: inherit !important;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  overflow: hidden;
}

.matrix-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent 0%, var(--wi-accent, #b85b44) 50%, transparent 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.matrix-card:hover {
  transform: translateY(-4px);
  border-color: rgba(184, 91, 68, 0.42);
  box-shadow: 0 14px 34px -4px rgba(184, 91, 68, 0.16), 0 2px 8px rgba(0, 0, 0, 0.03);
}

.matrix-card:hover::before {
  opacity: 1;
}

/* 卡片顶部 */
.card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.code-badge {
  font-family: var(--vp-font-family-mono, monospace);
  font-size: 0.76rem;
  font-weight: 700;
  color: var(--wi-accent-dark, #963d28);
  background: rgba(184, 91, 68, 0.09);
  padding: 3px 8px;
  border-radius: 6px;
  letter-spacing: 0.5px;
  border: 1px solid rgba(184, 91, 68, 0.15);
}

.tag-badge {
  font-size: 0.74rem;
  font-weight: 600;
  padding: 3px 8px;
  border-radius: 999px;
  letter-spacing: 0.3px;
}

.tag-badge.core {
  background: rgba(184, 91, 68, 0.1);
  color: var(--wi-accent-dark, #963d28);
}

.tag-badge.math {
  background: rgba(78, 122, 199, 0.1);
  color: #2b5597;
}

.tag-badge.lab {
  background: rgba(46, 139, 87, 0.1);
  color: #246e44;
}

.tag-badge.life {
  background: rgba(198, 138, 76, 0.12);
  color: #945d1f;
}

/* 卡片内容 */
.card-body {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  margin-bottom: 14px;
}

.icon-box {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: linear-gradient(135deg, rgba(184, 91, 68, 0.1) 0%, rgba(250, 245, 238, 0.8) 100%);
  border: 1px solid rgba(184, 91, 68, 0.12);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.45rem;
  flex-shrink: 0;
  box-shadow: 0 2px 6px rgba(184, 91, 68, 0.04);
}

.info-box {
  flex: 1;
  min-width: 0;
}

.card-title {
  font-size: 1.05rem;
  font-weight: 700;
  color: var(--wi-heading, #2a1e1b);
  line-height: 1.35;
  margin-bottom: 4px;
  display: block;
  transition: color 0.2s ease;
}

.matrix-card:hover .card-title {
  color: var(--wi-accent, #b85b44);
}

.card-desc {
  font-size: 0.84rem;
  color: var(--wi-muted, #95847d);
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* 卡片底部 */
.card-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-top: 1px solid rgba(184, 91, 68, 0.08);
  padding-top: 10px;
  margin-top: auto;
}

.chips-group {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.chip-item {
  font-size: 0.72rem;
  color: var(--wi-text-soft, #63544e);
  background: #fbf7f2;
  padding: 2px 6px;
  border-radius: 4px;
  border: 1px solid rgba(184, 91, 68, 0.08);
}

.card-arrow {
  color: var(--wi-muted, #95847d);
  font-size: 1.15rem;
  font-weight: bold;
  transition: transform 0.25s ease, color 0.25s ease;
  line-height: 1;
}

.matrix-card:hover .card-arrow {
  transform: translateX(4px);
  color: var(--wi-accent, #b85b44);
}

@media (max-width: 640px) {
  .matrix-grid {
    grid-template-columns: 1fr;
  }
}
</style>
