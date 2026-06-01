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

  const TOTAL_FRAMES = 360
  const KEYFRAMES = [1, 72, 144, 216, 288, 360]

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
      frame: 72,
      kicker: '02 — Meet Rabbit',
      title: 'Hi. I\'m Rabbit.',
      body:
        'Hand-finished in soft-touch matte — even your bad shelf photos will look composed. ' +
        'There are 9 other ones somewhere on this planet. ' +
        'We know where 8 of them are.'
    },
    {
      frame: 144,
      kicker: '03 — In the details',
      title: 'Stitched, not printed.',
      body:
        'Every seam was cut into the master sculpt by hand before molding — eight hours of work ' +
        'for a detail most people will never see straight on. ' +
        'The studio suggested skipping it. The artist did not.',
      align: 'center'
    },
    {
      frame: 216,
      kicker: '04 — The mark',
      title: 'Carrot tail.',
      body:
        'The studio signature, worn outside. ' +
        'Numbered underneath, stamped in a place you\'ll only find by accident. ' +
        'Three collectors have already learned that the tail is press-fit. Don\'t be the fourth.',
      align: 'center'
    },
    {
      frame: 288,
      kicker: '05 — Built to wear',
      title: 'Sneakers that scuff.',
      body:
        'Cast in a softer compound on purpose — they catch the dust, the lint, the cat hair ' +
        'so the figure doesn\'t. The toe will scuff in eight months. ' +
        'If yours hasn\'t, you aren\'t taking it down often enough.'
    },
    {
      frame: 360,
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
    {frame: 72, side: 0},
    {frame: 120, side: 1},
    {frame: 158, side: 1},
    {frame: 216, side: 0},
    {frame: 360, side: 0}
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

  const lowRaw = import.meta.glob('./frames/fly_*.jpg', {
    eager: true,
    query: '?url',
    import: 'default'
  }) as Record<string, string>

  const lowResUrls: string[] = new Array(TOTAL_FRAMES)
  const hiResUrls: Record<number, string> = {}

  for (const [path, url] of Object.entries(lowRaw)) {
    const match = path.match(/fly_(\d{3})(@hi)?\.jpg$/)
    if (!match) continue
    const num = parseInt(match[1], 10)
    if (match[2]) hiResUrls[num] = url
    else lowResUrls[num - 1] = url
  }

  const lowImages: (HTMLImageElement | null)[] = new Array(TOTAL_FRAMES).fill(null)
  const hiImages: Record<number, HTMLImageElement> = {}

  let canvas: HTMLCanvasElement
  let ctx: CanvasRenderingContext2D | null = null
  let scrollContainer: HTMLElement
  let progress = 0
  let isReady = false
  let isRevealed = false
  let loadedFraction = 0

  function loadImage(url: string): Promise<HTMLImageElement | null> {
    return new Promise((resolve) => {
      const img = new Image()
      img.decoding = 'async'
      img.onload = () => resolve(img)
      img.onerror = () => resolve(null)
      img.src = url
    })
  }

  async function preload() {
    let done = 0
    const total = TOTAL_FRAMES + KEYFRAMES.length

    function tick() {
      done++
      loadedFraction = done / total
    }

    // Critical: frame 1 low-res + all 6 hi-res. Show the page as soon as these resolve.
    const criticalTasks: Promise<unknown>[] = []
    if (lowResUrls[0]) {
      criticalTasks.push(
        loadImage(lowResUrls[0]).then((img) => {
          lowImages[0] = img
          tick()
        })
      )
    }
    for (const kf of KEYFRAMES) {
      const url = hiResUrls[kf]
      if (url) {
        criticalTasks.push(
          loadImage(url).then((img) => {
            if (img) hiImages[kf] = img
            tick()
          })
        )
      }
    }
    await Promise.all(criticalTasks)
    isReady = true
    render()
    setTimeout(() => {
      isRevealed = true
    }, 1000)

    // Background: rest of the low-res frames. Render as they arrive.
    for (let i = 1; i < TOTAL_FRAMES; i++) {
      const url = lowResUrls[i]
      if (!url) {
        tick()
        continue
      }
      loadImage(url).then((img) => {
        lowImages[i] = img
        tick()
        render()
      })
    }
  }

  function pickImage(frameIdx: number): HTMLImageElement | null {
    const frameNum = frameIdx + 1

    if (hiImages[frameNum]) return hiImages[frameNum]

    let nearestKeyframe: number | null = null
    let nearestDist = Infinity
    for (const kf of KEYFRAMES) {
      const d = Math.abs(frameNum - kf)
      if (d < nearestDist) {
        nearestDist = d
        nearestKeyframe = kf
      }
    }
    if (nearestKeyframe !== null && nearestDist <= 1 && hiImages[nearestKeyframe]) {
      return hiImages[nearestKeyframe]
    }

    if (lowImages[frameIdx]) return lowImages[frameIdx]

    for (let off = 1; off < TOTAL_FRAMES; off++) {
      const a = frameIdx - off
      const b = frameIdx + off
      if (a >= 0 && lowImages[a]) return lowImages[a]
      if (b < TOTAL_FRAMES && lowImages[b]) return lowImages[b]
    }
    return null
  }

  function render() {
    if (!ctx || !canvas) return
    const frameIdx = Math.min(TOTAL_FRAMES - 1, Math.max(0, Math.round(progress * (TOTAL_FRAMES - 1))))
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

    const imgAspect = img.naturalWidth / img.naturalHeight
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
  }

  function computeProgress() {
    if (!scrollContainer) return
    const rect = scrollContainer.getBoundingClientRect()
    const total = scrollContainer.offsetHeight - window.innerHeight
    if (total <= 0) {
      progress = rect.top <= 0 ? 1 : 0
      return
    }
    const scrolled = -rect.top
    progress = Math.min(1, Math.max(0, scrolled / total))
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

  const SNAP_THRESHOLD = 5
  const SNAP_DURATION_MS = 1400
  let isAutoScrolling = false
  let snapRafId: number | null = null
  let autoScrollTimer: ReturnType<typeof setTimeout> | null = null
  let prevSnapFrame = 1

  function easeInOutCubic(t: number): number {
    return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2
  }

  function smoothScrollTo(targetY: number, duration: number) {
    if (snapRafId !== null) cancelAnimationFrame(snapRafId)
    const startY = window.scrollY
    const distance = targetY - startY
    const startTime = performance.now()

    const step = () => {
      const elapsed = performance.now() - startTime
      const t = Math.min(1, elapsed / duration)
      const eased = easeInOutCubic(t)
      window.scrollTo({top: startY + distance * eased, behavior: 'instant'})
      if (t < 1) {
        snapRafId = requestAnimationFrame(step)
      } else {
        snapRafId = null
      }
    }
    snapRafId = requestAnimationFrame(step)
  }

  function snapToFrame(targetFrame: number) {
    if (!scrollContainer) return
    isAutoScrolling = true
    prevSnapFrame = targetFrame
    const targetProgress = (targetFrame - 1) / (TOTAL_FRAMES - 1)
    const total = scrollContainer.offsetHeight - window.innerHeight
    const rect = scrollContainer.getBoundingClientRect()
    const containerAbsoluteTop = window.scrollY + rect.top
    const targetScrollY = containerAbsoluteTop + targetProgress * total
    smoothScrollTo(targetScrollY, SNAP_DURATION_MS)
    if (autoScrollTimer) clearTimeout(autoScrollTimer)
    autoScrollTimer = setTimeout(() => {
      isAutoScrolling = false
      autoScrollTimer = null
    }, SNAP_DURATION_MS + 100)
  }

  function snapToPreorder() {
    const el = document.getElementById('preorder')
    if (!el) return
    isAutoScrolling = true
    prevSnapFrame = TOTAL_FRAMES
    const rect = el.getBoundingClientRect()
    const targetY = window.scrollY + rect.top
    smoothScrollTo(targetY, SNAP_DURATION_MS)
    if (autoScrollTimer) clearTimeout(autoScrollTimer)
    autoScrollTimer = setTimeout(() => {
      isAutoScrolling = false
      autoScrollTimer = null
    }, SNAP_DURATION_MS + 100)
  }

  let lastScrollY = 0

  function checkAutoSnap(frame: number) {
    if (isAutoScrolling) return
    if (isTouchDevice()) return
    const goingForward = frame > prevSnapFrame
    const goingBackward = frame < prevSnapFrame
    prevSnapFrame = frame

    const goingDown = window.scrollY > lastScrollY + 1
    lastScrollY = window.scrollY

    for (let i = 0; i < KEYFRAMES.length - 1; i++) {
      const kf = KEYFRAMES[i]
      const next = KEYFRAMES[i + 1]
      if (goingForward && frame >= kf + SNAP_THRESHOLD && frame < next) {
        snapToFrame(next)
        return
      }
      if (goingBackward && frame <= next - SNAP_THRESHOLD && frame > kf) {
        snapToFrame(kf)
        return
      }
    }

    if (goingDown && !isOverPreorder && scrollContainer) {
      const storyEnd = scrollContainer.offsetTop + scrollContainer.offsetHeight - window.innerHeight
      if (window.scrollY >= storyEnd - 4) {
        snapToPreorder()
      }
    }
  }

  let rafId = 0
  let onScroll: (() => void) | null = null
  let onResize: (() => void) | null = null

  onMount(() => {
    ctx = canvas.getContext('2d')

    void preload()

    const update = () => {
      rafId = 0
      computeProgress()
      render()
      updateOverPreorder()
      const frameIdx = Math.min(
        TOTAL_FRAMES - 1,
        Math.max(0, Math.round(progress * (TOTAL_FRAMES - 1)))
      )
      checkAutoSnap(frameIdx + 1)
    }
    onScroll = () => {
      if (rafId) return
      rafId = requestAnimationFrame(update)
    }
    onResize = () => {
      computeProgress()
      render()
    }

    computeProgress()
    render()

    window.addEventListener('scroll', onScroll, {passive: true})
    window.addEventListener('resize', onResize)
  })

  onDestroy(() => {
    if (rafId) cancelAnimationFrame(rafId)
    if (snapRafId !== null) cancelAnimationFrame(snapRafId)
    if (autoScrollTimer) clearTimeout(autoScrollTimer)
    if (onScroll) window.removeEventListener('scroll', onScroll)
    if (onResize) window.removeEventListener('resize', onResize)
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
    height: 700vh;
  }

  @media (max-width: 768px) {
    .scroll-story {
      height: 400dvh;
    }
  }

  .scroll-pinned {
    position: sticky;
    top: 0;
    height: 100dvh;
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
      --shift-max: -12dvh;
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
