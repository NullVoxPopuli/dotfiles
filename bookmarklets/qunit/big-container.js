javascript:(function () {
  let body = document.body;
  let qunitFixture = document.getElementById('qunit-fixture');
  let qunitRoot = document.getElementById('qunit');
  let result = document.getElementById('qunit-testresult');
  let emberContainer = document.getElementById('ember-testing-container');
  let emberTesting = document.getElementById('ember-testing');

  let css = (element, overrides) => Object.assign(element.style, overrides);

  let resultBox = result.getBoundingClientRect();

  css(body, {
    display: 'grid',
    gridTemplateRows: '230px 1fr',
    gridTemplateAreas: `
      'test-info'
      'container'
    `,
    overflowY: 'hidden',
  });

  css(result, {
    gridArea: `test-info`
  });

  css(qunitFixture, {
    gridArea: `container`,
    position: 'static',
  });

  css(emberContainer, {
    position: 'absolute',
    inset: `${resultBox.bottom}px 0 0 0`,
    transform: 'none',
    width: '100%',
    height: '100%',
  });

  css(emberTesting, {
    width: 'auto',
    height: 'auto',
    transform: 'none',
    transformOrigin: 'unset',
  });

  if (!document.getElementById('toggle-container')) {
    let toggleContainer = document.createElement('button');
    toggleContainer.id = 'toggle-container';
    toggleContainer.textContent = 'Toggle Container';
    toggleContainer.addEventListener('click', () => {
      if (qunitFixture.style.display === 'none') {
        return css(qunitFixture, { display: 'block' });
      }
      
      return css(qunitFixture, { display: 'none' });
    });

    css(toggleContainer, {
      position: 'fixed',
      top: '1rem',
      right: '1rem',
      background: 'white',
      borderRadius: '0.25rem',
    });

    document.body.appendChild(toggleContainer);
  }
})()
