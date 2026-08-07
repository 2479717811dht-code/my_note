<!-- 文件路径：.vitepress/theme/MusicToggle.vue -->
<script setup>
import { ref } from 'vue'
import { withBase } from 'vitepress' // 👉 引入 VitePress 官方的路径处理工具

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
    <!-- 播放图标 -->
    <svg v-if="!isPlaying" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
      <path d="M8 5v14l11-7z"/>
    </svg>
    <!-- 暂停图标 -->
    <svg v-else xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
      <path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/>
    </svg>

    <!-- 👉 注意看这里的 src，我们用 withBase 包裹了它，这样无论你怎么部署，它都能绝对准确地找到这首歌！ -->
    <audio ref="audioRef" :src="withBase('/song.mp3')" loop></audio>
  </div>
</template>

<style scoped>
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