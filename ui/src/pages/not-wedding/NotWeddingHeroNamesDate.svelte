<script lang="ts">
  export let containerClass = ''
  export let contentClass = ''
</script>

<div class={`text-center ${containerClass}`.trim()}>
  <div class={`relative m-0 flex items-center justify-center text-black ${contentClass}`.trim()}>
    <h1>Jaan Jana</h1>
    <h1 class="absolute left-1/2 top-1/2 ml-4 -translate-x-1/2 -translate-y-1/2 !text-[8rem] opacity-20">&</h1>
  </div>
</div>

<style lang="postcss">
  h1 {
    @apply font-['Rouge_Script'] leading-[1] !text-[4rem];
  }
</style>
