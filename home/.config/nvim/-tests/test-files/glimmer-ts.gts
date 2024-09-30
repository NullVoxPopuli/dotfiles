import Component from '@glimmer/component';

interface FooSignature {
  Args: {}
  Blocks: [];
  Element: null;
}

class Foo extends Component {
  <template>Hi</template>
}

<template>

  <Foo />
</template>
