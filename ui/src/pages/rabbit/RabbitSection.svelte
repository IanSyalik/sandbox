<script lang="ts">
  export let kicker = ''
  export let title = ''
  export let body = ''
  export let opacity = 0
  export let align: 'end' | 'center' = 'end'

  $: hidden = opacity < 0.02
</script>

<div
  class="rabbit-section"
  class:rabbit-section--center={align === 'center'}
  class:rabbit-section--hidden={hidden}
  aria-hidden={hidden ? 'true' : 'false'}
  style={`opacity: ${opacity}; transform: translateY(${(1 - opacity) * 18}px);`}
>
  <div class="rabbit-section-card">
    <div class="rabbit-section-kicker">{kicker}</div>
    <h2 class="rabbit-section-title">{title}</h2>
    <p class="rabbit-section-body">{body}</p>
  </div>
</div>

<style>
  .rabbit-section {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    padding: 0 1.25rem max(2rem, env(safe-area-inset-bottom, 2rem));
    pointer-events: none;
    transition: opacity 90ms linear, transform 180ms ease-out;
    will-change: opacity, transform;
  }

  .rabbit-section--center {
    justify-content: center;
    padding: 1.5rem 1.25rem;
  }

  .rabbit-section-card {
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
  }

  @media (max-width: 768px) {
    .rabbit-section,
    .rabbit-section--center {
      justify-content: flex-end;
      padding: 0 1rem max(1.25rem, env(safe-area-inset-bottom, 1.25rem));
    }

    .rabbit-section-card {
      background: rgba(255, 255, 255, 0.55);
      backdrop-filter: blur(60px) saturate(1.8);
      -webkit-backdrop-filter: blur(60px) saturate(1.8);
      border: 1px solid rgba(255, 255, 255, 0.65);
      border-radius: 1.25rem;
      padding: 1.1rem 1.15rem 1.25rem;
      box-shadow: 0 12px 40px -10px rgba(0, 0, 0, 0.25);
    }
  }

  @media (min-width: 1024px) {
    .rabbit-section {
      padding: 0 4rem 4rem;
    }

    .rabbit-section--center {
      padding: 4rem;
    }

    .rabbit-section-card {
      background: rgba(255, 255, 255, 0.65);
      backdrop-filter: blur(20px) saturate(1.4);
      -webkit-backdrop-filter: blur(20px) saturate(1.4);
      border: 1px solid rgba(255, 255, 255, 0.6);
      border-radius: 1rem;
      padding: 1.5rem 1.75rem 1.75rem;
      box-shadow: 0 10px 30px -12px rgba(0, 0, 0, 0.12);
    }
  }

  .rabbit-section--hidden {
    pointer-events: none;
    visibility: hidden;
  }

  .rabbit-section-kicker {
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.75rem;
    font-weight: 600;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: #0066ff;
  }


  .rabbit-section-title {
    margin: 0;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: clamp(1.75rem, 5vw, 4rem);
    font-weight: 700;
    letter-spacing: -0.025em;
    line-height: 1;
    color: #0a0a0a;
    white-space: pre-line;
  }

  .rabbit-section-body {
    margin: 0;
    max-width: 36rem;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: clamp(1rem, 1.3vw, 1.05rem);
    font-weight: 400;
    line-height: 1.65;
    color: #4a4a4a;
  }

</style>
