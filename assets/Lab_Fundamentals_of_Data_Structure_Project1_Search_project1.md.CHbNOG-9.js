import{_ as s,o as a,c as p,a4 as e}from"./chunks/framework.BaMAT_0D.js";const l="/my_note/assets/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20260315192251_27_1-1.C2mRjzhc.png",i="/my_note/assets/a74a82fb96234cc4383e93f4013778d9-1.uyDGSn1G.png",h=JSON.parse('{"title":"Report of Project 1：Normal-1 Performance Measurement (Search)","description":"","frontmatter":{},"headers":[],"relativePath":"Lab/Fundamentals_of_Data_Structure/Project1_Search/project1.md","filePath":"Lab/Fundamentals_of_Data_Structure/Project1_Search/project1.md","lastUpdated":1793365822000}'),r={name:"Lab/Fundamentals_of_Data_Structure/Project1_Search/project1.md"};function t(c,n,b,u,m,o){return a(),p("div",null,[...n[0]||(n[0]=[e(`<h1 id="report-of-project-1-normal-1-performance-measurement-search" tabindex="-1"><div class="c-center">Report of Project 1：Normal-1 Performance Measurement (Search)</div> <a class="header-anchor" href="#report-of-project-1-normal-1-performance-measurement-search" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Report of Project 1：Normal-1 Performance Measurement (Search)&lt;/div&gt;&quot;">​</a></h1><div class="c-center">完成时间：2026年3月15日</div><hr><h2 id="目录" tabindex="-1"><div class="c-center">目录</div> <a class="header-anchor" href="#目录" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;目录&lt;/div&gt;&quot;">​</a></h2><ul><li><a href="#1">Part 1：引言</a></li><li><a href="#2">Part 2：算法描述</a></li><li><a href="#3">Part 3：测试数据和图表呈现</a></li><li><a href="#4">Part 4：图表分析</a></li><li><a href="#5">Part 5：最终完整程序和总结</a></li><li><a href="#6">END</a></li></ul><hr><h2 id="part-1-引言" tabindex="-1"><div class="c-center">Part 1：引言 </div> <a class="header-anchor" href="#part-1-引言" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Part 1：引言 &lt;/div&gt;&quot;">​</a></h2><p><strong>问题描述：</strong> 本项目旨在比较四种不同的搜索算法在最坏的情况下的性能。给定一个已经排好序的数组，长度为 N，数组元素依次为 0 到 N-1 。此时，查找一个不存在于这个数组中的元素，设定为 N，就能实现最坏的情况。我们考虑两种策略，分别为顺序查找和二分查找。其中，每种策略均可用迭代和递归两种方式实现，因此我们得到了四个函数。</p><ul><li>顺序查找（迭代版）</li><li>顺序查找（递归版）</li><li>二分查找（迭代版）</li><li>二分查找（递归版）</li></ul><p><strong>项目要求：</strong></p><ul><li>实现上述四个函数</li><li>分析它们在最坏情况下的时间复杂度</li><li>对于给定的 8 个具体的N值，测量并比较四个函数的最坏情况运行时间，其中需要使用<code>clock()</code>函数。若单次运行时间过短则重复执行 K 次取平均值，以确保总时钟滴答数不少于十次以保证至少 10％ 的精度。</li><li>将实验数据填进表格，并且绘制出同一坐标系的<code>N-运行时间</code>曲线，对结果进行分析讨论。</li></ul><p>本次项目可以直观地理解不同的算法和实现方式对性能的影响，让人直接地掌握程序性能测量的办法。</p><hr><h2 id="part-2-算法描述" tabindex="-1"><div class="c-center">Part 2：算法描述</div> <a class="header-anchor" href="#part-2-算法描述" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Part 2：算法描述&lt;/div&gt;&quot;">​</a></h2><ul><li><strong>总述</strong> 本部分将展示四个算法和时间测量部分的伪代码描述，并且简要说明主程序的结构。</li></ul><hr><ul><li><strong>顺序查找迭代版</strong> 从第一个元素开始，逐个与目标关键字进行比较，直到找到目标或遍历完整个数组。在最坏情况下（目标不存在或位于最后一个），需要比较所有的N个元素。</li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>/*顺序查找迭代版*/</span></span>
<span class="line"><span>int Sequential_Search_Iterative_(int a[], int n, int element) {</span></span>
<span class="line"><span>	/*从第一个元素开始遍历，如果找到，返回下标 + 1，并退出改函数*/</span></span>
<span class="line"><span>	for (int i = 0; i &lt; n; i++) {</span></span>
<span class="line"><span>		if (a[i] == element) {</span></span>
<span class="line"><span>			return i + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果没有找到，返回 - 1*/</span></span>
<span class="line"><span>	return -1;</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br></div></div><ul><li>时间复杂度：最坏情况需要比较N次，即 O(N)。</li><li>空间复杂度：仅使用常数个辅助变量，即 O(1)。</li></ul><hr><ul><li><strong>顺序查找递归版</strong> 递归检查当前下标元素，若匹配则返回，否则在下标+1处递归.</li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>/*顺序查找递归版*/</span></span>
<span class="line"><span>int Sequential_Search_Recursive(int a[], int n, int element, int index) {</span></span>
<span class="line"><span>	/*如果当前下标已经超过了数组长度，说明没有查找到所求元素，返回-1*/</span></span>
<span class="line"><span>	if (index &gt;= n) {</span></span>
<span class="line"><span>		return -1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果找到了所需元素，返回下标+1*/</span></span>
<span class="line"><span>	if (a[index] == element) {</span></span>
<span class="line"><span>		return index + 1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果暂时未找到所需元素，则下标 + 1，继续查找*/</span></span>
<span class="line"><span>	return Sequential_Search_Recursive(a, n, element, index + 1);</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br></div></div><ul><li>时间复杂度：需比较N次，每次递归调用有常数开销，即 O(N)。</li><li>空间复杂度：递归深度等于N，每次调用占用栈空间，即 O(N)。</li></ul><hr><ul><li><strong>二分查找迭代版</strong> 在有序数组中每次取中间元素和所需元素进行比较，根据比较结果缩小一半的查找区间.</li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>/*二分查找迭代版*/</span></span>
<span class="line"><span>int Binary_Search_Iterative_(int a[], int n, int element) {</span></span>
<span class="line"><span>	//定义左、右边界*/</span></span>
<span class="line"><span>	int left = 0;</span></span>
<span class="line"><span>	int right = n - 1;</span></span>
<span class="line"><span>	/*将当前数组分成两个区间，取得中间坐标，减半查找*/</span></span>
<span class="line"><span>	while (left &lt;= right) {</span></span>
<span class="line"><span>		int mid = (left + right) / 2;</span></span>
<span class="line"><span>		/*当前数组中间下标对应元素即为所需元素，返回下标 + 1，退出*/</span></span>
<span class="line"><span>		if (element == a[mid]) {</span></span>
<span class="line"><span>			return mid + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*所需元素在当前数组的右半区间*/</span></span>
<span class="line"><span>		else if (a[mid] &lt; element) {</span></span>
<span class="line"><span>			left = mid + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*所需元素在当前数组的左半区间*/</span></span>
<span class="line"><span>		else {</span></span>
<span class="line"><span>			right = mid - 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*循环结束仍未找到，说明该、所需元素不在该数组内，返回-1*/</span></span>
<span class="line"><span>	return -1;</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br></div></div><ul><li>时间复杂度：每次将区间减半，比较次数为 log₂N+1，时间复杂度 O(log N)。</li><li>空间复杂度：仅需常数空间，即 O(1)。</li></ul><hr><ul><li><strong>二分查找递归版</strong> 递归地在当前区间的中间点判断，然后递归地在左半或右半区间查找。</li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>/*二分查找递归版*/</span></span>
<span class="line"><span>int Binary_Search_Recursive(int a[], int left, int right, int element) {</span></span>
<span class="line"><span>	/*检查边界条件是否满足，不满足返回-1*/</span></span>
<span class="line"><span>	if (left &gt; right) {</span></span>
<span class="line"><span>		return -1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*将当前数组分半，取得中间坐标，折半查找*/</span></span>
<span class="line"><span>	int mid = (left + right) / 2;</span></span>
<span class="line"><span>	/*如果中间坐标对应元素即为所求，返回下标+1，退出该函数*/</span></span>
<span class="line"><span>	if (a[mid] == element) {</span></span>
<span class="line"><span>		return mid + 1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果所求元素大于当前数组中间下标值所对应的元素，说明所求元素在右半区间*/</span></span>
<span class="line"><span>	else if (a[mid] &lt; element) {</span></span>
<span class="line"><span>		return Binary_Search_Recursive(a, mid + 1, right, element);</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果所求元素小于当前数组中间下标值所对应的元素，说明所求元素在左半区间*/</span></span>
<span class="line"><span>	else {</span></span>
<span class="line"><span>		return Binary_Search_Recursive(a, left, mid - 1, element);</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br></div></div><ul><li>时间复杂度：同为 O(log N)。</li><li>空间复杂度：递归深度为O(log N)，栈空间占用 O(log N)。</li></ul><hr><ul><li><p><strong>时间测量</strong> 为了准确测量一个运行时间极短的函数，需要多次重复调用并取平均。测量函数 <code>Measure</code> 的步骤如下：</p></li><li><p>(1) 确定合适的重复次数K：</p><ul><li>初始设 K = 1。</li><li>循环将 K 加倍，并测量当前K次调用的总时钟滴答数 <code>ticks</code>。</li><li>当 <code>ticks</code> 达到预设目标值或K超过上限时停止。这一步保证了最终测量的总时间足够长，有效减少计时误差。</li></ul></li><li><p>(2) 正式测量：</p><ul><li>记录开始时间 <code>begin = clock()</code>。</li><li>循环K次调用被测函数，并将返回值累加。</li><li>记录结束时间 <code>end = clock()</code>。</li><li>计算总时钟滴答数 <code>ticks = end - begin</code>，总时间 <code>total_seconds = (double)ticks / CLOCKS_PER_SEC</code>。</li><li>单次平均时间 <code>duration = total_seconds / K</code>。</li></ul></li><li><p>(3) 返回结果：</p><ul><li>将 <code>duration、K、ticks</code> 封装在结构体 <code>Measurement</code> 中返回。</li></ul></li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>/*对两个递归版函数进行封装,统一接口更好地测量时间*/</span></span>
<span class="line"><span>int Sequential_Search_Recursive_(int a[], int n, int element) {</span></span>
<span class="line"><span>	return Sequential_Search_Recursive(a, n, element, 0);</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>int Binary_Search_Recursive_(int a[], int n, int element) {</span></span>
<span class="line"><span>	return Binary_Search_Recursive(a, 0, n - 1, element);</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*测试用例结构体：包含算法名称、函数指针、储存测量结果的数组*/</span></span>
<span class="line"><span>typedef struct {</span></span>
<span class="line"><span>	const char* name;     /*算法名称*/</span></span>
<span class="line"><span>	int (*fun)(int[], int, int);     /*函数指针*/</span></span>
<span class="line"><span>	double* results;     /*储存测量结果的数组*/</span></span>
<span class="line"><span>}test;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*测量结果结构体：包含单次执行时间、循环次数K、时钟滴答数*/</span></span>
<span class="line"><span>typedef struct {</span></span>
<span class="line"><span>	double duration;     /*单次执行时间*/</span></span>
<span class="line"><span>	int K;     /*循环次数K*/</span></span>
<span class="line"><span>	long ticks;     /*时钟滴答数*/</span></span>
<span class="line"><span>}Measurement;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>Measurement Measure(int (*fun)(int[], int, int), int a[], int n, int element) {</span></span>
<span class="line"><span>	int K = 1;</span></span>
<span class="line"><span>	clock_t begin;</span></span>
<span class="line"><span>	clock_t end;</span></span>
<span class="line"><span>	double ticks;</span></span>
<span class="line"><span>	const int target = 20;     /*目标时钟滴答数，用于确定合适的K*/</span></span>
<span class="line"><span>	do {</span></span>
<span class="line"><span>		K *= 2;</span></span>
<span class="line"><span>		begin = clock();</span></span>
<span class="line"><span>		for (int i = 0; i &lt; K; i++) {</span></span>
<span class="line"><span>			fun(a, n, element);</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		end = clock();</span></span>
<span class="line"><span>		ticks = (double)(end - begin);</span></span>
<span class="line"><span>	} while (ticks &lt; target &amp;&amp; K &lt; 100000000);     /*防止无限循环*/</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	int dummy = 0;     /*用于累加返回值*/</span></span>
<span class="line"><span>	begin = clock();</span></span>
<span class="line"><span>	for (int i = 0; i &lt; K; i++) {</span></span>
<span class="line"><span>		dummy += fun(a, n, element);     /*累加返回值*/</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	end = clock();</span></span>
<span class="line"><span>	long ticks_ = end - begin;     /*实际测量的总时钟滴答数*/</span></span>
<span class="line"><span>	double second = (double)(end - begin) / CLOCKS_PER_SEC;     /*转换为秒*/</span></span>
<span class="line"><span>	Measurement Data;</span></span>
<span class="line"><span>	Data.duration = second / K;     /*平均每次执行时间*/</span></span>
<span class="line"><span>	Data.K = K;</span></span>
<span class="line"><span>	Data.ticks = ticks_;</span></span>
<span class="line"><span>	return Data;</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br><span class="line-number">36</span><br><span class="line-number">37</span><br><span class="line-number">38</span><br><span class="line-number">39</span><br><span class="line-number">40</span><br><span class="line-number">41</span><br><span class="line-number">42</span><br><span class="line-number">43</span><br><span class="line-number">44</span><br><span class="line-number">45</span><br><span class="line-number">46</span><br><span class="line-number">47</span><br><span class="line-number">48</span><br><span class="line-number">49</span><br><span class="line-number">50</span><br><span class="line-number">51</span><br><span class="line-number">52</span><br><span class="line-number">53</span><br></div></div><hr><ul><li><p><strong>主程序</strong></p></li><li><p>(1) 定义待测试的数组大小列表：</p><ul><li><code>N_element[] = {100, 500, 1000, 2000, 4000, 6000, 8000, 10000}。</code></li></ul></li><li><p>(2) 为四种算法分别分配存储平均时间的数组<code>TimeSeqIter，TimeSeqRecur, TimeBinIter, TimeBinRecur</code>。</p></li><li><p>(3) 定义测试结构体数组 <code>tests[4]</code>，每个元素包含算法名称、对应的函数指针和存储时间的数组。这样便于循环处理。</p></li><li><p>(4) 对于每个N：</p><ul><li>动态分配大小为N的整型数组 <code>a</code>，并初始化为 <code>0, 1, 2, ..., N-1</code>，保证数组有序。</li><li>设置查找关键字 <code>value = N</code>（该值不在数组中，保证最坏情况）。</li><li>对四种算法依次调用 <code>Measure</code> 函数，获得测量结果，并将平均时间存入对应的数组。同时打印该算法的测量信息。</li><li>释放数组 <code>a</code>。</li></ul></li><li><p>(5) 所有 N 测试完成后，释放动态分配的时间数组，程序结束。</p></li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>#include&lt;stdio.h&gt;</span></span>
<span class="line"><span>#include&lt;math.h&gt;</span></span>
<span class="line"><span>#include&lt;time.h&gt;</span></span>
<span class="line"><span>#include&lt;stdlib.h&gt;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*设置栈大小为16MB*/</span></span>
<span class="line"><span>#pragma comment(linker, &quot;/STACK:33554432&quot;)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>int main() {</span></span>
<span class="line"><span>	/*待测试的数组大小列表*/</span></span>
<span class="line"><span>	int N_element[] = { 100,500,1000,2000,4000,6000,8000,10000 };</span></span>
<span class="line"><span>	int N_number = sizeof(N_element) / (sizeof(N_element[0]));</span></span>
<span class="line"><span>	</span></span>
<span class="line"><span>	/*为四种算法分别分配存储时间的数组*/</span></span>
<span class="line"><span>	double* TimeSeqIter = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeSeqRecur = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeBinIter = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeBinRecur = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*定义四种测试，每个包含名称、函数指针和对应的时间存储数组*/</span></span>
<span class="line"><span>	test tests[4] = {</span></span>
<span class="line"><span>		{&quot;SeqIter&quot;,Sequential_Search_Iterative_,TimeSeqIter},</span></span>
<span class="line"><span>		{&quot;SeqRecur&quot;,Sequential_Search_Recursive_,TimeSeqRecur},</span></span>
<span class="line"><span>		{&quot;BinIter&quot;,Binary_Search_Iterative_,TimeBinIter},</span></span>
<span class="line"><span>		{&quot;BinRecur&quot;,Binary_Search_Recursive_,TimeBinRecur}</span></span>
<span class="line"><span>	};</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*对每个数组大小进行测试*/</span></span>
<span class="line"><span>	for (int i = 0; i &lt; N_number; i++) {</span></span>
<span class="line"><span>		int N = N_element[i];</span></span>
<span class="line"><span>		int* a = (int*)malloc(N * sizeof(int));</span></span>
<span class="line"><span>		if (a == NULL) {</span></span>
<span class="line"><span>			return 1;     /*内存分配失败，退出*/</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*初始化数组为0,1,2,...,N-1，确保有序，便于二分查找*/</span></span>
<span class="line"><span>		for (int j = 0; j &lt; N; j++) {</span></span>
<span class="line"><span>			a[j] = j;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		int value = N;     /*查找一个不存在的元素（值为N），以模拟最坏情况（查找失败）*/</span></span>
<span class="line"><span>		printf(&quot;数组大小 N = %d:\\n&quot;, N);</span></span>
<span class="line"><span>		/*对四种算法分别进行测量*/</span></span>
<span class="line"><span>		for (int k = 0; k &lt; 4; k++) {</span></span>
<span class="line"><span>			Measurement Value = Measure(tests[k].fun, a, N, value);</span></span>
<span class="line"><span>			tests[k].results[i] = Value.duration;     /*保存平均时间*/</span></span>
<span class="line"><span>			printf(&quot;  %s: duration=%.10f sec  (K=%d, ticks=%ld, total=%.6f sec)\\n&quot;, tests[k].name, Value.duration, Value.K, Value.ticks, (double)Value.ticks / CLOCKS_PER_SEC);</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		free(a);     /*释放当前数组*/</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*释放动态分配的内存*/</span></span>
<span class="line"><span>	free(TimeBinIter);</span></span>
<span class="line"><span>	free(TimeBinRecur);</span></span>
<span class="line"><span>	free(TimeSeqIter);</span></span>
<span class="line"><span>	free(TimeSeqRecur);</span></span>
<span class="line"><span>	return 0;</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br><span class="line-number">36</span><br><span class="line-number">37</span><br><span class="line-number">38</span><br><span class="line-number">39</span><br><span class="line-number">40</span><br><span class="line-number">41</span><br><span class="line-number">42</span><br><span class="line-number">43</span><br><span class="line-number">44</span><br><span class="line-number">45</span><br><span class="line-number">46</span><br><span class="line-number">47</span><br><span class="line-number">48</span><br><span class="line-number">49</span><br><span class="line-number">50</span><br><span class="line-number">51</span><br><span class="line-number">52</span><br><span class="line-number">53</span><br><span class="line-number">54</span><br><span class="line-number">55</span><br><span class="line-number">56</span><br></div></div><hr><h2 id="part-3-测试数据和图标呈现" tabindex="-1"><div class="c-center">Part 3：测试数据和图标呈现</div> <a class="header-anchor" href="#part-3-测试数据和图标呈现" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Part 3：测试数据和图标呈现&lt;/div&gt;&quot;">​</a></h2><ul><li>下表列出了四个算法在不同N下的最坏情况性能数据。其中“K”为重复调用次数，“Ticks”为K次调用消耗的总时钟滴答数，“Total Time”为K次调用的总时间（秒），“Duration”为单次调用的平均时间（秒）。</li></ul><p><img src="`+l+'" alt="alt text" loading="lazy"></p><ul><li>其中，所有Ticks均保证≥10，满足项目要求</li></ul><hr><ul><li><strong>顺序查找</strong><ul><li>在双对数图中，两条曲线近似为斜率为1的直线，表明时间与 N 呈线性关系为 O(N) 。</li><li>考虑到有测量噪声噪声和系统干扰，包括操作系统调度、后台进程、CPU缓存波动等会让单次测量结果出现微小抖动，导致某次递归版时间略低于迭代版。</li><li>递归版本曲线几乎始终位于迭代版本上方，反映了递归调用的额外开销。</li></ul></li><li><strong>二分查找</strong><ul><li>两条曲线增长极为缓慢，近似水平，符合对数关系（O(log N)）。</li><li>递归版本略高于迭代版本，同样因函数调用开销所致。随着N增大，二分查找时间几乎不变</li></ul></li></ul><p><img src="'+i+`" alt="alt text" loading="lazy"></p><hr><h2 id="part-4-图表分析" tabindex="-1"><div class="c-center">Part 4：图表分析</div> <a class="header-anchor" href="#part-4-图表分析" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Part 4：图表分析&lt;/div&gt;&quot;">​</a></h2><ul><li><strong>通过对图表的分析，我们可以发现：</strong><ul><li>实验所有数据的<code>Ticks</code>全部大于10，这毫无疑问增大了实验的精确性。</li><li>二分查找远快于顺序查找：二分查找的两条曲线在双对数图中几乎呈水平直线，仅随 N 增大有极其缓慢的上升。N=10000 时，二分查找迭代版是顺序查找迭代版用时的约1/228，这体现了对数算法与线性算法的巨大差异，在大规模数据环境下，二分法显然更具优势。</li><li>递归版本比迭代版本慢：由于函数调用开销，递归版本在两种查找中均比迭代版本慢约30%~40%。对于顺序查找，递归还带来 O(N) 的栈空间开销。额外开销主要来自：每次递归调用的函数调用开销（参数压栈、跳转、返回）、递归深度等于 N，栈操作本身也有成本、编译器可能难以对递归进行优化（如尾递归优化未开启时）。实际应用中，应该优先选用迭代版本。</li><li>时间复杂度理论值与实测一致：顺序查找时间随 N 线性增长，二分查找时间随 N 对数增长，验证了理论分析。</li><li>测量方法上，使用自适应 K 值确保 <code>ticks</code> 足够大是可行的，但应适当提高目标 <code>ticks</code>（如 20、50 或 100）以获得更高精度。</li></ul></li></ul><hr><h2 id="part-5-最终完整程序和总结" tabindex="-1"><div class="c-center">Part 5：最终完整程序和总结</div> <a class="header-anchor" href="#part-5-最终完整程序和总结" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;Part 5：最终完整程序和总结&lt;/div&gt;&quot;">​</a></h2><ul><li><strong>最终完整程序</strong></li></ul><div class="language- vp-adaptive-theme line-numbers-mode"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>#include&lt;stdio.h&gt;</span></span>
<span class="line"><span>#include&lt;math.h&gt;</span></span>
<span class="line"><span>#include&lt;time.h&gt;</span></span>
<span class="line"><span>#include&lt;stdlib.h&gt;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*设置栈大小为16MB*/</span></span>
<span class="line"><span>#pragma comment(linker, &quot;/STACK:33554432&quot;)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>typedef int ElemType;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*顺序查找迭代版*/</span></span>
<span class="line"><span>int Sequential_Search_Iterative_(int a[], int n, int element) {</span></span>
<span class="line"><span>	/*从第一个元素开始遍历，如果找到，返回下标 + 1，并退出改函数*/</span></span>
<span class="line"><span>	for (int i = 0; i &lt; n; i++) {</span></span>
<span class="line"><span>		if (a[i] == element) {</span></span>
<span class="line"><span>			return i + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果没有找到，返回 - 1*/</span></span>
<span class="line"><span>	return -1;</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*顺序查找递归版*/</span></span>
<span class="line"><span>int Sequential_Search_Recursive(int a[], int n, int element, int index) {</span></span>
<span class="line"><span>	/*如果当前下标已经超过了数组长度，说明没有查找到所求元素，返回-1*/</span></span>
<span class="line"><span>	if (index &gt;= n) {</span></span>
<span class="line"><span>		return -1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果找到了所需元素，返回下标+1*/</span></span>
<span class="line"><span>	if (a[index] == element) {</span></span>
<span class="line"><span>		return index + 1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果暂时未找到所需元素，则下标 + 1，继续查找*/</span></span>
<span class="line"><span>	return Sequential_Search_Recursive(a, n, element, index + 1);</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*二分查找迭代版*/</span></span>
<span class="line"><span>int Binary_Search_Iterative_(int a[], int n, int element) {</span></span>
<span class="line"><span>	//定义左、右边界*/</span></span>
<span class="line"><span>	int left = 0;</span></span>
<span class="line"><span>	int right = n - 1;</span></span>
<span class="line"><span>	/*将当前数组分成两个区间，取得中间坐标，减半查找*/</span></span>
<span class="line"><span>	while (left &lt;= right) {</span></span>
<span class="line"><span>		int mid = (left + right) / 2;</span></span>
<span class="line"><span>		/*当前数组中间下标对应元素即为所需元素，返回下标 + 1，退出*/</span></span>
<span class="line"><span>		if (element == a[mid]) {</span></span>
<span class="line"><span>			return mid + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*所需元素在当前数组的右半区间*/</span></span>
<span class="line"><span>		else if (a[mid] &lt; element) {</span></span>
<span class="line"><span>			left = mid + 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*所需元素在当前数组的左半区间*/</span></span>
<span class="line"><span>		else {</span></span>
<span class="line"><span>			right = mid - 1;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*循环结束仍未找到，说明该、所需元素不在该数组内，返回-1*/</span></span>
<span class="line"><span>	return -1;</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*二分查找递归版*/</span></span>
<span class="line"><span>int Binary_Search_Recursive(int a[], int left, int right, int element) {</span></span>
<span class="line"><span>	/*检查边界条件是否满足，不满足返回-1*/</span></span>
<span class="line"><span>	if (left &gt; right) {</span></span>
<span class="line"><span>		return -1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*将当前数组分半，取得中间坐标，折半查找*/</span></span>
<span class="line"><span>	int mid = (left + right) / 2;</span></span>
<span class="line"><span>	/*如果中间坐标对应元素即为所求，返回下标+1，退出该函数*/</span></span>
<span class="line"><span>	if (a[mid] == element) {</span></span>
<span class="line"><span>		return mid + 1;</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果所求元素大于当前数组中间下标值所对应的元素，说明所求元素在右半区间*/</span></span>
<span class="line"><span>	else if (a[mid] &lt; element) {</span></span>
<span class="line"><span>		return Binary_Search_Recursive(a, mid + 1, right, element);</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	/*如果所求元素小于当前数组中间下标值所对应的元素，说明所求元素在左半区间*/</span></span>
<span class="line"><span>	else {</span></span>
<span class="line"><span>		return Binary_Search_Recursive(a, left, mid - 1, element);</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*对两个递归版函数进行封装,统一接口更好地测量时间*/</span></span>
<span class="line"><span>int Sequential_Search_Recursive_(int a[], int n, int element) {</span></span>
<span class="line"><span>	return Sequential_Search_Recursive(a, n, element, 0);</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>int Binary_Search_Recursive_(int a[], int n, int element) {</span></span>
<span class="line"><span>	return Binary_Search_Recursive(a, 0, n - 1, element);</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span>/*测试用例结构体：包含算法名称、函数指针、储存测量结果的数组*/</span></span>
<span class="line"><span>typedef struct {</span></span>
<span class="line"><span>	const char* name;     /*算法名称*/</span></span>
<span class="line"><span>	int (*fun)(int[], int, int);     /*函数指针*/</span></span>
<span class="line"><span>	double* results;     /*储存测量结果的数组*/</span></span>
<span class="line"><span>}test;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>/*测量结果结构体：包含单次执行时间、循环次数K、时钟滴答数*/</span></span>
<span class="line"><span>typedef struct {</span></span>
<span class="line"><span>	double duration;     /*单次执行时间*/</span></span>
<span class="line"><span>	int K;     /*循环次数K*/</span></span>
<span class="line"><span>	long ticks;     /*时钟滴答数*/</span></span>
<span class="line"><span>}Measurement;</span></span>
<span class="line"><span></span></span>
<span class="line"><span>Measurement Measure(int (*fun)(int[], int, int), int a[], int n, int element) {</span></span>
<span class="line"><span>	int K = 1;</span></span>
<span class="line"><span>	clock_t begin;</span></span>
<span class="line"><span>	clock_t end;</span></span>
<span class="line"><span>	double ticks;</span></span>
<span class="line"><span>	const int target = 20;     /*目标时钟滴答数，用于确定合适的K*/</span></span>
<span class="line"><span>	do {</span></span>
<span class="line"><span>		K *= 2;</span></span>
<span class="line"><span>		begin = clock();</span></span>
<span class="line"><span>		for (int i = 0; i &lt; K; i++) {</span></span>
<span class="line"><span>			fun(a, n, element);</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		end = clock();</span></span>
<span class="line"><span>		ticks = (double)(end - begin);</span></span>
<span class="line"><span>	} while (ticks &lt; target &amp;&amp; K &lt; 100000000);     /*防止无限循环*/</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	int dummy = 0;     /*用于累加返回值*/</span></span>
<span class="line"><span>	begin = clock();</span></span>
<span class="line"><span>	for (int i = 0; i &lt; K; i++) {</span></span>
<span class="line"><span>		dummy += fun(a, n, element);     /*累加返回值*/</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span>	end = clock();</span></span>
<span class="line"><span>	long ticks_ = end - begin;     /*实际测量的总时钟滴答数*/</span></span>
<span class="line"><span>	double second = (double)(end - begin) / CLOCKS_PER_SEC;     /*转换为秒*/</span></span>
<span class="line"><span>	Measurement Data;</span></span>
<span class="line"><span>	Data.duration = second / K;     /*平均每次执行时间*/</span></span>
<span class="line"><span>	Data.K = K;</span></span>
<span class="line"><span>	Data.ticks = ticks_;</span></span>
<span class="line"><span>	return Data;</span></span>
<span class="line"><span>}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>int main() {</span></span>
<span class="line"><span>	/*待测试的数组大小列表*/</span></span>
<span class="line"><span>	int N_element[] = { 100,500,1000,2000,4000,6000,8000,10000 };</span></span>
<span class="line"><span>	int N_number = sizeof(N_element) / (sizeof(N_element[0]));</span></span>
<span class="line"><span>	</span></span>
<span class="line"><span>	/*为四种算法分别分配存储时间的数组*/</span></span>
<span class="line"><span>	double* TimeSeqIter = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeSeqRecur = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeBinIter = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span>	double* TimeBinRecur = (double*)malloc(N_number * sizeof(double));</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*定义四种测试，每个包含名称、函数指针和对应的时间存储数组*/</span></span>
<span class="line"><span>	test tests[4] = {</span></span>
<span class="line"><span>		{&quot;SeqIter&quot;,Sequential_Search_Iterative_,TimeSeqIter},</span></span>
<span class="line"><span>		{&quot;SeqRecur&quot;,Sequential_Search_Recursive_,TimeSeqRecur},</span></span>
<span class="line"><span>		{&quot;BinIter&quot;,Binary_Search_Iterative_,TimeBinIter},</span></span>
<span class="line"><span>		{&quot;BinRecur&quot;,Binary_Search_Recursive_,TimeBinRecur}</span></span>
<span class="line"><span>	};</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*对每个数组大小进行测试*/</span></span>
<span class="line"><span>	for (int i = 0; i &lt; N_number; i++) {</span></span>
<span class="line"><span>		int N = N_element[i];</span></span>
<span class="line"><span>		int* a = (int*)malloc(N * sizeof(int));</span></span>
<span class="line"><span>		if (a == NULL) {</span></span>
<span class="line"><span>			return 1;     /*内存分配失败，退出*/</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		/*初始化数组为0,1,2,...,N-1，确保有序，便于二分查找*/</span></span>
<span class="line"><span>		for (int j = 0; j &lt; N; j++) {</span></span>
<span class="line"><span>			a[j] = j;</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		int value = N;     /*查找一个不存在的元素（值为N），以模拟最坏情况（查找失败）*/</span></span>
<span class="line"><span>		printf(&quot;数组大小 N = %d:\\n&quot;, N);</span></span>
<span class="line"><span>		/*对四种算法分别进行测量*/</span></span>
<span class="line"><span>		for (int k = 0; k &lt; 4; k++) {</span></span>
<span class="line"><span>			Measurement Value = Measure(tests[k].fun, a, N, value);</span></span>
<span class="line"><span>			tests[k].results[i] = Value.duration;     /*保存平均时间*/</span></span>
<span class="line"><span>			printf(&quot;  %s: duration=%.10f sec  (K=%d, ticks=%ld, total=%.6f sec)\\n&quot;, tests[k].name, Value.duration, Value.K, Value.ticks, (double)Value.ticks / CLOCKS_PER_SEC);</span></span>
<span class="line"><span>		}</span></span>
<span class="line"><span>		free(a);     /*释放当前数组*/</span></span>
<span class="line"><span>	}</span></span>
<span class="line"><span></span></span>
<span class="line"><span>	/*释放动态分配的内存*/</span></span>
<span class="line"><span>	free(TimeBinIter);</span></span>
<span class="line"><span>	free(TimeBinRecur);</span></span>
<span class="line"><span>	free(TimeSeqIter);</span></span>
<span class="line"><span>	free(TimeSeqRecur);</span></span>
<span class="line"><span>	return 0;</span></span>
<span class="line"><span>}</span></span></code></pre><div class="line-numbers-wrapper" aria-hidden="true"><span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br><span class="line-number">36</span><br><span class="line-number">37</span><br><span class="line-number">38</span><br><span class="line-number">39</span><br><span class="line-number">40</span><br><span class="line-number">41</span><br><span class="line-number">42</span><br><span class="line-number">43</span><br><span class="line-number">44</span><br><span class="line-number">45</span><br><span class="line-number">46</span><br><span class="line-number">47</span><br><span class="line-number">48</span><br><span class="line-number">49</span><br><span class="line-number">50</span><br><span class="line-number">51</span><br><span class="line-number">52</span><br><span class="line-number">53</span><br><span class="line-number">54</span><br><span class="line-number">55</span><br><span class="line-number">56</span><br><span class="line-number">57</span><br><span class="line-number">58</span><br><span class="line-number">59</span><br><span class="line-number">60</span><br><span class="line-number">61</span><br><span class="line-number">62</span><br><span class="line-number">63</span><br><span class="line-number">64</span><br><span class="line-number">65</span><br><span class="line-number">66</span><br><span class="line-number">67</span><br><span class="line-number">68</span><br><span class="line-number">69</span><br><span class="line-number">70</span><br><span class="line-number">71</span><br><span class="line-number">72</span><br><span class="line-number">73</span><br><span class="line-number">74</span><br><span class="line-number">75</span><br><span class="line-number">76</span><br><span class="line-number">77</span><br><span class="line-number">78</span><br><span class="line-number">79</span><br><span class="line-number">80</span><br><span class="line-number">81</span><br><span class="line-number">82</span><br><span class="line-number">83</span><br><span class="line-number">84</span><br><span class="line-number">85</span><br><span class="line-number">86</span><br><span class="line-number">87</span><br><span class="line-number">88</span><br><span class="line-number">89</span><br><span class="line-number">90</span><br><span class="line-number">91</span><br><span class="line-number">92</span><br><span class="line-number">93</span><br><span class="line-number">94</span><br><span class="line-number">95</span><br><span class="line-number">96</span><br><span class="line-number">97</span><br><span class="line-number">98</span><br><span class="line-number">99</span><br><span class="line-number">100</span><br><span class="line-number">101</span><br><span class="line-number">102</span><br><span class="line-number">103</span><br><span class="line-number">104</span><br><span class="line-number">105</span><br><span class="line-number">106</span><br><span class="line-number">107</span><br><span class="line-number">108</span><br><span class="line-number">109</span><br><span class="line-number">110</span><br><span class="line-number">111</span><br><span class="line-number">112</span><br><span class="line-number">113</span><br><span class="line-number">114</span><br><span class="line-number">115</span><br><span class="line-number">116</span><br><span class="line-number">117</span><br><span class="line-number">118</span><br><span class="line-number">119</span><br><span class="line-number">120</span><br><span class="line-number">121</span><br><span class="line-number">122</span><br><span class="line-number">123</span><br><span class="line-number">124</span><br><span class="line-number">125</span><br><span class="line-number">126</span><br><span class="line-number">127</span><br><span class="line-number">128</span><br><span class="line-number">129</span><br><span class="line-number">130</span><br><span class="line-number">131</span><br><span class="line-number">132</span><br><span class="line-number">133</span><br><span class="line-number">134</span><br><span class="line-number">135</span><br><span class="line-number">136</span><br><span class="line-number">137</span><br><span class="line-number">138</span><br><span class="line-number">139</span><br><span class="line-number">140</span><br><span class="line-number">141</span><br><span class="line-number">142</span><br><span class="line-number">143</span><br><span class="line-number">144</span><br><span class="line-number">145</span><br><span class="line-number">146</span><br><span class="line-number">147</span><br><span class="line-number">148</span><br><span class="line-number">149</span><br><span class="line-number">150</span><br><span class="line-number">151</span><br><span class="line-number">152</span><br><span class="line-number">153</span><br><span class="line-number">154</span><br><span class="line-number">155</span><br><span class="line-number">156</span><br><span class="line-number">157</span><br><span class="line-number">158</span><br><span class="line-number">159</span><br><span class="line-number">160</span><br><span class="line-number">161</span><br><span class="line-number">162</span><br><span class="line-number">163</span><br><span class="line-number">164</span><br><span class="line-number">165</span><br><span class="line-number">166</span><br><span class="line-number">167</span><br><span class="line-number">168</span><br><span class="line-number">169</span><br><span class="line-number">170</span><br><span class="line-number">171</span><br><span class="line-number">172</span><br><span class="line-number">173</span><br><span class="line-number">174</span><br><span class="line-number">175</span><br><span class="line-number">176</span><br><span class="line-number">177</span><br><span class="line-number">178</span><br><span class="line-number">179</span><br><span class="line-number">180</span><br><span class="line-number">181</span><br><span class="line-number">182</span><br><span class="line-number">183</span><br><span class="line-number">184</span><br><span class="line-number">185</span><br></div></div><ul><li><strong>总结</strong> 本实验清晰地展示了算法设计与实现方式对性能的影响，这也为实际的应用场景中选择合适的算法提供了思路和依据。</li></ul><hr><h2 id="end" tabindex="-1"><div class="c-center">END</div> <a class="header-anchor" href="#end" aria-label="Permalink to &quot;&lt;div class=&quot;c-center&quot;&gt;END&lt;/div&gt;&quot;">​</a></h2>`,55)])])}const _=s(r,[["render",t]]);export{h as __pageData,_ as default};
