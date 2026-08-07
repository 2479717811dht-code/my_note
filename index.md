---
layout: home

hero:
  name: "My Note"
  text: "MIX && CS"
  tagline: "H.T.Deng | AR15LAL"
  image:
    src: /cute.gif
    alt: "Logo"
  actions:
    - theme: brand
      text: "Start Reading"
      link: /Cover/logic
    - theme: alt
      text: "Check in GitHub"
      link: https://github.com/2479717811dht-code/my_note

features:
  - icon: "🧭"
    title: "Course Map"
    details: "课程总览，仅为内容完备性而写"
    link: /Cover/logic
    linkText: "Start Here"

  - icon: "💻"
    title: "Theory"
    details: "理论课的笔记整理，但不限计科专业课"
    link: /Theory/theory
    linkText: "Read Me"

  - icon: "🧪"
    title: "Lab"
    details: "实验课的 PPT 和一些报告（附代码）"
    link: /Lab/lab
    linkText: "Read Me"

  - icon: "☕"
    title: "Take a Break"
    details: "严肃放松一下，不是什么不可饶恕的罪过"
    link: /Break/break
    linkText: "Relax"
---

## Welcome

欢迎回来，想你了~

我只想在这样的桃花源拥有无限的治愈和温柔。

> [!NOTE]
> :sparkles:我...真的...真的...真的...好喜欢你:sparkles:

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>如果離別是為了能再見一面</title>
    <style>
        /* ===== 全局重置 ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Georgia', 'PingFang SC', 'Microsoft YaHei', serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #0a0e1a;
            overflow-x: hidden;
            padding: 20px;
        }

        /* ===== Canvas 背景粒子 ===== */
        #bgCanvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            pointer-events: none;
        }

        /* ===== 主容器 ===== */
        .container {
            position: relative;
            z-index: 1;
            max-width: 600px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px 20px 40px;
            background: rgba(10, 14, 26, 0.65);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 40px;
            border: 1px solid rgba(255, 255, 255, 0.06);
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.7), inset 0 1px 0 rgba(255, 255, 255, 0.04);
        }

        /* ===== 歌名 ===== */
        .song-title {
            font-size: 20px;
            font-weight: 300;
            letter-spacing: 6px;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 18px;
            text-shadow: 0 0 30px rgba(240, 192, 96, 0.08);
        }
        .song-title span {
            color: rgba(240, 192, 96, 0.5);
            font-weight: 400;
        }

        /* ===== 圖片包裝 ===== */
        .image-wrapper {
            display: flex;
            justify-content: center;
            margin: 0 0 28px 0;
            position: relative;
        }

        .image-wrapper::before {
            content: '';
            position: absolute;
            inset: -12px;
            border-radius: 28px;
            background: radial-gradient(circle at 30% 30%, rgba(240, 192, 96, 0.15), transparent 70%);
            filter: blur(20px);
            animation: glowPulse 4s ease-in-out infinite alternate;
            z-index: -1;
        }

        @keyframes glowPulse {
            0% {
                opacity: 0.5;
                transform: scale(0.95);
            }
            100% {
                opacity: 1;
                transform: scale(1.05);
            }
        }

        .image-wrapper img {
            border-radius: 20px;
            box-shadow:
                0 12px 40px rgba(0, 0, 0, 0.6),
                0 0 60px rgba(240, 192, 96, 0.06);
            max-width: 90%;
            width: 420px;
            height: auto;
            display: block;
            transition: transform 0.6s cubic-bezier(0.23, 1, 0.32, 1), box-shadow 0.6s ease;
            border: 1px solid rgba(255, 255, 255, 0.04);
        }

        .image-wrapper img:hover {
            transform: scale(1.01);
            box-shadow:
                0 20px 60px rgba(0, 0, 0, 0.7),
                0 0 80px rgba(240, 192, 96, 0.10);
        }

        /* ===== 歌詞容器 ===== */
        .lyrics-wrapper {
            width: 100%;
            position: relative;
            margin: 6px 0 16px 0;
        }

        .lyrics-container {
            height: 300px;
            overflow-y: auto;
            overflow-x: hidden;
            scroll-behavior: smooth;
            padding: 10px 0;
            mask-image: linear-gradient(to bottom, transparent 0%, black 15%, black 85%, transparent 100%);
            -webkit-mask-image: linear-gradient(to bottom, transparent 0%, black 15%, black 85%, transparent 100%);
            scrollbar-width: none;
        }
        .lyrics-container::-webkit-scrollbar {
            display: none;
        }

        .lyrics-list {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 0;
            gap: 4px;
        }

        /* ===== 每一行歌詞 ===== */
        .lyric-line {
            font-size: 18px;
            line-height: 2.2;
            color: rgba(255, 255, 255, 0.25);
            text-align: center;
            padding: 2px 16px;
            border-radius: 8px;
            transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
            letter-spacing: 1.2px;
            white-space: pre-wrap;
            word-break: break-word;
            width: 100%;
            max-width: 520px;
            font-weight: 300;
            cursor: default;
            user-select: none;
        }

        .lyric-line.active {
            color: #f0c060;
            font-size: 24px;
            font-weight: 600;
            text-shadow: 0 0 30px rgba(240, 192, 96, 0.25), 0 0 60px rgba(240, 192, 96, 0.08);
            transform: scale(1.02);
            background: rgba(240, 192, 96, 0.04);
            padding: 4px 20px;
        }

        .lyric-line.passed {
            color: rgba(255, 255, 255, 0.40);
        }

        /* ===== 進度條 ===== */
        .progress-area {
            width: 100%;
            max-width: 480px;
            display: flex;
            align-items: center;
            gap: 14px;
            margin: 4px 0 12px 0;
        }

        .progress-bar {
            flex: 1;
            height: 3px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 4px;
            overflow: hidden;
            position: relative;
            cursor: pointer;
            transition: height 0.2s ease;
        }
        .progress-bar:hover {
            height: 5px;
        }

        .progress-fill {
            height: 100%;
            width: 0%;
            border-radius: 4px;
            background: linear-gradient(90deg, rgba(240, 192, 96, 0.5), #f0c060);
            transition: width 0.3s ease;
            box-shadow: 0 0 16px rgba(240, 192, 96, 0.15);
        }

        .progress-time {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.25);
            font-variant-numeric: tabular-nums;
            letter-spacing: 0.5px;
            min-width: 44px;
            text-align: center;
        }

        /* ===== 控制按鈕 ===== */
        .controls {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-top: 6px;
        }

        .ctrl-btn {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.06);
            color: rgba(255, 255, 255, 0.5);
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(4px);
        }
        .ctrl-btn:hover {
            background: rgba(240, 192, 96, 0.10);
            border-color: rgba(240, 192, 96, 0.20);
            color: #f0c060;
            transform: scale(1.04);
            box-shadow: 0 0 30px rgba(240, 192, 96, 0.04);
        }
        .ctrl-btn:active {
            transform: scale(0.94);
        }
        .ctrl-btn .icon {
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .ctrl-btn.play-btn {
            width: 56px;
            height: 56px;
            font-size: 26px;
            background: rgba(240, 192, 96, 0.06);
            border-color: rgba(240, 192, 96, 0.12);
        }
        .ctrl-btn.play-btn:hover {
            background: rgba(240, 192, 96, 0.14);
            border-color: rgba(240, 192, 96, 0.25);
        }

        /* ===== 底部裝飾 ===== */
        .footer-note {
            margin-top: 18px;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.10);
            letter-spacing: 4px;
            font-weight: 300;
        }

        /* ===== 響應式 ===== */
        @media (max-width: 640px) {
            .container {
                padding: 20px 14px 30px;
                border-radius: 28px;
            }
            .song-title {
                font-size: 16px;
                letter-spacing: 4px;
                margin-bottom: 14px;
            }
            .image-wrapper img {
                width: 320px;
                max-width: 92%;
            }
            .lyrics-container {
                height: 240px;
            }
            .lyric-line {
                font-size: 15px;
                line-height: 2.0;
                padding: 1px 12px;
            }
            .lyric-line.active {
                font-size: 20px;
                padding: 3px 14px;
            }
            .progress-area {
                max-width: 100%;
                gap: 10px;
            }
            .ctrl-btn {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            .ctrl-btn.play-btn {
                width: 48px;
                height: 48px;
                font-size: 22px;
            }
            .footer-note {
                font-size: 10px;
            }
        }

        @media (max-width: 400px) {
            .image-wrapper img {
                width: 260px;
            }
            .lyrics-container {
                height: 200px;
            }
            .lyric-line {
                font-size: 14px;
                line-height: 1.9;
            }
            .lyric-line.active {
                font-size: 18px;
            }
        }

        /* ===== 歌詞載入動畫 ===== */
        .lyric-line {
            opacity: 0;
            animation: fadeInUp 0.5s ease forwards;
        }
        .lyric-line.active {
            animation: none;
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(8px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 當暫停時，降低透明度變化的速度 */
        .paused .lyric-line {
            transition-duration: 0.8s;
        }
        .paused .lyric-line.active {
            transition-duration: 0.8s;
        }
    </style>
</head>
<body>

    <!-- ===== 粒子背景 ===== -->
    <canvas id="bgCanvas"></canvas>

    <!-- ===== 主內容 ===== -->
    <div class="container" id="appContainer">

        <!-- 歌名 -->
        <div class="song-title">✦&ensp;如果離別是為了能再見一面&ensp;✦</div>

        <!-- 圖片 -->
        <div class="image-wrapper">
            <img src="/indexPerson.png" alt="相拥" />
        </div>

        <!-- 歌詞區域 -->
        <div class="lyrics-wrapper">
            <div class="lyrics-container" id="lyricsContainer">
                <div class="lyrics-list" id="lyricsList"></div>
            </div>
        </div>

        <!-- 進度條 -->
        <div class="progress-area">
            <span class="progress-time" id="currentTime">0:00</span>
            <div class="progress-bar" id="progressBar">
                <div class="progress-fill" id="progressFill"></div>
            </div>
            <span class="progress-time" id="totalTime">2:00</span>
        </div>

        <!-- 控制按鈕 -->
        <div class="controls">
            <button class="ctrl-btn" id="prevBtn" title="上一句">⏮</button>
            <button class="ctrl-btn play-btn" id="playBtn" title="播放 / 暫停">
                <span class="icon" id="playIcon">⏸</span>
            </button>
            <button class="ctrl-btn" id="nextBtn" title="下一句">⏭</button>
        </div>

        <div class="footer-note">♫ 風會替我們抵達 ♫</div>
    </div>

    <script>
        // ================================================================
        //  1. 歌詞數據 (共 40 行)
        // ================================================================
        const lyrics = [
            '如果離別是為了能再見一面',
            '愛是想念後的拋物線',
            '離開始漸行漸遠',
            '和我們總是擦肩',
            '這次再見如果是最後的一面',
            '也是失眠後的分割線',
            '春天已開始落葉',
            '七月裡也會下雪',
            '剛剛我錯過的大雨 握不住的盛夏',
            '飄過的雲是你嗎? 一圈又一圈',
            '我多想是路過你的風',
            '忍不住落回你眼中',
            '憑什麼繞不開 翻不過的盛夏',
            '有些遠方 讓風代替我們抵達',
            '沒勇氣說完的那句話',
            '希望有人聽過它',
            '這次再見如果是最後的一面',
            '也是失眠後的分割線',
            '春天已開始落葉',
            '七月裡也會下雪',
            '剛剛我錯過的大雨 握不住的盛夏',
            '飄過的雲是你嗎? 一圈又一圈',
            '我多想是路過你的風',
            '忍不住落回你眼中',
            '憑什麼繞不開 翻不過的盛夏',
            '有些遠方 讓風代替我們抵達',
            '沒勇氣說完的那句話',
            '希望有人聽過它',
            '讓你聽見風緩緩地 緩緩搖曳',
            '時光捲起了回憶慢慢翩翩',
            '讓風替我說 說那句告別',
            '在這個落葉像雪的季節',
            '剛剛我錯過的大雨 握不住的盛夏',
            '飄過的雲是你嗎? 一圈又一圈',
            '我多想是路過你的風',
            '忍不住落回你眼中',
            '憑什麼繞不開 翻不過的盛夏',
            '有些遠方 讓風代替我們抵達',
            '沒勇氣說完的那句話',
            '希望有人聽過它',
        ];

        // ================================================================
        //  2. DOM 引用
        // ================================================================
        const lyricsList = document.getElementById('lyricsList');
        const lyricsContainer = document.getElementById('lyricsContainer');
        const progressFill = document.getElementById('progressFill');
        const currentTimeEl = document.getElementById('currentTime');
        const totalTimeEl = document.getElementById('totalTime');
        const playBtn = document.getElementById('playBtn');
        const playIcon = document.getElementById('playIcon');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const appContainer = document.getElementById('appContainer');

        const totalLines = lyrics.length;
        const LINE_INTERVAL_MS = 2800; // 每行停留時間 (ms)
        let currentIndex = 0;
        let isPlaying = true;
        let timer = null;
        let isHovering = false;

        // ================================================================
        //  3. 渲染歌詞
        // ================================================================
        function renderLyrics() {
            lyricsList.innerHTML = '';
            lyrics.forEach((line, idx) => {
                const div = document.createElement('div');
                div.className = 'lyric-line';
                div.textContent = line;
                div.dataset.index = idx;
                lyricsList.appendChild(div);
            });
            // 總時間顯示 (估算)
            const totalSec = Math.round((totalLines * LINE_INTERVAL_MS) / 1000);
            const mins = String(Math.floor(totalSec / 60)).padStart(2, '0');
            const secs = String(totalSec % 60).padStart(2, '0');
            totalTimeEl.textContent = `${mins}:${secs}`;
        }

        // ================================================================
        //  4. 更新高亮 & 滾動
        // ================================================================
        function updateLyrics(index, smooth = true) {
            const lines = lyricsList.querySelectorAll('.lyric-line');
            if (!lines.length) return;

            // 清除所有狀態
            lines.forEach(el => {
                el.classList.remove('active', 'passed');
            });

            // 設置當前行
            const activeEl = lines[index];
            if (activeEl) {
                activeEl.classList.add('active');
            }

            // 設置已過行 (比當前小的)
            for (let i = 0; i < index; i++) {
                lines[i].classList.add('passed');
            }

            // 滾動到當前行 (居中)
            if (activeEl) {
                if (smooth) {
                    activeEl.scrollIntoView({ block: 'center', behavior: 'smooth' });
                } else {
                    activeEl.scrollIntoView({ block: 'center', behavior: 'auto' });
                }
            }

            // 更新進度條
            const progress = (index + 1) / totalLines;
            progressFill.style.width = `${Math.min(progress * 100, 100)}%`;

            // 更新當前時間
            const elapsedSec = Math.round((index * LINE_INTERVAL_MS) / 1000);
            const em = String(Math.floor(elapsedSec / 60)).padStart(2, '0');
            const es = String(elapsedSec % 60).padStart(2, '0');
            currentTimeEl.textContent = `${em}:${es}`;
        }

        // ================================================================
        //  5. 播放控制
        // ================================================================
        function goToLine(index, smooth = true) {
            if (index < 0) index = totalLines - 1;
            if (index >= totalLines) index = 0;
            currentIndex = index;
            updateLyrics(currentIndex, smooth);
        }

        function nextLine() {
            const next = (currentIndex + 1) % totalLines;
            goToLine(next, true);
        }

        function prevLine() {
            const prev = (currentIndex - 1 + totalLines) % totalLines;
            goToLine(prev, true);
        }

        function startTimer() {
            stopTimer();
            if (!isPlaying) return;
            timer = setInterval(() => {
                if (!isHovering) {
                    nextLine();
                }
            }, LINE_INTERVAL_MS);
        }

        function stopTimer() {
            if (timer) {
                clearInterval(timer);
                timer = null;
            }
        }

        function togglePlay() {
            isPlaying = !isPlaying;
            if (isPlaying) {
                playIcon.textContent = '⏸';
                appContainer.classList.remove('paused');
                startTimer();
            } else {
                playIcon.textContent = '▶';
                appContainer.classList.add('paused');
                stopTimer();
            }
        }

        // ================================================================
        //  6. 初始化
        // ================================================================
        function init() {
            renderLyrics();
            goToLine(0, false);
            startTimer();

            // 事件監聽
            playBtn.addEventListener('click', togglePlay);

            prevBtn.addEventListener('click', () => {
                if (isPlaying) {
                    // 暫時暫停，跳轉後繼續
                    const wasPlaying = isPlaying;
                    if (wasPlaying) {
                        stopTimer();
                        prevLine();
                        startTimer();
                    } else {
                        prevLine();
                    }
                } else {
                    prevLine();
                }
            });

            nextBtn.addEventListener('click', () => {
                if (isPlaying) {
                    const wasPlaying = isPlaying;
                    if (wasPlaying) {
                        stopTimer();
                        nextLine();
                        startTimer();
                    } else {
                        nextLine();
                    }
                } else {
                    nextLine();
                }
            });

            // 鼠標懸停歌詞區域暫停
            lyricsContainer.addEventListener('mouseenter', () => {
                isHovering = true;
                if (isPlaying) {
                    stopTimer();
                }
            });
            lyricsContainer.addEventListener('mouseleave', () => {
                isHovering = false;
                if (isPlaying) {
                    startTimer();
                }
            });

            // 鍵盤快捷鍵: 空格 切換播放, 左右方向鍵 前後
            document.addEventListener('keydown', (e) => {
                if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
                if (e.key === ' ' || e.key === 'Space') {
                    e.preventDefault();
                    togglePlay();
                } else if (e.key === 'ArrowRight') {
                    e.preventDefault();
                    if (isPlaying) { stopTimer();
                        nextLine();
                        startTimer(); } else { nextLine(); }
                } else if (e.key === 'ArrowLeft') {
                    e.preventDefault();
                    if (isPlaying) { stopTimer();
                        prevLine();
                        startTimer(); } else { prevLine(); }
                }
            });

            // 點擊進度條跳轉 (粗略)
            const progressBar = document.getElementById('progressBar');
            progressBar.addEventListener('click', (e) => {
                const rect = progressBar.getBoundingClientRect();
                const ratio = (e.clientX - rect.left) / rect.width;
                const targetIndex = Math.floor(ratio * totalLines);
                const clamped = Math.max(0, Math.min(totalLines - 1, targetIndex));
                const wasPlaying = isPlaying;
                if (wasPlaying) stopTimer();
                goToLine(clamped, true);
                if (wasPlaying) startTimer();
            });

            // 頁面可見性變化時，保持計時器準確
            document.addEventListener('visibilitychange', () => {
                if (document.hidden) {
                    if (isPlaying) stopTimer();
                } else {
                    if (isPlaying) startTimer();
                }
            });
        }

        // ================================================================
        //  7. 粒子背景 (Canvas)
        // ================================================================
        function initParticles() {
            const canvas = document.getElementById('bgCanvas');
            const ctx = canvas.getContext('2d');
            let w, h;
            const particles = [];
            const PARTICLE_COUNT = 70;

            function resize() {
                w = canvas.width = window.innerWidth;
                h = canvas.height = window.innerHeight;
            }
            window.addEventListener('resize', resize);
            resize();

            class Particle {
                constructor() {
                    this.reset();
                }
                reset() {
                    this.x = Math.random() * w;
                    this.y = Math.random() * h;
                    this.size = Math.random() * 2.6 + 0.6;
                    this.speedX = (Math.random() - 0.5) * 0.25;
                    this.speedY = (Math.random() - 0.5) * 0.25;
                    this.opacity = Math.random() * 0.5 + 0.15;
                    this.color = Math.random() > 0.5 ?
                        `rgba(240, 192, 96, ${this.opacity})` :
                        `rgba(180, 200, 255, ${this.opacity * 0.7})`;
                }
                update() {
                    this.x += this.speedX;
                    this.y += this.speedY;
                    if (this.x < 0 || this.x > w) this.speedX *= -1;
                    if (this.y < 0 || this.y > h) this.speedY *= -1;
                }
                draw() {
                    ctx.beginPath();
                    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
                    ctx.fillStyle = this.color;
                    ctx.fill();
                    // 微光暈
                    if (this.size > 1.8) {
                        ctx.shadowColor = 'rgba(240, 192, 96, 0.08)';
                        ctx.shadowBlur = 12;
                        ctx.fill();
                        ctx.shadowBlur = 0;
                    }
                }
            }

            for (let i = 0; i < PARTICLE_COUNT; i++) {
                particles.push(new Particle());
            }

            // 連線
            function drawLines() {
                for (let i = 0; i < particles.length; i++) {
                    for (let j = i + 1; j < particles.length; j++) {
                        const dx = particles[i].x - particles[j].x;
                        const dy = particles[i].y - particles[j].y;
                        const dist = Math.sqrt(dx * dx + dy * dy);
                        if (dist < 120) {
                            const alpha = (1 - dist / 120) * 0.08;
                            ctx.beginPath();
                            ctx.moveTo(particles[i].x, particles[i].y);
                            ctx.lineTo(particles[j].x, particles[j].y);
                            ctx.strokeStyle = `rgba(240, 192, 96, ${alpha})`;
                            ctx.lineWidth = 0.6;
                            ctx.stroke();
                        }
                    }
                }
            }

            function animate() {
                ctx.clearRect(0, 0, w, h);
                particles.forEach(p => {
                    p.update();
                    p.draw();
                });
                drawLines();
                requestAnimationFrame(animate);
            }

            animate();

            // 窗口變化重置粒子位置
            window.addEventListener('resize', () => {
                particles.forEach(p => {
                    p.x = Math.random() * w;
                    p.y = Math.random() * h;
                });
            });
        }

        // ================================================================
        //  8. 啟動
        // ================================================================
        document.addEventListener('DOMContentLoaded', () => {
            initParticles();
            init();
        });
    </script>

</body>
</html>


## 使用方式

- 使用右侧“本页目录”快速跳转到文章章节。
- 页面支持深色与浅色模式。
- 所有代码块默认显示行号。
- 支持 Mermaid 流程图、数学公式、任务列表、脚注、上下标和高亮。
- 文章中继续写 `[toc]` 即可，网页会自动生成目录。

## Learning Notes

> 学习不是把内容机械记住，而是逐渐建立起能够自己解释、推导和解决问题的体系。

内容持续更新中。

## 写在最后

也许这些内容不太适合补天喵~

![](/20260625030353_324_1.jpg)

