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

    // 允许代码文件引用（如 .c, .tex, .ppt 等静态非 html 源码文件链接）
    ignoreDeadLinks: true,

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

    head: [
    ['link', { rel: 'icon', href: '/my_note/link.png' }] 
    // 如果你准备了 .ico 格式，就写 '/favicon.ico'
    ],

    themeConfig: {
      logo: '/20260323101521_872_96.png',

      siteTitle: 'My Note',

      // 右侧目录：显示 h2 到 h6
      outline: {
        level: 'deep',
        label: '本页大纲 · 导航追踪'
      },

      nav: [
        {
          text: '首页',
          link: '/'
        },
        {
          text: '理论课程',
          items: [
            { text: '理论课全景导读', link: '/Theory/theory' },
            { text: '计科核心专业课', link: '/Theory/Fundamentals_of_Data_Structure' },
            { text: '数理基石与物理', link: '/Theory/Probability_and_Mathematical_Statistics' },
            { text: '编程与算法实战', link: '/Theory/Algorithms_Practice' },
            { text: '通识人文与思政', link: '/Theory/Marxism' }
          ]
        },
        {
          text: '实验与大作业',
          items: [
            { text: '实验总览导读', link: '/Lab/lab' },
            { text: '数字逻辑设计实验 (DLD)', link: '/Lab/Digital-Logic-Design-Lab' },
            { text: '计算机组成体系实验 (CO)', link: '/Lab/Computer-Organization-Lab' },
            { text: '普通物理学实验集 (PHY)', link: '/Lab/Physics-Lab' }
          ]
        },
        {
          text: '知识图谱',
          link: '/Cover/logic'
        },
        {
          text: '休息一下',
          link: '/Break/break'
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
              text: '知识图谱与选课逻辑',
              link: '/Cover/logic'
            }
          ]
        },
        {
          text: '理论课 · Theory Notes',
          collapsed: false,
          items: [
            {
              text: 'Read Me · 理论课总览',
              link: '/Theory/theory'
            },
            {
              text: '💻 计科核心专业课',
              collapsed: false,
              items: [
                {
                  text: 'Fundamentals of Programming (FPA)',
                  link: '/Theory/note-cs-code-cleaned'
                },
                {
                  text: 'Fundamentals of Data Structure (FDS)',
                  link: '/Theory/Fundamentals_of_Data_Structure'
                },
                {
                  text: 'Advanced Data Structure (ADS)',
                  link: '/Theory/Advanced_Data_Structure_Algorithm_Analysis'
                },
                {
                  text: 'Computer Organization (CO)',
                  link: '/Theory/Computer_Organization'
                },
                {
                  text: 'CO · 期中备考全景手册与速查卡 🚀',
                  link: '/Theory/Computer_Organization_Midterm'
                },
                {
                  text: 'Digital Logic Design (DLD)',
                  link: '/Theory/dldnote'
                }
              ]
            },
            {
              text: '📐 数理基石与工程物理',
              collapsed: false,
              items: [
                {
                  text: 'Discrete Mathematics (DM)',
                  link: '/Theory/Discrete_Mathematics'
                },
                {
                  text: 'Probability & Statistics (PMS) 🎲',
                  link: '/Theory/Probability_and_Mathematical_Statistics'
                },
                {
                  text: 'General Physics (普通物理学总览)',
                  link: '/Theory/General_Physics'
                },
                {
                  text: 'General Physics I (力热基础)',
                  link: '/Theory/General_Physics_I'
                },
                {
                  text: 'General Physics II (电磁与光学)',
                  link: '/Theory/General_Physics_II'
                },
                {
                  text: 'Mechanics (力学导论与期末复习)',
                  link: '/Theory/Mechanics'
                }
              ]
            },
            {
              text: '🛠️ 编程与算法实战',
              collapsed: true,
              items: [
                {
                  text: 'Algorithms · 经典算法刷题与模板',
                  link: '/Theory/Algorithms_Practice'
                },
                {
                  text: 'Verilog HDL · 硬件描述语言基础',
                  link: '/Theory/Verilog_HDL'
                }
              ]
            },
            {
              text: '🚩 通识人文与思政',
              collapsed: true,
              items: [
                {
                  text: '马克思主义基本原理',
                  link: '/Theory/Marxism'
                },
                {
                  text: '形势与政策 I · 背诵版复习精研',
                  link: '/Theory/Situation_and_Policy'
                }
              ]
            }
          ]
        },
        {
          text: '实验课与大作业 · Labs & Projects',
          collapsed: false,
          items: [
            {
              text: 'Read Me · 实验总览',
              link: '/Lab/lab'
            },
            {
              text: '⚡ Digital Logic Design 实验',
              collapsed: false,
              items: [
                {
                  text: 'DLD 实验与课设总览',
                  link: '/Lab/Digital-Logic-Design-Lab'
                },
                {
                  text: '🎮 期末大作业设计报告',
                  link: '/Lab/Lab_for_all/Digital_Logic_Design/projects/Degital_Logic_Design_Final_Porject/report/Report'
                },
                {
                  text: '13 次系列实验报告',
                  collapsed: true,
                  items: [
                    { text: 'Lab 1 · 电子仪器与信号测量', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/3.2/第一次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 2 · 基本开关电路', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/3.9/第二次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 3 · 集成逻辑门电路测试', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/3.16/第三次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 4 · EDA平台与环境运用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/3.23/第四次实验报告' },
                    { text: 'Lab 5 · 变量译码器设计与应用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/3.30/第五次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 6 · 7段数码管显示译码器', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/4.13/第六次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 7 · 多路选择器设计及应用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/4.20/第七次实验报告（邓欢桐、杨海涛）' },
                    { text: 'Lab 8 · 加法器设计与应用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/4.27/第八次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 9 · 锁存器与触发器基本原理', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/5.11/第九次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 10 · 同步时序电路设计', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/5.18/第十次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 11 · 寄存器及传输设计', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/5.25/第十一次实验报告-邓欢桐，杨海涛' },
                    { text: 'Lab 12 · 移位寄存器设计与应用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/6.1/第十二次实验报告-邓欢桐、杨海涛' },
                    { text: 'Lab 13 · 计数器定时器设计与应用', link: '/Lab/Lab_for_all/Digital_Logic_Design/Lab/6.8/第十三次实验报告-邓欢桐、杨海涛' }
                  ]
                }
              ]
            },
            {
              text: '🖥️ Computer Organization 实验',
              collapsed: false,
              items: [
                {
                  text: 'CO 硬件实验总览',
                  link: '/Lab/Computer-Organization-Lab'
                },
                {
                  text: 'OExp02 · IP2SOC 片上系统设计',
                  link: '/Lab/Lab_for_all/Computer_Organization/IP2SOC/README'
                }
              ]
            },
            {
              text: '🌲 数据结构基础课程设计 (FDS)',
              collapsed: true,
              items: [
                {
                  text: 'Project 1 · 检索性能评测 (Search)',
                  link: '/Lab/Lab_for_all/Fundamentals_of_Data_Structure/Project1_Search/project1'
                },
                {
                  text: 'Project 2 · 多项式与二叉堆应用',
                  link: '/Lab/Lab_for_all/Fundamentals_of_Data_Structure/Project2_Polynomial/project2'
                },
                {
                  text: 'Project 3 · 网格路由与图论最短路径',
                  link: '/Lab/Lab_for_all/Fundamentals_of_Data_Structure/Project3_Graph_Routing/report of project3'
                }
              ]
            },
            {
              text: '🚀 高级数据结构大作业 (ADS)',
              collapsed: true,
              items: [
                {
                  text: 'Project 1 · SkipList 跳表性能基准评测',
                  link: '/Lab/Lab_for_all/Advanced_Data_Structure/Project1_SkipList/README'
                },
                {
                  text: 'Project 2 · 斐波那契堆路网最短路径分析',
                  link: '/Lab/Lab_for_all/Advanced_Data_Structure/Project2_ShortestPath/report_two_heap_history'
                },
                {
                  text: 'Project 3 · 最优二叉搜索树动态规划',
                  link: '/Lab/Lab_for_all/Advanced_Data_Structure/Project3_OBST/report'
                },
                {
                  text: 'Project 4 · 最大团回溯与分支限界',
                  link: '/Lab/Lab_for_all/Advanced_Data_Structure/Project4_MaxClique/report'
                }
              ]
            },
            {
              text: '🔬 普通物理学实验集 (Physics Lab)',
              collapsed: true,
              items: [
                {
                  text: '普物实验总览与规范',
                  link: '/Lab/Physics-Lab'
                },
                {
                  text: 'Lab 01 · 碰撞实验与动量守恒',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/碰撞实验/report'
                },
                {
                  text: 'Lab 02 · 铁磁材料动态磁滞回线',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/铁磁材料的磁滞回线和基本磁化曲线/report'
                },
                {
                  text: 'Lab 03 · 万用电表的设计与校准',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/万用表的设计/report'
                },
                {
                  text: 'Lab 04 · 惠斯登单臂电桥测中值电阻',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/惠斯登电桥/report'
                },
                {
                  text: 'Lab 05 · 开尔文双臂电桥测低电阻',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/用双臂电桥测低电阻/report'
                },
                {
                  text: 'Lab 06 · 非平衡电桥原理与温度测量',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/非平衡电桥/report'
                },
                {
                  text: 'Lab 07 · 固定均匀弦振动与驻波',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/固定均匀弦振动实验/report'
                },
                {
                  text: 'Lab 08 · 拉伸法测金属丝杨氏模量',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/金属材料杨氏模量的测定/report'
                },
                {
                  text: 'Lab 09 · 模拟示波器的调节与使用',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/示波器的应用/report'
                },
                {
                  text: 'Lab 10 · 交流电路功率因数与整流滤波',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/交流电路功率因数实验、组装整流器（同时做两个实验内容）/report'
                },
                {
                  text: 'Lab 11 · 霍尔效应测亥姆霍兹磁场',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/用霍尔法测直流圆线圈与亥姆霍兹线圈磁场/report'
                },
                {
                  text: 'Lab 12 · 弗兰克-赫兹实验能级测定',
                  link: '/Lab/Lab_for_all/Physics_Lab/I/弗兰克赫兹实验/report'
                },
                {
                  text: 'Lab 13 · 北斗导航定位模拟设计',
                  link: '/Lab/Lab_for_all/Physics_Lab/II/Week_1,2-北斗导航定位模拟设计与应用/formal/formal'
                },
                {
                  text: 'Lab 14 · 国家级一流线上虚拟仿真实验',
                  link: '/Lab/Lab_for_all/Physics_Lab/II/Week_5-国家级一流本科课程线上虚拟仿真实验/report'
                }
              ]
            }
          ]
        },
        {
          text: '休息一下',
          collapsed: false,
          items: [
            {
              text: 'Read Me · 摸鱼小憩',
              link: '/Break/break'
            },
            {
              text: 'Journal 1 · 红黑树',
              link: '/Break/Journal1'
            },
            {
              text: 'Journal 2 · 大海',
              link: '/Break/Journal2'
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