<!-- .vitepress/theme/BreakGames.vue -->
<script setup>
import { ref, onMounted, onUnmounted, reactive } from 'vue'

const currentTab = ref('muyu') // 'muyu' | 'snake' | '2048'

// ==========================================
// 1. 赛博木鱼 (Cyber Muyu)
// ==========================================
const muyuCount = ref(0)
const floatingTexts = ref([])
const isAutoMuyu = ref(false)
let autoMuyuTimer = null

const blessings = [
  '功德 +1',
  '烦恼 -1',
  '头发 +1',
  '绩点 +4.5',
  '代码零 Bug',
  '心如明镜',
  '万事顺意',
  '灵感爆发',
  '不挂科 +1',
  '心情晴朗'
]

// 使用 Web Audio API 合成真实木鱼木槌打击声（无需外链音频，零延迟）
const playMuyuSound = () => {
  if (typeof window === 'undefined') return
  try {
    const AudioCtx = window.AudioContext || window.webkitAudioContext
    if (!AudioCtx) return
    const ctx = new AudioCtx()
    const osc = ctx.createOscillator()
    const gain = ctx.createGain()
    
    osc.type = 'sine'
    osc.frequency.setValueAtTime(680, ctx.currentTime)
    osc.frequency.exponentialRampToValueAtTime(80, ctx.currentTime + 0.12)
    
    gain.gain.setValueAtTime(0.7, ctx.currentTime)
    gain.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.12)
    
    osc.connect(gain)
    gain.connect(ctx.destination)
    
    osc.start()
    osc.stop(ctx.currentTime + 0.12)
  } catch (e) {
    // ignore
  }
}

const tapMuyu = () => {
  muyuCount.value++
  playMuyuSound()
  
  const text = blessings[Math.floor(Math.random() * blessings.length)]
  const id = Date.now() + Math.random()
  const offset = (Math.random() - 0.5) * 60
  
  floatingTexts.value.push({ id, text, offset })
  setTimeout(() => {
    floatingTexts.value = floatingTexts.value.filter(item => item.id !== id)
  }, 1000)
}

const toggleAutoMuyu = () => {
  isAutoMuyu.value = !isAutoMuyu.value
  if (isAutoMuyu.value) {
    autoMuyuTimer = setInterval(tapMuyu, 600)
  } else {
    clearInterval(autoMuyuTimer)
  }
}

// ==========================================
// 2. 经典贪吃蛇 (Retro Snake)
// ==========================================
const snakeCanvas = ref(null)
let snakeCtx = null
const snakeScore = ref(0)
const snakeHighScore = ref(0)
const isSnakeRunning = ref(false)
const isSnakeGameOver = ref(false)

const gridSize = 16
const tileCount = 18
let snake = [{ x: 9, y: 9 }]
let food = { x: 5, y: 5 }
let dx = 1
let dy = 0
let snakeInterval = null

const resetSnake = () => {
  snake = [{ x: 9, y: 9 }]
  dx = 1
  dy = 0
  snakeScore.value = 0
  isSnakeGameOver.value = false
  spawnFood()
}

const spawnFood = () => {
  food = {
    x: Math.floor(Math.random() * tileCount),
    y: Math.floor(Math.random() * tileCount)
  }
  for (let part of snake) {
    if (part.x === food.x && part.y === food.y) spawnFood()
  }
}

const startSnake = () => {
  resetSnake()
  isSnakeRunning.value = true
  clearInterval(snakeInterval)
  snakeInterval = setInterval(gameLoopSnake, 120)
}

const pauseSnake = () => {
  isSnakeRunning.value = false
  clearInterval(snakeInterval)
}

const setDirection = (newDx, newDy) => {
  if (dx === -newDx && dx !== 0) return
  if (dy === -newDy && dy !== 0) return
  dx = newDx
  dy = newDy
}

const gameLoopSnake = () => {
  if (!snakeCanvas.value) return
  snakeCtx = snakeCanvas.value.getContext('2d')
  
  const head = { x: snake[0].x + dx, y: snake[0].y + dy }
  
  // 撞墙判定
  if (head.x < 0 || head.x >= tileCount || head.y < 0 || head.y >= tileCount) {
    gameOverSnake()
    return
  }
  // 撞自身判定
  for (let part of snake) {
    if (head.x === part.x && head.y === part.y) {
      gameOverSnake()
      return
    }
  }
  
  snake.unshift(head)
  
  // 吃食物
  if (head.x === food.x && head.y === food.y) {
    snakeScore.value += 10
    if (snakeScore.value > snakeHighScore.value) {
      snakeHighScore.value = snakeScore.value
    }
    spawnFood()
  } else {
    snake.pop()
  }
  
  drawSnake()
}

const drawSnake = () => {
  if (!snakeCtx) return
  // 清屏
  snakeCtx.fillStyle = '#faf6f0'
  snakeCtx.fillRect(0, 0, tileCount * gridSize, tileCount * gridSize)
  
  // 绘制网格背景微线
  snakeCtx.strokeStyle = 'rgba(230, 215, 205, 0.4)'
  snakeCtx.lineWidth = 0.5
  for (let i = 0; i <= tileCount; i++) {
    snakeCtx.beginPath()
    snakeCtx.moveTo(i * gridSize, 0)
    snakeCtx.lineTo(i * gridSize, tileCount * gridSize)
    snakeCtx.stroke()
    snakeCtx.beginPath()
    snakeCtx.moveTo(0, i * gridSize)
    snakeCtx.lineTo(tileCount * gridSize, i * gridSize)
    snakeCtx.stroke()
  }
  
  // 绘制食物
  snakeCtx.fillStyle = '#cf6e57'
  snakeCtx.beginPath()
  snakeCtx.arc(
    food.x * gridSize + gridSize / 2,
    food.y * gridSize + gridSize / 2,
    gridSize / 2 - 2,
    0,
    Math.PI * 2
  )
  snakeCtx.fill()
  
  // 绘制蛇身
  snake.forEach((part, index) => {
    snakeCtx.fillStyle = index === 0 ? '#963d28' : '#b85b44'
    snakeCtx.beginPath()
    snakeCtx.roundRect(
      part.x * gridSize + 1,
      part.y * gridSize + 1,
      gridSize - 2,
      gridSize - 2,
      4
    )
    snakeCtx.fill()
  })
}

const gameOverSnake = () => {
  isSnakeRunning.value = false
  isSnakeGameOver.value = true
  clearInterval(snakeInterval)
}

// ==========================================
// 3. 2048 消除解压 (2048 Puzzle)
// ==========================================
const board2048 = ref([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])
const score2048 = ref(0)
const isWon2048 = ref(false)

const init2048 = () => {
  board2048.value = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ]
  score2048.value = 0
  isWon2048.value = false
  addRandomTile()
  addRandomTile()
}

const addRandomTile = () => {
  const empty = []
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 4; c++) {
      if (board2048.value[r][c] === 0) empty.push({ r, c })
    }
  }
  if (empty.length === 0) return
  const { r, c } = empty[Math.floor(Math.random() * empty.length)]
  board2048.value[r][c] = Math.random() < 0.9 ? 2 : 4
}

const slide = (row) => {
  let arr = row.filter(val => val !== 0)
  for (let i = 0; i < arr.length - 1; i++) {
    if (arr[i] === arr[i + 1]) {
      arr[i] *= 2
      score2048.value += arr[i]
      if (arr[i] === 2048) isWon2048.value = true
      arr[i + 1] = 0
    }
  }
  arr = arr.filter(val => val !== 0)
  while (arr.length < 4) arr.push(0)
  return arr
}

const moveLeft = () => {
  let moved = false
  const next = []
  for (let r = 0; r < 4; r++) {
    const newRow = slide(board2048.value[r])
    if (newRow.join(',') !== board2048.value[r].join(',')) moved = true
    next.push(newRow)
  }
  if (moved) {
    board2048.value = next
    addRandomTile()
  }
}

const moveRight = () => {
  let moved = false
  const next = []
  for (let r = 0; r < 4; r++) {
    const reversed = [...board2048.value[r]].reverse()
    const newRow = slide(reversed).reverse()
    if (newRow.join(',') !== board2048.value[r].join(',')) moved = true
    next.push(newRow)
  }
  if (moved) {
    board2048.value = next
    addRandomTile()
  }
}

const moveUp = () => {
  let moved = false
  const next = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ]
  for (let c = 0; c < 4; c++) {
    let col = [board2048.value[0][c], board2048.value[1][c], board2048.value[2][c], board2048.value[3][c]]
    const newCol = slide(col)
    for (let r = 0; r < 4; r++) {
      if (next[r][c] !== newCol[r]) {
        if (board2048.value[r][c] !== newCol[r]) moved = true
      }
      next[r][c] = newCol[r]
    }
  }
  if (moved) {
    board2048.value = next
    addRandomTile()
  }
}

const moveDown = () => {
  let moved = false
  const next = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ]
  for (let c = 0; c < 4; c++) {
    let col = [board2048.value[3][c], board2048.value[2][c], board2048.value[1][c], board2048.value[0][c]]
    const newCol = slide(col).reverse()
    for (let r = 0; r < 4; r++) {
      if (board2048.value[r][c] !== newCol[r]) moved = true
      next[r][c] = newCol[r]
    }
  }
  if (moved) {
    board2048.value = next
    addRandomTile()
  }
}

// 颜色映射
const getTileColor = (val) => {
  const colors = {
    2: '#eee4da',
    4: '#ede0c8',
    8: '#f2b179',
    16: '#f59563',
    32: '#f67c5f',
    64: '#f65e3b',
    128: '#edcf72',
    256: '#edcc61',
    512: '#edc850',
    1024: '#edc53f',
    2048: '#b85b44'
  }
  return colors[val] || '#cdc1b4'
}

// 全局按键监听
const handleKeyDown = (e) => {
  if (currentTab.value === 'snake') {
    if (['ArrowUp', 'KeyW'].includes(e.code)) { setDirection(0, -1); e.preventDefault() }
    if (['ArrowDown', 'KeyS'].includes(e.code)) { setDirection(0, 1); e.preventDefault() }
    if (['ArrowLeft', 'KeyA'].includes(e.code)) { setDirection(-1, 0); e.preventDefault() }
    if (['ArrowRight', 'KeyD'].includes(e.code)) { setDirection(1, 0); e.preventDefault() }
  } else if (currentTab.value === '2048') {
    if (['ArrowUp', 'KeyW'].includes(e.code)) { moveUp(); e.preventDefault() }
    if (['ArrowDown', 'KeyS'].includes(e.code)) { moveDown(); e.preventDefault() }
    if (['ArrowLeft', 'KeyA'].includes(e.code)) { moveLeft(); e.preventDefault() }
    if (['ArrowRight', 'KeyD'].includes(e.code)) { moveRight(); e.preventDefault() }
  }
}

onMounted(() => {
  window.addEventListener('keydown', handleKeyDown)
  init2048()
  setTimeout(() => {
    if (snakeCanvas.value) drawSnake()
  }, 100)
})

onUnmounted(() => {
  window.removeEventListener('keydown', handleKeyDown)
  if (autoMuyuTimer) clearInterval(autoMuyuTimer)
  if (snakeInterval) clearInterval(snakeInterval)
})
</script>

<template>
  <div class="break-games-card">
    <div class="games-header">
      <div class="games-title">
        <span class="icon">🎮</span> 摸鱼放松小站 · Break Arcade
      </div>
      <div class="games-tabs">
        <button
          type="button"
          :class="['tab-btn', { active: currentTab === 'muyu' }]"
          @click="currentTab = 'muyu'"
        >
          🪷 赛博木鱼
        </button>
        <button
          type="button"
          :class="['tab-btn', { active: currentTab === 'snake' }]"
          @click="currentTab = 'snake'; setTimeout(() => drawSnake(), 50)"
        >
          🐍 极客贪吃蛇
        </button>
        <button
          type="button"
          :class="['tab-btn', { active: currentTab === '2048' }]"
          @click="currentTab = '2048'"
        >
          🎲 2048
        </button>
      </div>
    </div>

    <!-- 1. 赛博木鱼 -->
    <div v-show="currentTab === 'muyu'" class="game-view muyu-view">
      <div class="muyu-counter">
        累计功德：<span class="count-num">{{ muyuCount }}</span>
      </div>
      <div class="muyu-stage" @click="tapMuyu">
        <div class="muyu-woodblock">
          <svg viewBox="0 0 100 100" class="muyu-svg">
            <path
              d="M50 15 C25 15, 10 35, 10 60 C10 82, 30 88, 50 88 C70 88, 90 82, 90 60 C90 35, 75 15, 50 15 Z"
              fill="#b85b44"
            />
            <path
              d="M30 65 Q50 80, 70 65"
              stroke="#fcf9f2"
              stroke-width="5"
              stroke-linecap="round"
              fill="none"
            />
            <circle cx="50" cy="40" r="7" fill="#fcf9f2" />
          </svg>
        </div>

        <!-- 悬浮功德文字 -->
        <transition-group name="float-up">
          <div
            v-for="item in floatingTexts"
            :key="item.id"
            class="floating-badge"
            :style="{ left: `calc(50% + ${item.offset}px)` }"
          >
            {{ item.text }}
          </div>
        </transition-group>
      </div>

      <div class="muyu-actions">
        <button type="button" class="action-pill" @click="tapMuyu">
          敲击一次 咚 ~
        </button>
        <button
          type="button"
          :class="['action-pill', 'alt', { active: isAutoMuyu }]"
          @click="toggleAutoMuyu"
        >
          {{ isAutoMuyu ? '⏹ 停止自动敲击' : '⚡ 自动敲击' }}
        </button>
      </div>
      <div class="muyu-tip">点击木鱼敲响清音，积攒功德，消除学习压力 ✦</div>
    </div>

    <!-- 2. 贪吃蛇 -->
    <div v-show="currentTab === 'snake'" class="game-view snake-view">
      <div class="game-stats">
        <span>当前得分：<strong>{{ snakeScore }}</strong></span>
        <span>最高纪录：<strong>{{ snakeHighScore }}</strong></span>
      </div>
      <div class="canvas-wrap">
        <canvas
          ref="snakeCanvas"
          :width="tileCount * gridSize"
          :height="tileCount * gridSize"
          class="snake-canvas"
        ></canvas>
        <div v-if="isSnakeGameOver" class="game-overlay">
          <div class="over-text">游戏结束 喵~</div>
          <button type="button" class="action-pill" @click="startSnake">再来一局</button>
        </div>
      </div>
      <div class="snake-ctrls">
        <button v-if="!isSnakeRunning" type="button" class="action-pill" @click="startSnake">
          开始游戏 🐍
        </button>
        <button v-else type="button" class="action-pill alt" @click="pauseSnake">
          暂停游戏 ⏸
        </button>
      </div>
      <!-- 触屏/按键控制轮盘 -->
      <div class="touch-pad">
        <button type="button" class="pad-btn up" @click="setDirection(0, -1)">▲</button>
        <div class="pad-row">
          <button type="button" class="pad-btn left" @click="setDirection(-1, 0)">◀</button>
          <button type="button" class="pad-btn down" @click="setDirection(0, 1)">▼</button>
          <button type="button" class="pad-btn right" @click="setDirection(1, 0)">▶</button>
        </div>
      </div>
      <div class="muyu-tip">支持键盘 WASD / 方向键控制</div>
    </div>

    <!-- 3. 2048 -->
    <div v-show="currentTab === '2048'" class="game-view game-2048-view">
      <div class="game-stats">
        <span>得分：<strong>{{ score2048 }}</strong></span>
        <button type="button" class="mini-btn" @click="init2048">重新开始</button>
      </div>
      <div class="board-2048">
        <div v-for="(row, r) in board2048" :key="r" class="row-2048">
          <div
            v-for="(val, c) in row"
            :key="c"
            class="cell-2048"
            :style="{
              backgroundColor: getTileColor(val),
              color: val > 4 ? '#f9f6f2' : '#776e65'
            }"
          >
            {{ val > 0 ? val : '' }}
          </div>
        </div>
      </div>
      <div class="touch-pad">
        <button type="button" class="pad-btn up" @click="moveUp">▲</button>
        <div class="pad-row">
          <button type="button" class="pad-btn left" @click="moveLeft">◀</button>
          <button type="button" class="pad-btn down" @click="moveDown">▼</button>
          <button type="button" class="pad-btn right" @click="moveRight">▶</button>
        </div>
      </div>
      <div class="muyu-tip">支持方向键滑动合并相同数字，冲刺 2048！</div>
    </div>
  </div>
</template>

<style scoped>
.break-games-card {
  margin: 2.2rem 0 3rem;
  padding: 24px 26px;
  background: linear-gradient(145deg, rgba(255, 255, 255, 0.95) 0%, rgba(253, 248, 241, 0.88) 100%);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(184, 91, 68, 0.16);
  border-radius: 24px;
  box-shadow: 0 12px 36px -6px rgba(184, 91, 68, 0.1), 0 2px 8px rgba(0, 0, 0, 0.02);
  transition: all 0.3s ease;
}

.break-games-card:hover {
  box-shadow: 0 16px 42px -6px rgba(184, 91, 68, 0.14);
  border-color: rgba(184, 91, 68, 0.28);
}

.games-header {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
  gap: 14px;
  padding-bottom: 18px;
  border-bottom: 1px solid rgba(184, 91, 68, 0.1);
}

.games-title {
  font-size: 1.18rem;
  font-weight: 700;
  color: #2b1f1c;
  display: flex;
  align-items: center;
  gap: 10px;
}

.games-tabs {
  display: flex;
  background: rgba(184, 91, 68, 0.07);
  padding: 4px;
  border-radius: 999px;
  gap: 4px;
  border: 1px solid rgba(184, 91, 68, 0.08);
}

.tab-btn {
  padding: 6px 16px;
  border-radius: 999px;
  border: none;
  background: transparent;
  color: #63554e;
  font-size: 0.88rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

.tab-btn:hover {
  color: #b85b44;
}

.tab-btn.active {
  background: #ffffff;
  color: #b85b44;
  font-weight: 700;
  box-shadow: 0 2px 10px rgba(184, 91, 68, 0.15), 0 1px 3px rgba(0, 0, 0, 0.04);
}

.game-view {
  padding: 24px 10px 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* 木鱼视图 */
.muyu-counter {
  font-size: 1.05rem;
  color: #63554e;
  margin-bottom: 20px;
}

.muyu-counter .count-num {
  font-size: 1.5rem;
  font-weight: bold;
  color: #b85b44;
}

.muyu-stage {
  position: relative;
  width: 140px;
  height: 140px;
  margin: 10px 0 24px;
  cursor: pointer;
  user-select: none;
}

.muyu-woodblock {
  width: 100%;
  height: 100%;
  transition: transform 0.1s ease;
  filter: drop-shadow(0 10px 18px rgba(184, 91, 68, 0.2));
}

.muyu-stage:active .muyu-woodblock {
  transform: scale(0.92);
}

.floating-badge {
  position: absolute;
  top: 10px;
  transform: translateX(-50%);
  color: #b85b44;
  font-weight: bold;
  font-size: 1.1rem;
  pointer-events: none;
  white-space: nowrap;
  animation: floatUp 0.9s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
}

@keyframes floatUp {
  0% { opacity: 0; transform: translate(-50%, 0) scale(0.8); }
  30% { opacity: 1; transform: translate(-50%, -20px) scale(1.1); }
  100% { opacity: 0; transform: translate(-50%, -60px) scale(1); }
}

.muyu-actions {
  display: flex;
  gap: 12px;
}

.action-pill {
  padding: 8px 22px;
  background: #b85b44;
  color: #ffffff;
  border: none;
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: all 0.25s ease;
  box-shadow: 0 4px 12px rgba(184, 91, 68, 0.2);
}

.action-pill:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(184, 91, 68, 0.3);
}

.action-pill.alt {
  background: #ffffff;
  color: #b85b44;
  border: 1px solid #b85b44;
}

.action-pill.alt.active {
  background: #963d28;
  color: #ffffff;
  border-color: #963d28;
}

.muyu-tip {
  font-size: 0.85rem;
  color: #95847d;
  margin-top: 16px;
}

/* 贪吃蛇视图 */
.game-stats {
  display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 290px;
  margin-bottom: 12px;
  font-size: 0.95rem;
  color: #63554e;
}

.canvas-wrap {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 14px rgba(184, 91, 68, 0.1);
  border: 2px solid #ebdcd2;
}

.snake-canvas {
  display: block;
}

.game-overlay {
  position: absolute;
  inset: 0;
  background: rgba(252, 249, 242, 0.88);
  backdrop-filter: blur(4px);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
}

.over-text {
  font-size: 1.2rem;
  font-weight: bold;
  color: #963d28;
}

.snake-ctrls {
  margin-top: 14px;
}

/* 触屏轮盘 */
.touch-pad {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  margin-top: 16px;
}

.pad-row {
  display: flex;
  gap: 6px;
}

.pad-btn {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  border: 1px solid #ebdcd2;
  background: #ffffff;
  color: #63554e;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.04);
}

.pad-btn:active {
  background: #f4ecdf;
  transform: scale(0.95);
}

/* 2048 视图 */
.mini-btn {
  padding: 2px 10px;
  font-size: 0.85rem;
  border-radius: 6px;
  border: 1px solid #ebdcd2;
  background: #ffffff;
  color: #b85b44;
  cursor: pointer;
}

.board-2048 {
  width: 288px;
  height: 288px;
  background: #f4ecdf;
  border-radius: 12px;
  padding: 8px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  box-sizing: border-box;
}

.row-2048 {
  display: flex;
  gap: 8px;
  flex: 1;
}

.cell-2048 {
  flex: 1;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 1.35rem;
  user-select: none;
  transition: all 0.15s ease;
}
</style>
