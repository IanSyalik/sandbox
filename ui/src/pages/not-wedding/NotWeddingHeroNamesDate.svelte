<script lang="ts">
  export let containerClass = ''
  export let contentClass = ''
</script>

<div class={`text-center ${containerClass}`.trim()}>
  <div class={`relative mb-8 flex items-center justify-center gap-8 text-black ${contentClass}`.trim()}>
    <h1 class="m-0 -mt-38">Jaan</h1>
    <h1 class="absolute left-1/2 top-0 m-0 ml-4 -translate-x-1/2 -translate-y-1/2  !text-[20rem] opacity-40">&</h1>
    <h1 class="m-0 -mt-8">Jana</h1>
  </div>
</div>

<style lang="postcss">
  h1 {
    @apply font-['Rouge_Script'] text-[12rem] leading-[0.92] ;
  }
</style>
