import Component from '@glimmer/component';

interface FooSignature {
  Args: {}
  Blocks: [];
  Element: null;
}

class Foo extends Component {
  <template>Hi</template>
}

const two = 2;

<template>
  <Foo />

  {{two}}

  {{#let two as |two|}}
    {{two}}
  {{/let}}

  <Foo>
    <:hello>

    </:hello>
    <:there as |huh|>
      <div {{huh}}>
        <p>hi</p>
      </div>
    </there>
  </Foo>
</template>
