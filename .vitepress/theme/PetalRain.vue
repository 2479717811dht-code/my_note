<script setup>
import { onMounted, onUnmounted } from 'vue'

let intervalId = null

onMounted(() => {
  if (typeof window === 'undefined') return

  const symbols = ['✦', '✨', '♥', '❀', '✿']
  const colors = ['#b85b44', '#cf6e57', '#d9822b', '#e29578', '#c68a4c']

  function createPetal() {
    const existing = document.querySelectorAll('.garden-falling-petal')
    if (existing.length > 18) return

    const petal = document.createElement('div')
    petal.className = 'garden-falling-petal'
    petal.innerText = symbols[Math.floor(Math.random() * symbols.length)]

    petal.style.position = 'fixed'
    petal.style.left = (Math.random() * 96 + 2) + 'vw'
    petal.style.top = '-6vh'
    petal.style.fontSize = (Math.random() * 14 + 10) + 'px'
    petal.style.zIndex = '1'
    petal.style.pointerEvents = 'none'
    petal.style.color = colors[Math.floor(Math.random() * colors.length)]
    petal.style.opacity = '0'
    petal.style.textShadow = '0 0 10px rgba(184, 91, 68, 0.3)'

    document.body.appendChild(petal)

    const duration = (Math.random() * 4 + 6) * 1000

    const animation = petal.animate([
      { transform: 'translateY(0) scale(0.6) rotate(0deg)', opacity: 0, offset: 0 },
      { opacity: 0.75, offset: 0.15 },
      { opacity: 0.6, offset: 0.8 },
      { transform: 'translateY(110vh) scale(1.1) rotate(' + (Math.random() * 360) + 'deg)', opacity: 0, offset: 1 }
    ], {
      duration: duration,
      easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)',
      fill: 'forwards'
    })

    animation.onfinish = () => {
      if (document.body.contains(petal)) {
        petal.remove()
      }
    }
  }

  intervalId = setInterval(createPetal, 850)
})

onUnmounted(() => {
  if (intervalId) {
    clearInterval(intervalId)
  }
  if (typeof document !== 'undefined') {
    document.querySelectorAll('.garden-falling-petal').forEach(el => el.remove())
  }
})
</script>

<template>
  <span style="display:none" aria-hidden="true"></span>
</template>
