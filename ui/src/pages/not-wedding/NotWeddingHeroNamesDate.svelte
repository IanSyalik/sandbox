<script lang="ts">
  export let containerClass = ''
  export let contentClass = ''
</script>

<div class={`text-center  pt-4 pb-7 ${containerClass}`.trim()}>
  <div class={`m-0 relative flex items-center justify-center ${contentClass}`.trim()} style="color: #000;">
    <h1>Jaan Jana</h1>
    <h1 class="absolute left-1/2 top-1/2 !text-[12rem] ml-4 -translate-x-1/2 -translate-y-1/2  opacity-20">&</h1>
  </div>
</div>

<style lang="postcss">
  h1 {
    @apply font-['Rouge_Script'] text-[clamp(4.8rem,11vw,8rem)] leading-[1] !text-[6rem];
  }
</style>
