<style lang="postcss">
  @reference "./../../global.css";

  h1 {
    @apply font-['Rouge_Script'] leading-[1] !text-[4rem] text-transparent px-1 py-0.5;
    background-image: linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-700) 92%, transparent) 0%,
      var(--color-nw-600) 62%,
      var(--color-nw-700) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
  }
</style>

<script lang="ts">
  export let containerClass = ''
  export let contentClass = ''
</script>

<div class={` text-center ${containerClass}`.trim()}>
  <div class={`relative m-0 flex items-center justify-center text-nw-900 ${contentClass}`.trim()}>
    <h1>Jaan Jana</h1>
    <h1 class="absolute left-1/2 top-1/2 ml-4 -translate-x-1/2 -translate-y-1/2 !text-[8rem] opacity-40">&</h1>
  </div>
</div>
