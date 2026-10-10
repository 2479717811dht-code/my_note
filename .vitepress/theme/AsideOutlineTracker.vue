<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useData } from 'vitepress'

const { isDark } = useData()

// 阅读进度
const scrollProgress = ref(0)

const updateProgress = () => {
  const docElement = document.documentElement
  const scrollTop = window.scrollY || docElement.scrollTop
  const scrollHeight = docElement.scrollHeight - docElement.clientHeight
  if (scrollHeight > 0) {
    const progress = Math.min(100, Math.max(0, Math.round((scrollTop / scrollHeight) * 100)))
    scrollProgress.value = progress
  } else {
    scrollProgress.value = 0
  }
}

const toggleDark = () => {
  isDark.value = !isDark.value
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => {
  window.addEventListener('scroll', updateProgress, { passive: true })
  updateProgress()
})

onUnmounted(() => {
  window.removeEventListener('scroll', updateProgress)
})
</script>

<template>
  <div class="aside-companion-card">
    <!-- 昼夜模式切换按钮 -->
    <div class="theme-mode-row" @click="toggleDark" :title="isDark ? '切换至日间浅色模式' : '切换至深色夜间模式'">
      <div class="theme-mode-info">
        <span class="theme-icon">{{ isDark ? '🌙' : '☀️' }}</span>
        <span class="theme-text">{{ isDark ? '暗夜模式' : '日间模式' }}</span>
      </div>
      <div class="theme-switch-pill" :class="{ 'is-dark': isDark }">
        <span class="switch-knob"></span>
      </div>
    </div>

    <!-- 阅读进度条 -->
    <div class="reading-progress-wrap">
      <div class="progress-meta">
        <span class="progress-label">阅读进度</span>
        <span class="progress-value">{{ scrollProgress }}%</span>
      </div>
      <div class="progress-track">
        <div class="progress-fill" :style="{ width: scrollProgress + '%' }"></div>
      </div>
    </div>

    <!-- 快捷返回顶部（进度 > 10% 时淡入） -->
    <button v-show="scrollProgress > 8" class="quick-top-btn" @click="scrollToTop" title="返回顶部">
      <span class="top-icon">↑</span>
      <span>返回顶部</span>
    </button>
  </div>
</template>

<style scoped>
.aside-companion-card {
  margin-bottom: 16px;
  padding: 12px 14px;
  background: var(--vp-c-bg-elv);
  border: 1px solid var(--vp-c-border);
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(130, 65, 45, 0.05);
  transition: all 0.3s ease;
}

.dark .aside-companion-card {
  background: #201c1a;
  border-color: #3b312c;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.35);
}

/* 昼夜切换行 */
.theme-mode-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  padding: 6px 8px;
  border-radius: 8px;
  background: var(--vp-c-bg-soft);
  transition: all 0.2s ease;
  user-select: none;
}

.theme-mode-row:hover {
  background: var(--vp-c-brand-soft);
}

.theme-mode-info {
  display: flex;
  align-items: center;
  gap: 6px;
}

.theme-icon {
  font-size: 14px;
}

.theme-text {
  font-size: 13px;
  font-weight: 600;
  color: var(--wi-heading);
}

.theme-switch-pill {
  width: 36px;
  height: 20px;
  border-radius: 10px;
  background: #d8c8bd;
  position: relative;
  transition: background 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.theme-switch-pill.is-dark {
  background: var(--vp-c-brand-1);
}

.switch-knob {
  position: absolute;
  top: 2px;
  left: 2px;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: #ffffff;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.theme-switch-pill.is-dark .switch-knob {
  transform: translateX(16px);
}

/* 阅读进度 */
.reading-progress-wrap {
  margin-top: 10px;
  padding-top: 8px;
  border-top: 1px dashed var(--vp-c-divider);
}

.progress-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
  font-size: 12px;
}

.progress-label {
  color: var(--wi-muted);
}

.progress-value {
  font-weight: 700;
  color: var(--wi-accent);
  font-feature-settings: "tnum";
}

.progress-track {
  width: 100%;
  height: 4px;
  background: var(--vp-c-bg-soft);
  border-radius: 2px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--vp-c-brand-3) 0%, var(--vp-c-brand-1) 100%);
  border-radius: 2px;
  transition: width 0.15s ease-out;
}

/* 返回顶部按钮 */
.quick-top-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  width: 100%;
  margin-top: 10px;
  padding: 5px 0;
  font-size: 12px;
  font-weight: 600;
  color: var(--wi-accent);
  background: var(--vp-c-brand-soft);
  border: 1px solid transparent;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.quick-top-btn:hover {
  background: var(--vp-c-brand-1);
  color: #ffffff;
  transform: translateY(-1px);
}

.top-icon {
  font-weight: 800;
  font-size: 13px;
}
</style>
