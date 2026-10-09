import DefaultTheme from 'vitepress/theme'
import { h } from 'vue'
import MusicToggle from './MusicToggle.vue'
import BreakGames from './BreakGames.vue'
import CourseMatrix from './CourseMatrix.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      'nav-bar-content-after': () => h(MusicToggle)
    })
  },
  enhanceApp({ app }) {
    app.component('BreakGames', BreakGames)
    app.component('CourseMatrix', CourseMatrix)
  }
}