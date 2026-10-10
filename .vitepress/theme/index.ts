import DefaultTheme from 'vitepress/theme'
import { h } from 'vue'
import MusicToggle from './MusicToggle.vue'
import BreakGames from './BreakGames.vue'
import CourseMatrix from './CourseMatrix.vue'
import AsideOutlineTracker from './AsideOutlineTracker.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      'nav-bar-content-after': () => h(MusicToggle),
      'aside-top': () => h(AsideOutlineTracker)
    })
  },
  enhanceApp({ app }) {
    app.component('BreakGames', BreakGames)
    app.component('CourseMatrix', CourseMatrix)
  }
}