<script lang="ts">
  import soleLogo from './sole-logo.jpg?url'
  import RabbitLogoMark from './RabbitLogoMark.svelte'

  let isPreordered = false

  function handlePreorder() {
    isPreordered = true
  }
</script>

<section id="preorder" class="rabbit-preorder">
  <div class="rabbit-preorder-split">
    <div
      class="rabbit-preorder-image"
      style={`background-image: url(${soleLogo});`}
      role="img"
      aria-label="Rabbit sneaker sole, etched with the studio mark and the figure number"
    ></div>

    <div class="rabbit-preorder-copy">
      <div class="rabbit-preorder-kicker">Drop #1 · Spring 2026</div>
      <h2 class="rabbit-preorder-title">
        Ten pieces.<br>One yours.
      </h2>
      <p class="rabbit-preorder-body">
        Drop #1 is ten figures, hand-finished one at a time. Each carries
        its serial number cast into the sole — cut into the master sneaker
        before molding, so nothing peels and nothing transfers. Yours will
        be 0X of 10. We'll tell you which one after the queue closes,
        and never again.
      </p>
      <p class="rabbit-preorder-body">
        Pre-order is a queue, not a sale. Leave an email, we write back when
        the window opens, you have 48 hours. One per address — we check.
        Resale at MSRP is the right thing to do. Resale above is between you
        and your therapist.
      </p>

      {#if !isPreordered}
        <button type="button" class="rabbit-preorder-button" on:click={handlePreorder}>
          <span class="rabbit-preorder-button-label">Pre-order</span>
          <span aria-hidden="true" class="rabbit-preorder-arrow">→</span>
        </button>
      {:else}
        <div class="rabbit-preorder-thanks" role="status" aria-live="polite">
          <div class="rabbit-preorder-thanks-mark" aria-hidden="true">✓</div>
          <div>
            <div class="rabbit-preorder-thanks-title">You're on the list.</div>
            <div class="rabbit-preorder-thanks-body">
              We won't email you about anything else. There isn't anything else.
            </div>
          </div>
        </div>
      {/if}

      <div class="rabbit-preorder-meta">
        <div class="rabbit-preorder-meta-row">
          <span class="rabbit-preorder-meta-key">Material</span>
          <span class="rabbit-preorder-meta-val">Hand-finished resin · soft-touch matte</span>
        </div>
        <div class="rabbit-preorder-meta-row">
          <span class="rabbit-preorder-meta-key">Run</span>
          <span class="rabbit-preorder-meta-val">10 numbered pieces · no second drop</span>
        </div>
        <div class="rabbit-preorder-meta-row">
          <span class="rabbit-preorder-meta-key">Ships</span>
          <span class="rabbit-preorder-meta-val">Q4 2026, packed in Tallinn</span>
        </div>
      </div>
    </div>
  </div>

  <footer class="rabbit-footer">
    <div class="rabbit-footer-inner">
      <span class="rabbit-footer-text">No Instagram, on purpose</span>
      <RabbitLogoMark size="1.5rem" title="Studio Rabbit"/>
      <span class="rabbit-footer-text">One man army studio © · 2026</span>
    </div>
  </footer>
</section>

<style>
  .rabbit-preorder {
    background: #000;
    color: #fff;
  }

  .rabbit-preorder-split {
    display: grid;
    grid-template-columns: 1fr;
  }

  .rabbit-preorder-image {
    width: 100%;
    aspect-ratio: 9 / 16;
    background-color: #161616;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
  }

  .rabbit-preorder-copy {
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
    text-align: left;
    padding: clamp(3rem, 10vh, 6rem) 1.25rem 0;
  }

  .rabbit-preorder-kicker {
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.75rem;
    font-weight: 600;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: #0066ff;
  }

  .rabbit-preorder-title {
    margin: 0;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: clamp(2.5rem, 6.5vw, 5.5rem);
    font-weight: 700;
    letter-spacing: -0.035em;
    line-height: 0.95;
  }

  .rabbit-preorder-body {
    margin: 0;
    max-width: 36rem;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 1rem;
    line-height: 1.65;
    color: #a8a8a8;
  }

  .rabbit-preorder-button {
    appearance: none;
    border: none;
    background:
      linear-gradient(135deg, #0066ff 0%, #003ad6 100%);
    color: #fff;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.95rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    padding: 1.15rem 1.4rem 1.15rem 2rem;
    border-radius: 999px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 1rem;
    align-self: flex-start;
    margin-top: 0.75rem;
    position: relative;
    overflow: hidden;
    isolation: isolate;
    box-shadow:
      0 12px 44px rgba(0, 102, 255, 0.35),
      inset 0 1px 0 rgba(255, 255, 255, 0.22);
    transition:
      transform 220ms cubic-bezier(0.4, 0, 0.2, 1),
      box-shadow 220ms ease;
  }

  .rabbit-preorder-button::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(
      110deg,
      transparent 30%,
      rgba(255, 255, 255, 0.22) 50%,
      transparent 70%
    );
    transform: translateX(-100%);
    transition: transform 900ms cubic-bezier(0.4, 0, 0.2, 1);
    z-index: -1;
    pointer-events: none;
  }

  .rabbit-preorder-button:hover,
  .rabbit-preorder-button:focus-visible {
    transform: translateY(-2px);
    box-shadow:
      0 16px 56px rgba(0, 102, 255, 0.5),
      inset 0 1px 0 rgba(255, 255, 255, 0.28);
    outline: none;
  }

  .rabbit-preorder-button:hover::before,
  .rabbit-preorder-button:focus-visible::before {
    transform: translateX(100%);
  }

  .rabbit-preorder-arrow {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 2rem;
    height: 2rem;
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.16);
    font-size: 0.95rem;
    line-height: 1;
    transition:
      transform 260ms cubic-bezier(0.4, 0, 0.2, 1),
      background 200ms ease;
  }

  .rabbit-preorder-button:hover .rabbit-preorder-arrow,
  .rabbit-preorder-button:focus-visible .rabbit-preorder-arrow {
    transform: translateX(4px);
    background: rgba(255, 255, 255, 0.28);
  }

  .rabbit-preorder-thanks {
    display: flex;
    align-items: flex-start;
    gap: 1rem;
    padding: 1.25rem 1.5rem;
    border: 1px solid rgba(255, 255, 255, 0.16);
    border-radius: 1rem;
    background: rgba(255, 255, 255, 0.03);
    align-self: flex-start;
    max-width: 32rem;
    margin-top: 0.5rem;
  }

  .rabbit-preorder-thanks-mark {
    width: 1.75rem;
    height: 1.75rem;
    border-radius: 999px;
    background: #0066ff;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.95rem;
    font-weight: 700;
    flex-shrink: 0;
  }

  .rabbit-preorder-thanks-title {
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 1rem;
    font-weight: 600;
    color: #fff;
  }

  .rabbit-preorder-thanks-body {
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.875rem;
    color: #a8a8a8;
    margin-top: 0.2rem;
  }

  .rabbit-preorder-meta {
    margin-top: 2rem;
    border-top: 1px solid rgba(255, 255, 255, 0.12);
    padding-top: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 0.85rem;
    padding-bottom: 1rem;
  }

  .rabbit-preorder-meta-row {
    display: flex;
    gap: 1.5rem;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.875rem;
  }

  .rabbit-preorder-meta-key {
    flex: 0 0 6rem;
    color: #6f6f6f;
    text-transform: uppercase;
    letter-spacing: 0.14em;
    font-size: 0.72rem;
    padding-top: 0.15rem;
  }

  .rabbit-preorder-meta-val {
    color: #e6e6e6;
  }

  .rabbit-footer {
    border-top: 1px solid rgba(255, 255, 255, 0.08);
  }

  .rabbit-footer-inner {
    max-width: 64rem;
    margin: 0 auto;
    padding: 1rem;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 1.25rem;
    color: #6f6f6f;
  }

  .rabbit-footer-text {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 0.75rem;
    letter-spacing: 0.04em;
    line-height: 1.4;
  }

  @media (min-width: 900px) {
    .rabbit-preorder-split {
      grid-template-columns: 50vw 1fr;
      align-items: stretch;
      height: 100vh;
    }

    .rabbit-preorder-image {
      width: 100%;
      height: 100%;
      aspect-ratio: auto;
    }

    .rabbit-preorder-copy {
      justify-content: center;
      padding: clamp(2.5rem, 6vh, 4rem) clamp(2rem, 5vw, 5rem);
      overflow: hidden;
    }
  }
</style>
