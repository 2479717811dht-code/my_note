<!-- 文件路径：.vitepress/theme/MusicToggle.vue -->
<script setup>
import { ref, onMounted } from 'vue'

const isPlaying = ref(false)
const audioRef = ref(null)

const toggleMusic = () => {
  if (isPlaying.value) {
    audioRef.value.pause()
  } else {
    audioRef.value.play()
  }
  isPlaying.value = !isPlaying.value
}
</script>

<template>
  <div class="music-toggle" @click="toggleMusic" title="播放/暂停音乐">
    <!-- 没播放时显示：播放图标 -->
    <svg v-if="!isPlaying" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
      <path d="M8 5v14l11-7z"/>
    </svg>
    <!-- 播放时显示：暂停图标 -->
    <svg v-else xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
      <path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/>
    </svg>

    <!-- 这里的 loop 就是单曲循环！ -->
    <audio ref="audioRef" src="/song.mp3" loop></audio>
  </div>
</template>

<style scoped>
/* 按钮的样式，完美契合你的暖陶主题 */
.music-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  cursor: pointer;
  color: #b85b44;
  border-radius: 50%;
  transition: all 0.3s ease;
  margin-left: 12px;
}
.music-toggle:hover {
  background-color: rgba(184, 91, 68, 0.15);
  transform: scale(1.1);
}
</style>