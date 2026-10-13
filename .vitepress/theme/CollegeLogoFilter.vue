<template>
  <svg class="college-logo-filter" aria-hidden="true" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <filter id="college-logo-night" color-interpolation-filters="sRGB"
        x="0" y="0" width="100%" height="100%" primitiveUnits="objectBoundingBox">
        <!-- Only the lower text region changes. Preserve the emblem and alpha. -->
        <feComponentTransfer in="SourceGraphic" result="inverted">
          <feFuncR type="table" tableValues="1 0" />
          <feFuncG type="table" tableValues="1 0" />
          <feFuncB type="table" tableValues="1 0" />
        </feComponentTransfer>
        <feFlood x="0" y="0.53125" width="1" height="0.46875"
          flood-color="white" result="text-region" />
        <feComposite in="inverted" in2="text-region" operator="in" result="night-text" />
        <feComposite in="SourceGraphic" in2="text-region" operator="out" result="emblem" />
        <feMerge>
          <feMergeNode in="emblem" />
          <feMergeNode in="night-text" />
        </feMerge>
      </filter>
    </defs>
  </svg>
</template>

<style scoped>
.college-logo-filter {
  position: absolute;
  width: 0;
  height: 0;
  pointer-events: none;
}
</style>
