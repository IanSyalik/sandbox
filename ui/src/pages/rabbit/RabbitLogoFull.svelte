<script lang="ts">
  import RabbitLogoMark from './RabbitLogoMark.svelte'
  import RabbitLogoText from './RabbitLogoText.svelte'

  export let size: string = '1em'
  export let title: string = 'Rabbit'
  export let textScale: number = 0.85
</script>

<span
  class="rabbit-logo-full"
  role="img"
  aria-label={title}
  style={`width: ${size};`}
>
  <RabbitLogoMark size="100%" title=""/>
  <RabbitLogoText size={`${textScale * 100}%`} title=""/>
</span>

<style>
  .rabbit-logo-full {
    display: inline-flex;
    flex-direction: column;
    align-items: center;
    gap: 0.4em;
    line-height: 0;
    color: currentColor;
  }
</style>
