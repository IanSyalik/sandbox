<script lang="ts">
  import {onMount} from 'svelte'

  import locationPhoto from './wedd graphics.webp'

  let locationSectionElement: HTMLElement | null = null
  let locationOverlayOpacity = 1

  onMount(() => {
    let frameId = 0

    const updateOverlayOpacity = () => {
      frameId = 0

      if (!locationSectionElement) {
        return
      }

      const rect = locationSectionElement.getBoundingClientRect()
      const viewportHeight = window.innerHeight
      const fadeStart = viewportHeight * 0.5
      const fadeEnd = -rect.height * 0.0015
      const progress = (fadeStart - rect.top) / (fadeStart - fadeEnd)
      const clampedProgress = Math.min(Math.max(progress, 0), 1)

      locationOverlayOpacity = 1 - clampedProgress
    }

    const onScroll = () => {
      if (frameId) {
        return
      }

      frameId = window.requestAnimationFrame(updateOverlayOpacity)
    }

    updateOverlayOpacity()
    window.addEventListener('scroll', onScroll, {passive: true})
    window.addEventListener('resize', onScroll)

    return () => {
      if (frameId) {
        window.cancelAnimationFrame(frameId)
      }

      window.removeEventListener('scroll', onScroll)
      window.removeEventListener('resize', onScroll)
    }
  })
</script>

<section
  id="location"
  class="nw-section relative overflow-hidden lg:py-20 p-0"
  bind:this={locationSectionElement}
  style={`background-image: url(${locationPhoto}); background-position: 50% 50%; background-size: cover;`}
>
  <div
    aria-hidden="true"
    class="pointer-events-none absolute inset-0 z-0 bg-nw-900"
    style={`opacity: ${locationOverlayOpacity};`}
  ></div>

  <div class="lg:nw-page-inner relative flex min-h-[50rem] items-end justify-center lg:items-center">

    <div
      class="nw-glass-card w-full max-w-none px-5 py-6 text-center lg:max-w-[36rem] lg:rounded-[1.75rem] lg:px-8 lg:py-8 md:px-10"
    >
      <h2 class="nw-section-title lg:mb-2">
        Location</h2>
      <p class="nw-body-text mb-4 lg:mb-4">
        Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
      </p>
      <p class="m-0 mb-1">
        <a
          href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
          target="_blank"
          rel="noreferrer"
          class="nw-font-link group inline-flex text-[1.2rem] items-center gap-3 border-b border-[color-mix(in_srgb,var(--color-nw-900)_28%,transparent)] pb-1 text-nw-900 transition-all duration-200 hover:border-nw-700 hover:text-nw-700"
        >
          <span>Yayaki House, Narva mnt 7, 2 этаж</span>
          <span aria-hidden="true" class="text-[1rem] leading-none transition-transform duration-200 group-hover:translate-x-0.5 group-focus-visible:translate-x-0.5">
            ↗
          </span>
        </a>
      </p>
    </div>
  </div>
</section>
