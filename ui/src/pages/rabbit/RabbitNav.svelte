<script lang="ts">
  import {onMount, onDestroy} from 'svelte'
  import {cubicOut} from 'svelte/easing'
  import RabbitLogoMark from './RabbitLogoMark.svelte'
  import RabbitLogoText from './RabbitLogoText.svelte'

  function flyCentered(_: Element, params: {y: number; duration?: number}) {
    return {
      duration: params.duration ?? 380,
      easing: cubicOut,
      css: (t: number, u: number) =>
        `transform: translate(-50%, calc(-50% + ${params.y * u}px)); opacity: ${t};`
    }
  }

  export let onPreorder: () => void = () => {}
  export let inverted = false

  const MARK_WIDTH = '2rem'
  const TEXT_WIDTH = '5.6rem'
  const FIRST_DELAY_MS = 10_000
  const INTERVAL_MS = 60_000

  let showMark = true
  let firstTimer: ReturnType<typeof setTimeout> | null = null
  let intervalTimer: ReturnType<typeof setInterval> | null = null

  function clearTimers() {
    if (firstTimer) {
      clearTimeout(firstTimer)
      firstTimer = null
    }
    if (intervalTimer) {
      clearInterval(intervalTimer)
      intervalTimer = null
    }
  }

  function startInterval() {
    intervalTimer = setInterval(() => {
      showMark = !showMark
    }, INTERVAL_MS)
  }

  function handleLogoClick(e: MouseEvent) {
    e.preventDefault()
    clearTimers()
    showMark = !showMark
    startInterval()
  }

  onMount(() => {
    firstTimer = setTimeout(() => {
      showMark = !showMark
      startInterval()
    }, FIRST_DELAY_MS)
  })

  onDestroy(() => {
    clearTimers()
  })
</script>

<nav class="rabbit-nav" class:rabbit-nav--inverted={inverted}>
  <div class="rabbit-nav-inner">
    <button
      type="button"
      class="rabbit-nav-logo"
      aria-label="Toggle Rabbit logo"
      on:click={handleLogoClick}
    >
      <span class="rabbit-nav-logo-stack" style={`width: ${TEXT_WIDTH};`}>
        {#if showMark}
          <span
            class="rabbit-nav-logo-slot"
            in:flyCentered={{y: -20, duration: 420}}
            out:flyCentered={{y: 20, duration: 380}}
          >
            <RabbitLogoMark size={MARK_WIDTH} title=""/>
          </span>
        {:else}
          <span
            class="rabbit-nav-logo-slot"
            in:flyCentered={{y: -20, duration: 420}}
            out:flyCentered={{y: 20, duration: 380}}
          >
            <RabbitLogoText size={TEXT_WIDTH} title=""/>
          </span>
        {/if}
      </span>
    </button>
    <button type="button" class="rabbit-nav-cta" on:click={onPreorder}>
      Pre-order
      <span class="rabbit-nav-cta-arrow" aria-hidden="true">→</span>
    </button>
  </div>
</nav>

<style>
  .rabbit-nav {
    position: sticky;
    top: 0;
    z-index: 40;
    background-color: transparent;
    color: #000;
    transition: color 320ms ease;
  }

  .rabbit-nav--inverted {
    color: #ffffff;
  }

  .rabbit-nav-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1280px;
    margin: 0 auto;
    padding: 0.875rem 1.25rem;
  }

  @media (max-width: 600px) {
    .rabbit-nav-inner {
      padding: 0.75rem 1rem;
    }
  }

  .rabbit-nav-logo {
    appearance: none;
    background: transparent;
    border: none;
    padding: 0;
    margin: 0;
    font: inherit;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    height: 2rem;
    color: inherit;
  }

  .rabbit-nav-logo:focus-visible {
    outline: 2px solid #0066ff;
    outline-offset: 6px;
    border-radius: 4px;
  }

  .rabbit-nav-logo-stack {
    position: relative;
    display: inline-block;
    height: 2rem;
  }

  .rabbit-nav-logo-slot {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: inline-flex;
    align-items: center;
    will-change: opacity, transform;
  }

  .rabbit-nav-cta {
    appearance: none;
    border: none;
    background: #000;
    color: #fff;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.78rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    padding: 0.5rem 0.5rem 0.5rem 1rem;
    border-radius: 999px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.6rem;
    transition:
      background-color 200ms ease,
      transform 200ms ease,
      opacity 320ms ease;
  }

  .rabbit-nav-cta:hover,
  .rabbit-nav-cta:focus-visible {
    background: #1a1a1a;
    transform: translateY(-1px);
    outline: none;
  }

  .rabbit-nav-cta-arrow {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 1.5rem;
    height: 1.5rem;
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.14);
    font-size: 0.85rem;
    line-height: 1;
    transition:
      transform 240ms cubic-bezier(0.4, 0, 0.2, 1),
      background 200ms ease;
  }

  .rabbit-nav-cta:hover .rabbit-nav-cta-arrow,
  .rabbit-nav-cta:focus-visible .rabbit-nav-cta-arrow {
    transform: translateX(3px);
    background: rgba(255, 255, 255, 0.24);
  }

  .rabbit-nav--inverted .rabbit-nav-cta {
    opacity: 0;
    pointer-events: none;
  }
</style>
