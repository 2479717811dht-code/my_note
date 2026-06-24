import { defineConfig } from 'vitepress'
import { withMermaid } from 'vitepress-plugin-mermaid'

import { tasklist } from '@mdit/plugin-tasklist'
import { footnote } from '@mdit/plugin-footnote'
import { sub } from '@mdit/plugin-sub'
import { sup } from '@mdit/plugin-sup'
import { mark } from '@mdit/plugin-mark'

console.log('>>> 当前 VitePress 配置已加载 <<<')

// 让 Typora 的 [toc] 在 VitePress 中自动变成 [[toc]]
const typoraTocCompat = {
  name: 'typora-toc-compat',
  enforce: 'pre' as const,

  transform(code: string, id: string) {
    if (!id.endsWith('.md')) return

    const result = code.replace(
      /^[ \t]*\[toc\][ \t]*$/gim,
      '[[toc]]'
    )

    if (result === code) return

    return {
      code: result,
      map: null
    }
  }
}

export default withMermaid(
  defineConfig({
    base: '/my_note/',

    lang: 'zh-CN',

    title: 'My Note',
    description: '我的数字花园',

    // 开启深色 / 浅色模式切换
    appearance: true,

    // 读取 Git 提交时间，显示文章最后更新时间
    lastUpdated: true,

    markdown: {
      // 所有代码块默认显示行号
      lineNumbers: true,

      // 数学公式：$...$ 和 $$...$$
      math: true,

      // 图片进入视口时再加载
      image: {
        lazyLoading: true
      },

      // Typora 常用 Markdown 扩展
      config: (md) => {
        md.use(tasklist) // - [ ] / - [x]
        md.use(footnote) // [^1]
        md.use(sub) // H~2~O
        md.use(sup) // x^2^
        md.use(mark) // ==高亮==
      }
    },

    mermaid: {
      startOnLoad: false,
      flowchart: {
        htmlLabels: true
      }
    },

    vite: {
      plugins: [typoraTocCompat]
    },

    themeConfig: {
      logo: '/20260323101521_872_96.png',

      siteTitle: 'My Note',

      // 右侧目录：显示 h2 到 h6
      outline: {
        level: 'deep',
        label: '本页目录'
      },

      nav: [
        {
          text: '首页',
          link: '/'
        },
        {
          text: '课程',
          items: [
            {
              text: '计科专业理论课',
              link: '/theory'
            },
            {
              text: '实验课内容及实验报告',
              link: '/lab'
            },
          // items: [
          //   {
          //     text: '课程总览',
          //     link: '/logic'
          //   },
          //   {
          //     text: 'Fundamentals of Programming and Algorithms',
          //     link: '/note-cs-code-cleaned'
          //   },
          //   {
          //     text: 'Digital Logic Design',
          //     link: '/dldnote'
          //   },
          //   {
          //     text: 'Fundamentals of Data Structure',
          //     link: '/Fundamentals_of_Data_Structure'
          //   },
          //   {
          //     text: 'Discrete Mathematics',
          //     link: '/Discrete_Mathematics'
          //   },
          //   {
          //     text: 'Computer Organization',
          //     link: '/Computer_Organization'
          //   },
          //   {
          //     text: 'Advanced Data Structure & Algorithm Analysis',
          //     link: '/Advanced_Data_Structure_Algorithm_Analysis'
          //   }
          ]
        },
        {
          text: '休息一下',
          link: '/break'
        }
      ],

      socialLinks: [
        {
          icon: 'github',
          link: 'https://github.com/2479717811dht-code',
          ariaLabel: 'GitHub'
        }
      ],

      sidebar: [
        {
          text: '开始阅读',
          collapsed: false,
          items: [
            {
              text: '课程总览',
              link: '/logic'
            }
          ]
        },
        {
          text: '理论课',
          collapsed: false,
          items: [
            {
              text: 'Read Me',
              link: '/theory'
            },
            {
              text: 'Fundamentals of Programming and Algorithms',
              link: '/note-cs-code-cleaned'
            },
            {
              text: 'Digital Logic Design',
              link: '/dldnote'
            },
            {
              text: 'Fundamentals of Data Structure',
              link: '/Fundamentals_of_Data_Structure'
            },
            {
              text: 'Discrete Mathematics',
              link: '/Discrete_Mathematics'
            },
            {
              text: 'Computer Organization',
              link: '/Computer_Organization'
            },
            {
              text: 'Advanced Data Structure & Algorithm Analysis',
              link: '/Advanced_Data_Structure_Algorithm_Analysis'
            }
          ]
        },
        {
          text: '实验课',
          collapsed: false,
          items: [
            // {
            //   text: 'Fundamentals of Programming and Algorithms',
            //   link: '/note-cs-code-cleaned'
            // },
            {
              text: 'Read Me',
              link: '/lab'
            },
            {
              text: 'Digital Logic Design',
              link: '/Digital-Logic-Design-Lab'
            },
            // {
            //   text: 'Fundamentals of Data Structure',
            //   link: '/Fundamentals_of_Data_Structure'
            // },
            // {
            //   text: 'Discrete Mathematics',
            //   link: '/Discrete_Mathematics'
            // },
            {
              text: 'Computer Organization',
              link: '/Computer-Organization-Lab'
            }
            // {
            //   text: 'Advanced Data Structure & Algorithm Analysis',
            //   link: '/Advanced_Data_Structure_Algorithm_Analysis'
            // }
          ]
        },
        {
          text: '休息一下',
          collapsed: true,
          items: [
            {
              text: 'Read Me',
              link: '/break'
            },            
            {
              text: '喝杯下午茶',
              link: '/relax'
            },
            {
              text: '氵亿会儿98',
              link: '/cc98web'
            },
            {
              text: '看一下比赛',
              link: '/basketball'
            }
          ]
        }
      ],

      search: {
        provider: 'local',
        options: {
          locales: {
            root: {
              translations: {
                button: {
                  buttonText: '搜索',
                  buttonAriaLabel: '搜索'
                },
                modal: {
                  displayDetails: '显示详细列表',
                  resetButtonTitle: '重置搜索',
                  backButtonTitle: '关闭搜索',
                  noResultsText: '没有找到相关内容',
                  footer: {
                    selectText: '选择',
                    selectKeyAriaLabel: '回车',
                    navigateText: '切换',
                    navigateUpKeyAriaLabel: '向上箭头',
                    navigateDownKeyAriaLabel: '向下箭头',
                    closeText: '关闭',
                    closeKeyAriaLabel: 'Esc'
                  }
                }
              }
            }
          }
        }
      },

      docFooter: {
        prev: '上一篇',
        next: '下一篇'
      },

      lastUpdated: {
        text: '最后更新于'
      },

      darkModeSwitchLabel: '外观',
      lightModeSwitchTitle: '切换为浅色模式',
      darkModeSwitchTitle: '切换为深色模式',
      sidebarMenuLabel: '课程目录',
      returnToTopLabel: '返回顶部',
      skipToContentLabel: '跳到正文',

      footer: {
        message: 'Built with VitePress · My Digital Garden',
        copyright: 'Copyright © 2026 H.T.Deng'
      }
    }
  })
)