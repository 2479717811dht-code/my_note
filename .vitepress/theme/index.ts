import DefaultTheme from 'vitepress/theme'
import { h } from 'vue' // 👉 新增：引入 Vue 的渲染函数
import MusicToggle from './MusicToggle.vue' // 👉 新增：引入刚才写好的音乐按钮
import './custom.css'

export default {
  extends: DefaultTheme, // 继承默认主题
  
  // 👉 核心操作：重写布局，把音乐按钮塞进右上角插槽
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      'nav-bar-content-after': () => h(MusicToggle)
    })
  }
}