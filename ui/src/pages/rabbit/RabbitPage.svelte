<script lang="ts">
  import {onDestroy, onMount} from 'svelte'
  import RabbitNav from './RabbitNav.svelte'
  import RabbitSection from './RabbitSection.svelte'
  import RabbitPreorder from './RabbitPreorder.svelte'

  type Stop = {
    frame: number
    kicker: string
    title: string
    body: string
    align?: 'end' | 'center'
  }

  const TOTAL_FRAMES = 180
  const KEYFRAMES = [1, 36, 72, 108, 144, 180]

  const STOPS: Stop[] = [
    {
      frame: 1,
      kicker: 'Drop #1 · Spring 2026',
      title: 'Not for everyone.\nOn purpose.',
      body:
        'Rabbit is a designer figure cast in matte resin, hand-finished one at a time. ' +
        'Ten pieces in the first drop. Then the molds retire.',
      align: 'center'
    },
    {
      frame: 36,
      kicker: '02 — Meet Rabbit',
      title: 'Hi. I\'m Rabbit.',
      body:
        'Hand-finished in soft-touch matte — even your bad shelf photos will look composed. ' +
        'There are 9 other ones somewhere on this planet. ' +
        'We know where 8 of them are.'
    },
    {
      frame: 72,
      kicker: '03 — In the details',
      title: 'Stitched, not printed.',
      body:
        'Every seam was cut into the master sculpt by hand before molding — eight hours of work ' +
        'for a detail most people will never see straight on. ' +
        'The studio suggested skipping it. The artist did not.',
      align: 'center'
    },
    {
      frame: 108,
      kicker: '04 — The mark',
      title: 'Carrot tail.',
      body:
        'The studio signature, worn outside. ' +
        'Numbered underneath, stamped in a place you\'ll only find by accident. ' +
        'Three collectors have already learned that the tail is press-fit. Don\'t be the fourth.',
      align: 'center'
    },
    {
      frame: 144,
      kicker: '05 — Built to wear',
      title: 'Sneakers that scuff.',
      body:
        'Cast in a softer compound on purpose — they catch the dust, the lint, the cat hair ' +
        'so the figure doesn\'t. The toe will scuff in eight months. ' +
        'If yours hasn\'t, you aren\'t taking it down often enough.'
    },
    {
      frame: 180,
      kicker: '06 — Encore',
      title: 'Suit down. See you at the next drop.',
      body:
        'One run. Ten pieces. Numbered underneath, signed inside the box you\'ll throw away anyway. ' +
        'When the last one ships the molds get destroyed on camera. ' +
        'No second drop — only a next character. You\'ll know when you know.'
    }
  ]

  type SideKeyframe = {frame: number; side: number}

  const SIDE_KEYFRAMES: SideKeyframe[] = [
    {frame: 1, side: 0},
    {frame: 36, side: 0},
    {frame: 60, side: 1},
    {frame: 79, side: 1},
    {frame: 108, side: 0},
    {frame: 180, side: 0}
  ]

  function computeRightness(frame: number): number {
    const first = SIDE_KEYFRAMES[0]
    const last = SIDE_KEYFRAMES[SIDE_KEYFRAMES.length - 1]
    if (frame <= first.frame) return first.side
    if (frame >= last.frame) return last.side
    for (let i = 0; i < SIDE_KEYFRAMES.length - 1; i++) {
      const a = SIDE_KEYFRAMES[i]
      const b = SIDE_KEYFRAMES[i + 1]
      if (frame >= a.frame && frame <= b.frame) {
        const t = (frame - a.frame) / (b.frame - a.frame)
        return a.side + (b.side - a.side) * t
      }
    }
    return 0
  }

  function isMobileLayout(): boolean {
    return window.matchMedia('(max-width: 768px)').matches
  }

  function isTouchDevice(): boolean {
    return window.matchMedia('(hover: none) and (pointer: coarse)').matches
  }

  const hdRaw = import.meta.glob('./frames-hd/fly_*.webp', {
    eager: true,
    query: '?url',
    import: 'default'
  }) as Record<string, string>

  const mobileRaw = import.meta.glob('./frames-mobile/fly_*.webp', {
    eager: true,
    query: '?url',
    import: 'default'
  }) as Record<string, string>

  const useMobileFrames = isMobileLayout()
  const sourceRaw = useMobileFrames ? mobileRaw : hdRaw

  const frameUrls: string[] = new Array(TOTAL_FRAMES)
  for (const [path, url] of Object.entries(sourceRaw)) {
    const match = path.match(/fly_(\d{3})\.webp$/)
    if (!match) continue
    const num = parseInt(match[1], 10)
    frameUrls[num - 1] = url
  }

  type FrameImage = HTMLImageElement | ImageBitmap

  const frameImages: (FrameImage | null)[] = new Array(TOTAL_FRAMES).fill(null)

  let canvas: HTMLCanvasElement
  let ctx: CanvasRenderingContext2D | null = null
  let scrollContainer: HTMLElement
  let progress = 0
  let isReady = false
  let isRevealed = false
  let showSwipeHint = false
  let hintTimer: ReturnType<typeof setTimeout> | null = null
  let loadedFraction = 0
  let lastRenderKey = -1

  function dismissSwipeHint() {
    if (hintTimer) {
      clearTimeout(hintTimer)
      hintTimer = null
    }
    showSwipeHint = false
  }

  async function loadImage(url: string): Promise<FrameImage | null> {
    if (typeof createImageBitmap !== 'undefined') {
      try {
        const resp = await fetch(url)
        if (resp.ok) {
          const blob = await resp.blob()
          return await createImageBitmap(blob)
        }
      } catch {
        // fall through to HTMLImageElement fallback
      }
    }
    return new Promise((resolve) => {
      const img = new Image()
      img.decoding = 'async'
      img.onload = () => resolve(img)
      img.onerror = () => resolve(null)
      img.src = url
    })
  }

  function priorityOrder(total: number): number[] {
    const loaded = new Set<number>([0])
    const order: number[] = []
    for (const stride of [90, 45, 22, 11, 5, 2, 1]) {
      for (let i = stride; i < total; i += stride) {
        if (!loaded.has(i)) {
          loaded.add(i)
          order.push(i)
        }
      }
    }
    return order
  }

  async function preload() {
    let done = 0
    const total = TOTAL_FRAMES

    function tick() {
      done++
      loadedFraction = done / total
    }

    // Critical: frame 1. Show the page as soon as it resolves.
    if (frameUrls[0]) {
      const img = await loadImage(frameUrls[0])
      frameImages[0] = img
      tick()
    }
    isReady = true
    render(true)
    setTimeout(() => {
      isRevealed = true
    }, 1000)

    // Background: load by priority — coarse strides first so the whole
    // flythrough is scrubbable as soon as ~12 frames have arrived.
    for (const i of priorityOrder(TOTAL_FRAMES)) {
      const url = frameUrls[i]
      if (!url) {
        tick()
        continue
      }
      loadImage(url).then((img) => {
        frameImages[i] = img
        tick()
        lastRenderKey = -1
        render()
      })
    }
  }

  function pickImage(frameIdx: number): FrameImage | null {
    if (frameImages[frameIdx]) return frameImages[frameIdx]

    for (let off = 1; off < TOTAL_FRAMES; off++) {
      const a = frameIdx - off
      const b = frameIdx + off
      if (a >= 0 && frameImages[a]) return frameImages[a]
      if (b < TOTAL_FRAMES && frameImages[b]) return frameImages[b]
    }
    return null
  }

  function render(force = false) {
    if (!ctx || !canvas) return
    const maxIdx = TOTAL_FRAMES - 1
    const exactFrame = Math.min(maxIdx, Math.max(0, progress * maxIdx))
    const frameIdx = Math.round(exactFrame)
    if (!force && frameIdx === lastRenderKey) return

    const img = pickImage(frameIdx)
    if (!img) return

    const rect = canvas.getBoundingClientRect()
    const dpr = window.devicePixelRatio || 1
    const targetW = Math.max(1, Math.round(rect.width * dpr))
    const targetH = Math.max(1, Math.round(rect.height * dpr))
    if (canvas.width !== targetW || canvas.height !== targetH) {
      canvas.width = targetW
      canvas.height = targetH
    }

    ctx.clearRect(0, 0, canvas.width, canvas.height)

    const imgAspect = img.width / img.height
    const canvasAspect = canvas.width / canvas.height
    const mobile = isMobileLayout()
    let dw: number
    let dh: number
    if (mobile) {
      if (imgAspect > canvasAspect) {
        dh = canvas.height
        dw = dh * imgAspect
      } else {
        dw = canvas.width
        dh = dw / imgAspect
      }
    } else {
      if (imgAspect > canvasAspect) {
        dw = canvas.width
        dh = dw / imgAspect
      } else {
        dh = canvas.height
        dw = dh * imgAspect
      }
    }
    const centeredDx = (canvas.width - dw) / 2
    const rightDx = canvas.width - dw
    const liveRightness = mobile ? 0 : computeRightness(frameIdx + 1)
    const dx = centeredDx + (rightDx - centeredDx) * liveRightness
    const dy = (canvas.height - dh) / 2

    ctx.drawImage(img, dx, dy, dw, dh)
    lastRenderKey = frameIdx
  }

  let isOverPreorder = false

  function updateOverPreorder() {
    const el = document.getElementById('preorder')
    if (!el) return
    const rect = el.getBoundingClientRect()
    isOverPreorder = rect.top <= 64
  }

  function opacityForStop(stop: Stop): number {
    const stopProgress = (stop.frame - 1) / (TOTAL_FRAMES - 1)
    const dist = Math.abs(progress - stopProgress)
    const fadeWindow = 0.085
    const v = 1 - dist / fadeWindow
    return Math.max(0, Math.min(1, v))
  }

  function scrollToPreorder() {
    const el = document.getElementById('preorder')
    if (!el) return
    el.scrollIntoView({behavior: 'smooth', block: 'start'})
  }

  const ANIM_DURATION_MS = 800
  const TRIGGER_COOLDOWN_MS = 600
  const SWIPE_THRESHOLD_PX = 50
  let currentKeyframeIdx = 0
  let isAnimating = false
  let lastTriggerTime = 0
  let animRafId: number | null = null

  function animateToKeyframe(targetIdx: number) {
    if (isAnimating) return
    if (targetIdx < 0 || targetIdx >= KEYFRAMES.length) return

    const startProgress = progress
    const targetProgress = (KEYFRAMES[targetIdx] - 1) / (TOTAL_FRAMES - 1)
    const distance = targetProgress - startProgress
    if (Math.abs(distance) < 0.001) {
      currentKeyframeIdx = targetIdx
      return
    }

    isAnimating = true
    const startTime = performance.now()

    const step = () => {
      const elapsed = performance.now() - startTime
      const t = Math.min(1, elapsed / ANIM_DURATION_MS)
      progress = startProgress + distance * t
      lastRenderKey = -1
      render()
      if (t < 1) {
        animRafId = requestAnimationFrame(step)
      } else {
        progress = targetProgress
        currentKeyframeIdx = targetIdx
        isAnimating = false
        animRafId = null
        lastRenderKey = -1
        render(true)
      }
    }
    animRafId = requestAnimationFrame(step)
  }

  function handleWheel(e: WheelEvent) {
    dismissSwipeHint()
    const goingDown = e.deltaY > 0
    const maxIdx = KEYFRAMES.length - 1

    // At boundary — allow native scroll to exit the flythrough section
    if (goingDown && currentKeyframeIdx === maxIdx) return
    if (!goingDown && currentKeyframeIdx === 0) return

    e.preventDefault()

    const now = performance.now()
    if (isAnimating || now - lastTriggerTime < TRIGGER_COOLDOWN_MS) return
    lastTriggerTime = now

    animateToKeyframe(currentKeyframeIdx + (goingDown ? 1 : -1))
  }

  let touchStartY = 0
  let touchActive = false

  function handleTouchStart(e: TouchEvent) {
    dismissSwipeHint()
    touchStartY = e.touches[0].clientY
    touchActive = true
  }

  function handleTouchMove(e: TouchEvent) {
    if (!touchActive) return
    const dy = touchStartY - e.touches[0].clientY
    const goingDown = dy > 0
    const maxIdx = KEYFRAMES.length - 1

    if (goingDown && currentKeyframeIdx === maxIdx) return
    if (!goingDown && currentKeyframeIdx === 0) return

    e.preventDefault()

    if (Math.abs(dy) < SWIPE_THRESHOLD_PX) return

    const now = performance.now()
    if (isAnimating || now - lastTriggerTime < TRIGGER_COOLDOWN_MS) return
    lastTriggerTime = now

    animateToKeyframe(currentKeyframeIdx + (goingDown ? 1 : -1))
    touchActive = false
  }

  function handleTouchEnd() {
    touchActive = false
  }

  let resizeRaf: number | null = null
  let scrollRafId = 0
  let onScroll: (() => void) | null = null
  let onResize: (() => void) | null = null

  onMount(() => {
    ctx = canvas.getContext('2d')

    void preload()

    onScroll = () => {
      if (scrollRafId) return
      scrollRafId = requestAnimationFrame(() => {
        scrollRafId = 0
        updateOverPreorder()
      })
    }
    onResize = () => {
      if (resizeRaf !== null) return
      resizeRaf = requestAnimationFrame(() => {
        resizeRaf = null
        render(true)
      })
    }

    render(true)

    window.addEventListener('scroll', onScroll, {passive: true})
    window.addEventListener('resize', onResize)

    scrollContainer.addEventListener('wheel', handleWheel, {passive: false})
    scrollContainer.addEventListener('touchstart', handleTouchStart, {passive: true})
    scrollContainer.addEventListener('touchmove', handleTouchMove, {passive: false})
    scrollContainer.addEventListener('touchend', handleTouchEnd, {passive: true})

    hintTimer = setTimeout(() => {
      showSwipeHint = true
      hintTimer = null
    }, 2500)
  })

  onDestroy(() => {
    if (scrollRafId) cancelAnimationFrame(scrollRafId)
    if (resizeRaf !== null) cancelAnimationFrame(resizeRaf)
    if (animRafId !== null) cancelAnimationFrame(animRafId)
    if (hintTimer) clearTimeout(hintTimer)
    if (onScroll) window.removeEventListener('scroll', onScroll)
    if (onResize) window.removeEventListener('resize', onResize)
    if (scrollContainer) {
      scrollContainer.removeEventListener('wheel', handleWheel)
      scrollContainer.removeEventListener('touchstart', handleTouchStart)
      scrollContainer.removeEventListener('touchmove', handleTouchMove)
      scrollContainer.removeEventListener('touchend', handleTouchEnd)
    }
  })
</script>

<svelte:head>
  <title>Rabbit — designer toy, limited drop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link
    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
    rel="stylesheet"
  >
</svelte:head>

<div class="rabbit-root">
  <RabbitNav onPreorder={scrollToPreorder} inverted={isOverPreorder}/>

  <div class="scroll-story" bind:this={scrollContainer}>
    <div class="scroll-pinned">
      <div class="scroll-pinned-inner">
        <div class="rabbit-canvas-wrap">
          <canvas
            bind:this={canvas}
            class="rabbit-canvas"
            class:rabbit-canvas--ready={isRevealed}
          ></canvas>
        </div>

        <div
          class="rabbit-text-stack"
          class:rabbit-text-stack--revealed={isRevealed}
          style={`--y-progress: ${progress};`}
        >
          {#each STOPS as stop}
            <RabbitSection
              kicker={stop.kicker}
              title={stop.title}
              body={stop.body}
              align={stop.align ?? 'end'}
              opacity={opacityForStop(stop)}
            />
          {/each}
        </div>
      </div>

      {#if !isReady}
        <div class="rabbit-loading" aria-live="polite">
          <div class="rabbit-loading-track">
            <div
              class="rabbit-loading-fill"
              style={`transform: scaleX(${Math.max(0.04, loadedFraction)});`}
            ></div>
          </div>
        </div>
      {/if}
    </div>
  </div>

  <RabbitPreorder/>
</div>

<style>
  :global(html) {
    scroll-behavior: auto;
  }

  .rabbit-root {
    background: #ffffff;
    color: #0a0a0a;
    font-family: 'Inter', system-ui, sans-serif;
  }

  .scroll-story {
    position: relative;
    height: calc(100dvh - 4rem);
    overscroll-behavior: contain;
  }

  .scroll-pinned {
    position: relative;
    height: 100%;
    overflow: hidden;
    background: #ffffff;
  }

  .scroll-pinned-inner {
    position: relative;
    width: 100%;
    height: 100%;
  }

  .rabbit-canvas-wrap {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #ffffff;
  }

  .rabbit-canvas {
    width: 100%;
    height: 100%;
    display: block;
    opacity: 0;
    transform: translateZ(0);
    transition: opacity 1800ms cubic-bezier(0.22, 0.61, 0.36, 1) 500ms;
  }

  .rabbit-canvas--ready {
    opacity: 1;
  }

  .rabbit-text-stack {
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 40dvh;
    pointer-events: none;
    --shift-max: -28dvh;
    transform: translateY(calc(var(--y-progress, 0) * var(--shift-max)));
    opacity: 0;
    transition: opacity 1200ms ease;
  }

  .rabbit-text-stack--revealed {
    opacity: 1;
  }

  @media (max-width: 768px) {
    .rabbit-text-stack {
      --shift-max: 0dvh;
    }
  }

  @media (min-width: 1024px) {
    .rabbit-text-stack {
      right: auto;
      width: 44rem;
      max-width: 55%;
      height: 55dvh;
    }
  }

  .rabbit-loading {
    position: absolute;
    inset: 0;
    background: #ffffff;
    z-index: 20;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 1.25rem;
  }

  .rabbit-loading-track {
    width: min(18rem, 70vw);
    height: 2px;
    background: rgba(0, 0, 0, 0.08);
    overflow: hidden;
  }

  .rabbit-loading-fill {
    height: 100%;
    width: 100%;
    background: #0066ff;
    transform-origin: left center;
    transform: scaleX(0);
    transition: transform 220ms ease-out;
  }
</style>
