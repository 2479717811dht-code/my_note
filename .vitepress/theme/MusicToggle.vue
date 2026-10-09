<!-- 文件路径：.vitepress/theme/MusicToggle.vue -->
<script setup>
import { ref } from 'vue'
import { withBase } from 'vitepress'

const isPlaying = ref(false)
const audioRef = ref(null)

const toggleMusic = async () => {
  if (!audioRef.value) return

  if (isPlaying.value) {
    audioRef.value.pause()
    isPlaying.value = false
  } else {
    try {
      await audioRef.value.play()
      isPlaying.value = true
    } catch (err) {
      console.warn('Autoplay prevented or audio play failed:', err)
      isPlaying.value = false
    }
  }
}

const handleEnded = () => {
  isPlaying.value = false
}
</script>

<template>
  <button
    type="button"
    class="music-toggle"
    :class="{ 'is-playing': isPlaying }"
    @click="toggleMusic"
    :title="isPlaying ? '暂停背景音乐' : '播放背景音乐'"
    :aria-label="isPlaying ? '暂停背景音乐' : '播放背景音乐'"
  >
    <!-- 播放图标 -->
    <svg v-if="!isPlaying" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
      <path d="M8 5v14l11-7z"/>
    </svg>
    <!-- 暂停/律动图标 -->
    <svg v-else class="playing-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
      <path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/>
    </svg>

    <!-- 音频元素：设置 preload="none" 避免首屏全量下载 -->
    <audio
      ref="audioRef"
      :src="withBase('/song.mp3')"
      preload="none"
      loop
      @ended="handleEnded"
    ></audio>
  </button>
</template>

<style scoped>
.music-toggle {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  cursor: pointer;
  color: #b85b44;
  background: rgba(184, 91, 68, 0.08);
  border: 1px solid rgba(184, 91, 68, 0.2);
  border-radius: 50%;
  transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
  margin-left: 12px;
  padding: 0;
  outline: none;
}

.music-toggle:hover {
  background-color: rgba(184, 91, 68, 0.18);
  border-color: #b85b44;
  transform: scale(1.08);
  box-shadow: 0 3px 12px rgba(184, 91, 68, 0.2);
}

.music-toggle.is-playing {
  background-color: #b85b44;
  color: #ffffff;
  border-color: #b85b44;
  box-shadow: 0 0 12px rgba(184, 91, 68, 0.45);
  animation: gentle-pulse 2s infinite ease-in-out;
}

@keyframes gentle-pulse {
  0%, 100% {
    box-shadow: 0 0 0 0 rgba(184, 91, 68, 0.4);
  }
  50% {
    box-shadow: 0 0 0 6px rgba(184, 91, 68, 0);
  }
}
</style>